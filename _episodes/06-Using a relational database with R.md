---
title: "Using a relational database with R"
teaching: 0
exercises: 0
questions:
- "How can I import data held in an SQLite database into an R data frame?"
- "How can I write data from a data frame to an SQLite table?"
- "How can I create an SQLite database from csv files"

objectives:
- "Install RSQLite package"
- "Create a connection to an SQLite database"
- "Query the database"
- "Create a new databaseand populate it"
- "Use dplyr functions to access and query an SQLite database"

keypoints:
- "First key point."
---

## Introduction

So far, we have dealt with small datasets that easily fit into your computer's memory. But what about datasets that are too large for your computer to handle as a whole? In this case, storing the data outside of R and organizing it in a database is helpful. 

By creating a connection to a database, SQL queries can be be sent directly to the database and only the results are returned to the R environment.

We shall be using an SQLite database and we can connect to in such a way as to allow us to send strings containing SQL statements directly and get the results . Additionally we can connect to the database in such a was as to allow 'dplyr' functions to operate directly on the database tables.

This addresses a common problem with R in that all operations are conducted
in-memory and thus the amount of data you can work with is limited by available
memory. The database connections essentially remove that limitation in that you
can connect to a database of many hundreds of GB, conduct queries on it directly, and pull
back into R only what you need for analysis.

Once we have made the connectio, much of what we do will look very familiar as the coding is very similar to what we saw in the SQL lesson and an early episode of this R lesson.

## Prelminaries 

First of all we will install the libraries we are going to use. You may need to install the `RSQLite` library with

~~~
install.packages("RSQLite")
~~~

we then need to load the libraries

~~~
library("RSQLite")
library(dplyr)
~~~

and create a variable to contain the location of the SQLite database we are going to use.

Here we are assuming that it is in the current working directory.

~~~
dbfile <- "SN7577.sqlite"
~~~

## Connecting to an SQLite database using `dbConnect`

This can be done in a single line of code

~~~
mydb <- dbConnect(dbDriver("SQLite"), dbfile)
~~~

'mydb' represents the connection to the database. It will be specified everytime we need to access the database.

Now that we have a connection we can start writing queries. But first lets get a list of the tables in the database.

~~~
dbListTables(mydb)
~~~

To get data requires us to send a query to the database and then ask for the results 

~~~
 # Assign the results of a SQL query to an SQLiteResult object
results <- dbSendQuery(mydb, "SELECT * FROM Question1")

 # Return results from a custom object to a data.frame
data = fetch(results)
~~~

`data` is a standard R dataframe which we can manipulate in the usual ways.

~~~
names(data)
str(data)

data[,2]

data[4,2]
data[data$key > 7,2]
~~~

Once you have retrieved the data you should close the connection.

~~~
dbClearResult(results)
~~~

In addition to sending simple queries we can send complex one like a join.
You may want to set this up in a concateneted string first for readability

~~~
SQL_query <- paste("SELECT q.value,",
                   "count(*) as how_many",
                   "FROM SN7577 s",
                   "JOIN Question1  q",
                   "ON q.key = s.Q1",
                   "GROUP BY  s.Q1")

results <- dbSendQuery(mydb, SQL_query)

data = fetch(results)

data

dbClearResult(results)


~~~

> ## Exercise
>
> What happens if you send invalid SQL?
> 
> > ## Solution
> > 
> > An error message is reurned from SQLite, R is just the conduit, it cannot check the SQL syntax.
> > 
> > 
> {: .solution}
{: .challenge}


We can also create a new database and add tables to it

~~~

# first use the existing connection to put the Question1 table into a dataframe

results = dbSendQuery(mydb, "SELECT * from Question1")
Q1 <- fetch(results)
~~~

Now we create the new database and add data to it, either from an external file of from a local dataframe.

~~~

dbfile_new = "a_newdb.sqlite"
mydb_new = dbConnect(dbDriver("SQLite"), dbfile_new)

dbWriteTable(conn = mydb_new , name = "SN7577", value = "SN7577.csv", 
             row.names = FALSE, header = TRUE)

dbWriteTable(conn = mydb_new , name = "Q1", value = Q1, 
             row.names = FALSE)

dbListTables(mydb_new)
~~~

## Connecting to a database for `dplyr` use

When we want to use `dplyr` to access a database the a different connection method is used.

~~~
mydb_dplyr <- src_sqlite(path="SN7577.sqlite")
~~~

as is the mthod for running queries. However using the 'tbl' functionwe still need to provide avalid SQL string.

~~~
tbl(mydb_dplyr, sql("SELECT count(*) from SN7577"))
~~~

The real advantage of using the `dplyr` interface is however, that we can use the `dplyr` methods as a substitute for the SQL statements once we have downloaded the table.

~~~
SN7577_d <- tbl(mydb_dplyr, sql("SELECT * FROM SN7577"))

SN7577_d %>%
  filter(numage > 60) %>%
  select(sex, age, numage) %>%
  group_by(sex, age) %>%
  summarize(avg_age = mean(numage))

head(SN7577_d, n = 10)

nrow(SN7577_d)
~~~

Notice that on the `nrow` command we get NA rather than a count of rows. Thisis because `dplyr` doesn't hold the full table even after the 'Select * ...' 

If you need the row count you can use 

~~~
SN7577_d %>%
  tally()
~~~

> ## Exercise
>
> Download the SN7577 table for `dplyr` use
> write a query using dplyr methods which will give the average age (agenum) by sex for all of the records where
> the response for Q2 is missing.
> 
> > ## Solution
> > 
> > SN7577_d <- tbl(mydb_dplyr, sql("SELECT * FROM SN7577"))
> > 
> > ~~~
> > SN7577_d %>%
> >   select(Q2, sex, numage) %>%
> >   filter(Q2 == -1)   %>%
> >   group_by(sex)   %>%
> >   summarize(count = n())
> > ~~~
> > 
> {: .solution}
{: .challenge}

