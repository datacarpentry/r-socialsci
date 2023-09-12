---
title: Data Wrangling with dplyr
teaching: 25
exercises: 15
source: Rmd
---



::::::::::::::::::::::::::::::::::::::: objectives

- Describe the purpose of an R package and the **`dplyr`** package.
- Select certain columns in a dataframe with the **`dplyr`** function `select`.
- Select certain rows in a dataframe according to filtering conditions with the **`dplyr`** function `filter`.
- Link the output of one **`dplyr`** function to the input of another function with the 'pipe' operator `%>%`.
- Add new columns to a dataframe that are functions of existing columns with `mutate`.
- Use the split-apply-combine concept for data analysis.
- Use `summarize`, `group_by`, and `count` to split a dataframe into groups of observations, apply a summary statistics for each group, and then combine the results.

::::::::::::::::::::::::::::::::::::::::::::::::::

:::::::::::::::::::::::::::::::::::::::: questions

- How can I select specific rows and/or columns from a dataframe?
- How can I combine multiple commands into a single command?
- How can I create new columns or remove existing columns from a dataframe?

::::::::::::::::::::::::::::::::::::::::::::::::::

**`dplyr`** is a package for making tabular data wrangling easier by using a
limited set of functions that can be combined to extract and summarize insights
from your data.

Like **`readr`**, **`dplyr`** is a part of the tidyverse. These packages were loaded
in R's memory when we called `library(tidyverse)` earlier.

:::::::::::::::::::::::::::::::::::::::::  callout

## Note

The packages in the tidyverse, namely **`dplyr`**, **`tidyr`** and **`ggplot2`**
accept both the British (e.g. *summarise*) and American (e.g. *summarize*) spelling
variants of different function and option names. For this lesson, we utilize
the American spellings of different functions; however, feel free to use
the regional variant for where you are teaching.

::::::::::::::::::::::::::::::::::::::::::::::::::

## What is an R package?

The package **`dplyr`** provides easy tools for the most common data
wrangling tasks. It is built to work directly with dataframes, with many
common tasks optimized by being written in a compiled language (C++) (not all R
packages are written in R!).

There are also packages available for a wide range of tasks including building plots
(**`ggplot2`**, which we'll see later), downloading data from the NCBI database, or
performing statistical analysis on your data set. Many packages such as these are
housed on, and downloadable from, the **C**omprehensive **R** **A**rchive **N**etwork
(CRAN) using `install.packages`. This function makes the package accessible by your R
installation with the command `library()`, as you did with `tidyverse` earlier.

To easily access the documentation for a package within R or RStudio, use
`help(package = "package_name")`.

To learn more about **`dplyr`** after the workshop, you may want to check out this
[handy data transformation with **`dplyr`** cheatsheet](https://raw.githubusercontent.com/rstudio/cheatsheets/main/data-transformation.pdf).

:::::::::::::::::::::::::::::::::::::::::  callout

## Note

There are alternatives to the `tidyverse` packages for data wrangling, including
the package [`data.table`](https://rdatatable.gitlab.io/data.table/). See this
[comparison](https://mgimond.github.io/rug_2019_12/Index.html)
for example to get a sense of the differences between using `base`, `tidyverse`, and
`data.table`.

::::::::::::::::::::::::::::::::::::::::::::::::::

## Learning **`dplyr`**

To make sure everyone will use the same dataset for this lesson, we'll read
again the SAFI dataset that we downloaded earlier.


```r
## load the tidyverse
library(tidyverse)
library(here)

interviews <- read_csv(here("data", "SAFI_clean.csv"), na = "NULL")

## inspect the data
interviews

## preview the data
# view(interviews)
```

We're going to learn some of the most common **`dplyr`** functions:

- `select()`: subset columns
- `filter()`: subset rows on conditions
- `mutate()`: create new columns by using information from other columns
- `group_by()` and `summarize()`: create summary statistics on grouped data
- `arrange()`: sort results
- `count()`: count discrete values

## Selecting columns and filtering rows

To select columns of a dataframe, use `select()`. The first argument to this
function is the dataframe (`interviews`), and the subsequent arguments are the
columns to keep, separated by commas. Alternatively, if you are selecting
columns adjacent to each other, you can use a `:` to select a range of columns,
read as "select columns from \_\_\_ to \_\_\_." You may have done something similar in
the past using subsetting. `select()` is essentially doing the same thing as
subsetting, using a package (`dplyr`) instead of R's base functions.


```r
# to select columns throughout the dataframe
select(interviews, village, no_membrs, months_lack_food)
# to do the same thing with subsetting
interviews[c("village","no_membrs","months_lack_food")]
# to select a series of connected columns
select(interviews, village:respondent_wall_type)
```

To choose rows based on specific criteria, we can use the `filter()` function.
The argument after the dataframe is the condition we want our final
dataframe to adhere to (e.g. village name is Chirodzo):


```r
# filters observations where village name is "Chirodzo"
filter(interviews, village == "Chirodzo")
```

```{.output}
# A tibble: 39 × 14
   key_ID village  interview_date      no_membrs years_liv respondent_wall_type
    <dbl> <chr>    <dttm>                  <dbl>     <dbl> <chr>               
 1      8 Chirodzo 2016-11-16 00:00:00        12        70 burntbricks         
 2      9 Chirodzo 2016-11-16 00:00:00         8         6 burntbricks         
 3     10 Chirodzo 2016-12-16 00:00:00        12        23 burntbricks         
 4     34 Chirodzo 2016-11-17 00:00:00         8        18 burntbricks         
 5     35 Chirodzo 2016-11-17 00:00:00         5        45 muddaub             
 6     36 Chirodzo 2016-11-17 00:00:00         6        23 sunbricks           
 7     37 Chirodzo 2016-11-17 00:00:00         3         8 burntbricks         
 8     43 Chirodzo 2016-11-17 00:00:00         7        29 muddaub             
 9     44 Chirodzo 2016-11-17 00:00:00         2         6 muddaub             
10     45 Chirodzo 2016-11-17 00:00:00         9         7 muddaub             
# ℹ 29 more rows
# ℹ 8 more variables: rooms <dbl>, memb_assoc <chr>, affect_conflicts <chr>,
#   liv_count <dbl>, items_owned <chr>, no_meals <dbl>, months_lack_food <chr>,
#   instanceID <chr>
```

We can also specify multiple conditions within the `filter()` function. We can
combine conditions using either "and" or "or" statements. In an "and"
statement, an observation (row) must meet **every** criteria to be included
in the resulting dataframe. To form "and" statements within dplyr, we can  pass
our desired conditions as arguments in the `filter()` function, separated by
commas:


```r
# filters observations with "and" operator (comma)
# output dataframe satisfies ALL specified conditions
filter(interviews, village == "Chirodzo",
                   rooms > 1,
                   no_meals > 2)
```

```{.output}
# A tibble: 10 × 14
   key_ID village  interview_date      no_membrs years_liv respondent_wall_type
    <dbl> <chr>    <dttm>                  <dbl>     <dbl> <chr>               
 1     10 Chirodzo 2016-12-16 00:00:00        12        23 burntbricks         
 2     49 Chirodzo 2016-11-16 00:00:00         6        26 burntbricks         
 3     52 Chirodzo 2016-11-16 00:00:00        11        15 burntbricks         
 4     56 Chirodzo 2016-11-16 00:00:00        12        23 burntbricks         
 5     65 Chirodzo 2016-11-16 00:00:00         8        20 burntbricks         
 6     66 Chirodzo 2016-11-16 00:00:00        10        37 burntbricks         
 7     67 Chirodzo 2016-11-16 00:00:00         5        31 burntbricks         
 8     68 Chirodzo 2016-11-16 00:00:00         8        52 burntbricks         
 9    199 Chirodzo 2017-06-04 00:00:00         7        17 burntbricks         
10    200 Chirodzo 2017-06-04 00:00:00         8        20 burntbricks         
# ℹ 8 more variables: rooms <dbl>, memb_assoc <chr>, affect_conflicts <chr>,
#   liv_count <dbl>, items_owned <chr>, no_meals <dbl>, months_lack_food <chr>,
#   instanceID <chr>
```

We can also form "and" statements with the `&` operator instead of commas:


```r
# filters observations with "&" logical operator
# output dataframe satisfies ALL specified conditions
filter(interviews, village == "Chirodzo" &
                   rooms > 1 &
                   no_meals > 2)
```

```{.output}
# A tibble: 10 × 14
   key_ID village  interview_date      no_membrs years_liv respondent_wall_type
    <dbl> <chr>    <dttm>                  <dbl>     <dbl> <chr>               
 1     10 Chirodzo 2016-12-16 00:00:00        12        23 burntbricks         
 2     49 Chirodzo 2016-11-16 00:00:00         6        26 burntbricks         
 3     52 Chirodzo 2016-11-16 00:00:00        11        15 burntbricks         
 4     56 Chirodzo 2016-11-16 00:00:00        12        23 burntbricks         
 5     65 Chirodzo 2016-11-16 00:00:00         8        20 burntbricks         
 6     66 Chirodzo 2016-11-16 00:00:00        10        37 burntbricks         
 7     67 Chirodzo 2016-11-16 00:00:00         5        31 burntbricks         
 8     68 Chirodzo 2016-11-16 00:00:00         8        52 burntbricks         
 9    199 Chirodzo 2017-06-04 00:00:00         7        17 burntbricks         
10    200 Chirodzo 2017-06-04 00:00:00         8        20 burntbricks         
# ℹ 8 more variables: rooms <dbl>, memb_assoc <chr>, affect_conflicts <chr>,
#   liv_count <dbl>, items_owned <chr>, no_meals <dbl>, months_lack_food <chr>,
#   instanceID <chr>
```

In an "or" statement, observations must meet *at least one* of the specified conditions.
To form "or" statements we use the logical operator for "or," which is the vertical bar (|):


```r
# filters observations with "|" logical operator
# output dataframe satisfies AT LEAST ONE of the specified conditions
filter(interviews, village == "Chirodzo" | village == "Ruaca")
```

```{.output}
# A tibble: 88 × 14
   key_ID village  interview_date      no_membrs years_liv respondent_wall_type
    <dbl> <chr>    <dttm>                  <dbl>     <dbl> <chr>               
 1      8 Chirodzo 2016-11-16 00:00:00        12        70 burntbricks         
 2      9 Chirodzo 2016-11-16 00:00:00         8         6 burntbricks         
 3     10 Chirodzo 2016-12-16 00:00:00        12        23 burntbricks         
 4     23 Ruaca    2016-11-21 00:00:00        10        20 burntbricks         
 5     24 Ruaca    2016-11-21 00:00:00         6         4 burntbricks         
 6     25 Ruaca    2016-11-21 00:00:00        11         6 burntbricks         
 7     26 Ruaca    2016-11-21 00:00:00         3        20 burntbricks         
 8     27 Ruaca    2016-11-21 00:00:00         7        36 burntbricks         
 9     28 Ruaca    2016-11-21 00:00:00         2         2 muddaub             
10     29 Ruaca    2016-11-21 00:00:00         7        10 burntbricks         
# ℹ 78 more rows
# ℹ 8 more variables: rooms <dbl>, memb_assoc <chr>, affect_conflicts <chr>,
#   liv_count <dbl>, items_owned <chr>, no_meals <dbl>, months_lack_food <chr>,
#   instanceID <chr>
```

## Pipes

What if you want to select and filter at the same time? There are three
ways to do this: use intermediate steps, nested functions, or pipes.

With intermediate steps, you create a temporary dataframe and use
that as input to the next function, like this:


```r
interviews2 <- filter(interviews, village == "Chirodzo")
interviews_ch <- select(interviews2, village:respondent_wall_type)
```

This is readable, but can clutter up your workspace with lots of objects that
you have to name individually. With multiple steps, that can be hard to keep
track of.

You can also nest functions (i.e. one function inside of another), like this:


```r
interviews_ch <- select(filter(interviews, village == "Chirodzo"),
                         village:respondent_wall_type)
```

This is handy, but can be difficult to read if too many functions are nested, as
R evaluates the expression from the inside out (in this case, filtering, then
selecting).

The last option, *pipes*, are a recent addition to R. Pipes let you take the
output of one function and send it directly to the next, which is useful when
you need to do many things to the same dataset. There are two Pipes in R: 1) `%>%` (called magrittr pipe; made available via the **`magrittr`** package, installed automatically with
**`dplyr`**) or 2) `|>` (called native R pipe and it comes preinstalled with R v4.1.0 onwards). Both the pipes are, by and large, function similarly with a few differences (For more information, check: https://www.tidyverse.org/blog/2023/04/base-vs-magrittr-pipe/). The choice of which pipe to be used can be changed in the Global settings in R studio and once that is done, you can type the pipe with:

- <kbd>Ctrl</kbd> + <kbd>Shift</kbd> + <kbd>M</kbd> if you have a PC or <kbd>Cmd</kbd> +
  <kbd>Shift</kbd> + <kbd>M</kbd> if you have a Mac.


```r
# the following example is run using magrittr pipe but the output will be same with the native pipe
interviews %>%
    filter(village == "Chirodzo") %>%
    select(village:respondent_wall_type)
```

```{.output}
# A tibble: 39 × 5
   village  interview_date      no_membrs years_liv respondent_wall_type
   <chr>    <dttm>                  <dbl>     <dbl> <chr>               
 1 Chirodzo 2016-11-16 00:00:00        12        70 burntbricks         
 2 Chirodzo 2016-11-16 00:00:00         8         6 burntbricks         
 3 Chirodzo 2016-12-16 00:00:00        12        23 burntbricks         
 4 Chirodzo 2016-11-17 00:00:00         8        18 burntbricks         
 5 Chirodzo 2016-11-17 00:00:00         5        45 muddaub             
 6 Chirodzo 2016-11-17 00:00:00         6        23 sunbricks           
 7 Chirodzo 2016-11-17 00:00:00         3         8 burntbricks         
 8 Chirodzo 2016-11-17 00:00:00         7        29 muddaub             
 9 Chirodzo 2016-11-17 00:00:00         2         6 muddaub             
10 Chirodzo 2016-11-17 00:00:00         9         7 muddaub             
# ℹ 29 more rows
```

```r
#interviews |>
#   filter(village == "Chirodzo") |>
#   select(village:respondent_wall_type)
```

In the above code, we use the pipe to send the `interviews` dataset first
through `filter()` to keep rows where `village` is "Chirodzo", then through
`select()` to keep only the columns from `village` to `respondent_wall_type`. Since `%>%`
takes the object on its left and passes it as the first argument to the function
on its right, we don't need to explicitly include the dataframe as an argument
to the `filter()` and `select()` functions any more.

Some may find it helpful to read the pipe like the word "then". For instance,
in the above example, we take the dataframe `interviews`, *then* we `filter`
for rows with `village == "Chirodzo"`, *then* we `select` columns `village:respondent_wall_type`.
The **`dplyr`** functions by themselves are somewhat simple,
but by combining them into linear workflows with the pipe, we can accomplish
more complex data wrangling operations.

If we want to create a new object with this smaller version of the data, we
can assign it a new name:


```r
interviews_ch <- interviews %>%
    filter(village == "Chirodzo") %>%
    select(village:respondent_wall_type)

interviews_ch
```

```{.output}
# A tibble: 39 × 5
   village  interview_date      no_membrs years_liv respondent_wall_type
   <chr>    <dttm>                  <dbl>     <dbl> <chr>               
 1 Chirodzo 2016-11-16 00:00:00        12        70 burntbricks         
 2 Chirodzo 2016-11-16 00:00:00         8         6 burntbricks         
 3 Chirodzo 2016-12-16 00:00:00        12        23 burntbricks         
 4 Chirodzo 2016-11-17 00:00:00         8        18 burntbricks         
 5 Chirodzo 2016-11-17 00:00:00         5        45 muddaub             
 6 Chirodzo 2016-11-17 00:00:00         6        23 sunbricks           
 7 Chirodzo 2016-11-17 00:00:00         3         8 burntbricks         
 8 Chirodzo 2016-11-17 00:00:00         7        29 muddaub             
 9 Chirodzo 2016-11-17 00:00:00         2         6 muddaub             
10 Chirodzo 2016-11-17 00:00:00         9         7 muddaub             
# ℹ 29 more rows
```

Note that the final dataframe (`interviews_ch`) is the leftmost part of this
expression.

:::::::::::::::::::::::::::::::::::::::  challenge

## Exercise

Using pipes, subset the `interviews` data to include interviews
where respondents were members of an irrigation association
(`memb_assoc`) and retain only the columns `affect_conflicts`,
`liv_count`, and `no_meals`.

:::::::::::::::  solution

## Solution


```r
interviews %>%
    filter(memb_assoc == "yes") %>%
    select(affect_conflicts, liv_count, no_meals)
```

```{.output}
# A tibble: 33 × 3
   affect_conflicts liv_count no_meals
   <chr>                <dbl>    <dbl>
 1 once                     3        2
 2 never                    2        2
 3 never                    2        3
 4 once                     3        2
 5 frequently               1        3
 6 more_once                5        2
 7 more_once                3        2
 8 more_once                2        3
 9 once                     3        3
10 never                    3        3
# ℹ 23 more rows
```

:::::::::::::::::::::::::

::::::::::::::::::::::::::::::::::::::::::::::::::

## Mutate

Frequently you'll want to create new columns based on the values in existing
columns, for example to do unit conversions, or to find the ratio of values in
two columns. For this we'll use `mutate()`.

We might be interested in the ratio of number of household members
to rooms used for sleeping (i.e. avg number of people per room):


```r
interviews %>%
    mutate(people_per_room = no_membrs / rooms)
```

```{.output}
# A tibble: 131 × 15
   key_ID village  interview_date      no_membrs years_liv respondent_wall_type
    <dbl> <chr>    <dttm>                  <dbl>     <dbl> <chr>               
 1      1 God      2016-11-17 00:00:00         3         4 muddaub             
 2      2 God      2016-11-17 00:00:00         7         9 muddaub             
 3      3 God      2016-11-17 00:00:00        10        15 burntbricks         
 4      4 God      2016-11-17 00:00:00         7         6 burntbricks         
 5      5 God      2016-11-17 00:00:00         7        40 burntbricks         
 6      6 God      2016-11-17 00:00:00         3         3 muddaub             
 7      7 God      2016-11-17 00:00:00         6        38 muddaub             
 8      8 Chirodzo 2016-11-16 00:00:00        12        70 burntbricks         
 9      9 Chirodzo 2016-11-16 00:00:00         8         6 burntbricks         
10     10 Chirodzo 2016-12-16 00:00:00        12        23 burntbricks         
# ℹ 121 more rows
# ℹ 9 more variables: rooms <dbl>, memb_assoc <chr>, affect_conflicts <chr>,
#   liv_count <dbl>, items_owned <chr>, no_meals <dbl>, months_lack_food <chr>,
#   instanceID <chr>, people_per_room <dbl>
```

We may be interested in investigating whether being a member of an
irrigation association had any effect on the ratio of household members
to rooms. To look at this relationship, we will first remove
data from our dataset where the respondent didn't answer the
question of whether they were a member of an irrigation association.
These cases are recorded as "NULL" in the dataset.

To remove these cases, we could insert a `filter()` in the chain:


```r
interviews %>%
    filter(!is.na(memb_assoc)) %>%
    mutate(people_per_room = no_membrs / rooms)
```

```{.output}
# A tibble: 92 × 15
   key_ID village  interview_date      no_membrs years_liv respondent_wall_type
    <dbl> <chr>    <dttm>                  <dbl>     <dbl> <chr>               
 1      2 God      2016-11-17 00:00:00         7         9 muddaub             
 2      7 God      2016-11-17 00:00:00         6        38 muddaub             
 3      8 Chirodzo 2016-11-16 00:00:00        12        70 burntbricks         
 4      9 Chirodzo 2016-11-16 00:00:00         8         6 burntbricks         
 5     10 Chirodzo 2016-12-16 00:00:00        12        23 burntbricks         
 6     12 God      2016-11-21 00:00:00         7        20 burntbricks         
 7     13 God      2016-11-21 00:00:00         6         8 burntbricks         
 8     15 God      2016-11-21 00:00:00         5        30 sunbricks           
 9     21 God      2016-11-21 00:00:00         8        20 burntbricks         
10     24 Ruaca    2016-11-21 00:00:00         6         4 burntbricks         
# ℹ 82 more rows
# ℹ 9 more variables: rooms <dbl>, memb_assoc <chr>, affect_conflicts <chr>,
#   liv_count <dbl>, items_owned <chr>, no_meals <dbl>, months_lack_food <chr>,
#   instanceID <chr>, people_per_room <dbl>
```

The `!` symbol negates the result of the `is.na()` function. Thus, if `is.na()`
returns a value of `TRUE` (because the `memb_assoc` is missing), the `!` symbol
negates this and says we only want values of `FALSE`, where `memb_assoc` **is
not** missing.

:::::::::::::::::::::::::::::::::::::::  challenge

## Exercise

Create a new dataframe from the `interviews` data that meets the following
criteria: contains only the `village` column and a new column called
`total_meals` containing a value that is equal to the total number of meals
served in the household per day on average (`no_membrs` times `no_meals`).
Only the rows where `total_meals` is greater than 20 should be shown in the
final dataframe.

**Hint**: think about how the commands should be ordered to produce this data
frame!

:::::::::::::::  solution

## Solution


```r
interviews_total_meals <- interviews %>%
    mutate(total_meals = no_membrs * no_meals) %>%
    filter(total_meals > 20) %>%
    select(village, total_meals)
```

:::::::::::::::::::::::::

::::::::::::::::::::::::::::::::::::::::::::::::::

## Split-apply-combine data analysis and the summarize() function

Many data analysis tasks can be approached using the *split-apply-combine*
paradigm: split the data into groups, apply some analysis to each group, and
then combine the results. **`dplyr`** makes this very easy through the use of
the `group_by()` function.

### The `summarize()` function

`group_by()` is often used together with `summarize()`, which collapses each
group into a single-row summary of that group.  `group_by()` takes as arguments
the column names that contain the **categorical** variables for which you want
to calculate the summary statistics. So to compute the average household size by
village:


```r
interviews %>%
    group_by(village) %>%
    summarize(mean_no_membrs = mean(no_membrs))
```

```{.output}
# A tibble: 3 × 2
  village  mean_no_membrs
  <chr>             <dbl>
1 Chirodzo           7.08
2 God                6.86
3 Ruaca              7.57
```

You may also have noticed that the output from these calls doesn't run off the
screen anymore. It's one of the advantages of `tbl_df` over dataframe.

You can also group by multiple columns:


```r
interviews %>%
    group_by(village, memb_assoc) %>%
    summarize(mean_no_membrs = mean(no_membrs))
```

```{.output}
`summarise()` has grouped output by 'village'. You can override using the
`.groups` argument.
```

```{.output}
# A tibble: 9 × 3
# Groups:   village [3]
  village  memb_assoc mean_no_membrs
  <chr>    <chr>               <dbl>
1 Chirodzo no                   8.06
2 Chirodzo yes                  7.82
3 Chirodzo <NA>                 5.08
4 God      no                   7.13
5 God      yes                  8   
6 God      <NA>                 6   
7 Ruaca    no                   7.18
8 Ruaca    yes                  9.5 
9 Ruaca    <NA>                 6.22
```

Note that the output is a grouped tibble. To obtain an ungrouped tibble, use the
`ungroup` function:


```r
interviews %>%
    group_by(village, memb_assoc) %>%
    summarize(mean_no_membrs = mean(no_membrs)) %>%
    ungroup()
```

```{.output}
`summarise()` has grouped output by 'village'. You can override using the
`.groups` argument.
```

```{.output}
# A tibble: 9 × 3
  village  memb_assoc mean_no_membrs
  <chr>    <chr>               <dbl>
1 Chirodzo no                   8.06
2 Chirodzo yes                  7.82
3 Chirodzo <NA>                 5.08
4 God      no                   7.13
5 God      yes                  8   
6 God      <NA>                 6   
7 Ruaca    no                   7.18
8 Ruaca    yes                  9.5 
9 Ruaca    <NA>                 6.22
```

When grouping both by `village` and `membr_assoc`, we see rows in our table for
respondents who did not specify whether they were a member of an irrigation
association. We can exclude those data from our table using a filter step.


```r
interviews %>%
    filter(!is.na(memb_assoc)) %>%
    group_by(village, memb_assoc) %>%
    summarize(mean_no_membrs = mean(no_membrs))
```

```{.output}
`summarise()` has grouped output by 'village'. You can override using the
`.groups` argument.
```

```{.output}
# A tibble: 6 × 3
# Groups:   village [3]
  village  memb_assoc mean_no_membrs
  <chr>    <chr>               <dbl>
1 Chirodzo no                   8.06
2 Chirodzo yes                  7.82
3 God      no                   7.13
4 God      yes                  8   
5 Ruaca    no                   7.18
6 Ruaca    yes                  9.5 
```

Once the data are grouped, you can also summarize multiple variables at the same
time (and not necessarily on the same variable). For instance, we could add a
column indicating the minimum household size for each village for each group
(members of an irrigation association vs not):


```r
interviews %>%
    filter(!is.na(memb_assoc)) %>%
    group_by(village, memb_assoc) %>%
    summarize(mean_no_membrs = mean(no_membrs),
              min_membrs = min(no_membrs))
```

```{.output}
`summarise()` has grouped output by 'village'. You can override using the
`.groups` argument.
```

```{.output}
# A tibble: 6 × 4
# Groups:   village [3]
  village  memb_assoc mean_no_membrs min_membrs
  <chr>    <chr>               <dbl>      <dbl>
1 Chirodzo no                   8.06          4
2 Chirodzo yes                  7.82          2
3 God      no                   7.13          3
4 God      yes                  8             5
5 Ruaca    no                   7.18          2
6 Ruaca    yes                  9.5           5
```

It is sometimes useful to rearrange the result of a query to inspect the values.
For instance, we can sort on `min_membrs` to put the group with the smallest
household first:


```r
interviews %>%
    filter(!is.na(memb_assoc)) %>%
    group_by(village, memb_assoc) %>%
    summarize(mean_no_membrs = mean(no_membrs),
              min_membrs = min(no_membrs)) %>%
    arrange(min_membrs)
```

```{.output}
`summarise()` has grouped output by 'village'. You can override using the
`.groups` argument.
```

```{.output}
# A tibble: 6 × 4
# Groups:   village [3]
  village  memb_assoc mean_no_membrs min_membrs
  <chr>    <chr>               <dbl>      <dbl>
1 Chirodzo yes                  7.82          2
2 Ruaca    no                   7.18          2
3 God      no                   7.13          3
4 Chirodzo no                   8.06          4
5 God      yes                  8             5
6 Ruaca    yes                  9.5           5
```

To sort in descending order, we need to add the `desc()` function. If we want to
sort the results by decreasing order of minimum household size:


```r
interviews %>%
    filter(!is.na(memb_assoc)) %>%
    group_by(village, memb_assoc) %>%
    summarize(mean_no_membrs = mean(no_membrs),
              min_membrs = min(no_membrs)) %>%
    arrange(desc(min_membrs))
```

```{.output}
`summarise()` has grouped output by 'village'. You can override using the
`.groups` argument.
```

```{.output}
# A tibble: 6 × 4
# Groups:   village [3]
  village  memb_assoc mean_no_membrs min_membrs
  <chr>    <chr>               <dbl>      <dbl>
1 God      yes                  8             5
2 Ruaca    yes                  9.5           5
3 Chirodzo no                   8.06          4
4 God      no                   7.13          3
5 Chirodzo yes                  7.82          2
6 Ruaca    no                   7.18          2
```

### Counting

When working with data, we often want to know the number of observations found
for each factor or combination of factors. For this task, **`dplyr`** provides
`count()`. For example, if we wanted to count the number of rows of data for
each village, we would do:


```r
interviews %>%
    count(village)
```

```{.output}
# A tibble: 3 × 2
  village      n
  <chr>    <int>
1 Chirodzo    39
2 God         43
3 Ruaca       49
```

For convenience, `count()` provides the `sort` argument to get results in
decreasing order:


```r
interviews %>%
    count(village, sort = TRUE)
```

```{.output}
# A tibble: 3 × 2
  village      n
  <chr>    <int>
1 Ruaca       49
2 God         43
3 Chirodzo    39
```

:::::::::::::::::::::::::::::::::::::::  challenge

## Exercise

How many households in the survey have an average of
two meals per day? Three meals per day? Are there any other numbers
of meals represented?

:::::::::::::::  solution

## Solution


```r
interviews %>%
   count(no_meals)
```

```{.output}
# A tibble: 2 × 2
  no_meals     n
     <dbl> <int>
1        2    52
2        3    79
```

:::::::::::::::::::::::::

Use `group_by()` and `summarize()` to find the mean, min, and max
number of household members for each village. Also add the number of
observations (hint: see `?n`).

:::::::::::::::  solution

## Solution


```r
interviews %>%
  group_by(village) %>%
  summarize(
      mean_no_membrs = mean(no_membrs),
      min_no_membrs = min(no_membrs),
      max_no_membrs = max(no_membrs),
      n = n()
  )
```

```{.output}
# A tibble: 3 × 5
  village  mean_no_membrs min_no_membrs max_no_membrs     n
  <chr>             <dbl>         <dbl>         <dbl> <int>
1 Chirodzo           7.08             2            12    39
2 God                6.86             3            15    43
3 Ruaca              7.57             2            19    49
```

:::::::::::::::::::::::::

What was the largest household interviewed in each month?

:::::::::::::::  solution

## Solution


```r
# if not already included, add month, year, and day columns
library(lubridate) # load lubridate if not already loaded
interviews %>%
    mutate(month = month(interview_date),
           day = day(interview_date),
           year = year(interview_date)) %>%
    group_by(year, month) %>%
    summarize(max_no_membrs = max(no_membrs))
```

```{.output}
`summarise()` has grouped output by 'year'. You can override using the
`.groups` argument.
```

```{.output}
# A tibble: 5 × 3
# Groups:   year [2]
   year month max_no_membrs
  <dbl> <dbl>         <dbl>
1  2016    11            19
2  2016    12            12
3  2017     4            17
4  2017     5            15
5  2017     6            15
```

:::::::::::::::::::::::::

::::::::::::::::::::::::::::::::::::::::::::::::::

:::::::::::::::::::::::::::::::::::::::: keypoints

- Use the `dplyr` package to manipulate dataframes.
- Use `select()` to choose variables from a dataframe.
- Use `filter()` to choose data based on values.
- Use `group_by()` and `summarize()` to work with subsets of data.
- Use `mutate()` to create new variables.

::::::::::::::::::::::::::::::::::::::::::::::::::


