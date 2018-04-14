---
title: "Data visualisation with ggplot2"
teaching: 0
exercises: 0
questions:
- "What are the components of a ggplot?"
- "How do I create scatterplots, boxplots, and histogram?"
- "How can I change the aesthetics (ex. colour, transparency) of my plot?"
- "How can I create multiple plots at once?"

objectives:
- "Describe the three components of a ggplot"
- "Use `ggplot2` to create scatterplots, boxplots, and histograms"
- "Modify the aesthetics of a ggplot"
- "Use `facet_wrap` to produce multiple plots" 

keypoints:
- "`ggplot2` is a flexible and useful tool for creating plots in R"
- "the data set and coordinate system can be defined using the `ggplot` function"
- "additional layers, including geoms, are added using the `+` operator"
- "boxplots are useful for visualizing the distribuion of a continuous variable"
- "barplot are useful for visualizing categorical data"
- "facetting allows you to generate multiple plots based on a categorical variable"
---

## What is `ggplot2`?

There are three main methods used for plotting in R: the base plotting system 
(which comes built in with R), the `lattice` package, and the `ggplot2` package. 
It is generally accepted that `ggplot2` is the most effective for creating 
publication quality graphics in R. It is also a useful tool because modifying a 
plot in various ways (like changing labels, changing the plot type, adding new 
data, etc.) requires relatively little code.

`ggplot2` is built on the grammar of graphics; the idea that any plot can be 
expressed from the same set of components:

* a data set
* a coordinate system ("mapping")
* a geom (the visual representation of the data)

Before we learn more about the details, let's load the `ggplot2` package and 
import a dataset. For this episode we will be using the `SAFI_results` data, 
which is stored in our current working directory. `ggplot2` uses data stored in 
the 'long' format; i.e. with a column for every dimension and a row for every 
observation. Well-structured data will save you lots of time when making figures.

~~~
library(ggplot2)
SAFI_results <- read.csv("SAFI_results.csv")
~~~

## Plotting with `ggplot2`

The key to understanding `ggplot2` is to think about a figure as having layers. 
Figures are built step by step by adding new layers, which allows for a high 
degree of flexibility and customization.

To intialize a ggplot, we use the `ggplot` function. This function lets R know 
that we are creating a new plot, and is used to specify the dataframe that 
contains the information we are interested in visualizing.

~~~
ggplot(data = SAFI_results)
~~~

When you run this line of code you will get a blank canvas in the Plots pane in 
the lower right hand corner of RStudio. There is nothing wrong with the code - 
so far we have only specified one of the three components needed to build a plot: 
the data set.

The second component is the coordinate system, often refered to as the "mapping". 
The aesthetic function `aes` identifies the variables in the dataframe that will 
be plotted, and specifies how to present them in the graph as either positions 
(x / y) or characteristics (ex. size, shape, color). The `aes` function is flexible 
in terms of which layer it is defined in; for now, we'll add it to our first layer.

~~~
ggplot(data = SAFI_results, aes(x = A11_years_farm, y = B16_years_liv))
~~~

When you run this line of code, you will still get a blank canvas in the Plots 
pane, but you'll notice that labels for the x and y axis have been added. This 
is because we specified in `aes` that the x axis should represent the variable 
`A11_years_farm` and the y axis should represent the variable `B16_years_liv`, 
each found within `SAFI_results` data frame.

The final component of the plot that needs to be specified is the 'geom', or 
visual representation of the data. We need to decide if we want our data to be 
expressed as points, bars, boxplots, etc. `ggplot2` offers many different geom 
options. Some of the common ones include:
* `geom_point()` for scatter plots
* `geom_boxplot()` for boxplots
* `geom_histogram()` for histograms
* `geom_bar()` for barplots

Because, in this instance, we are looking at two continuous variables (*number 
of years farming in area* and *number of years living in area*), let's opt to 
display the data using a scatterplot. To add a geom (in this case, 
`geom_point()`) to the plot, we'll add a new layer using the `+` operator.

~~~
ggplot(data = SAFI_results, aes(x = A11_years_farm, y = B16_years_liv)) + geom_point()
~~~

As we begin to build more complex plots, it can be helpful to put each new layer 
of the plot on a new line for readability. To do this, the `+` sign used to add 
layers must be placed at the end of each line containing a layer.

~~~
ggplot(data = SAFI_results, aes(x = A11_years_farm, y = B16_years_liv)) + 
      geom_point()
~~~

Note that the contents of the first layer (in the `ggplot()` function) are 
considered to be global settings. In other words, they will be considered the 
'default' settings for any geom layer that you add.

As was mentioned earier, the `aes` function is flexible in terms of which layer 
it is defined in. This means that you can specify the mapping for a particular 
geom independently rather than as a global setting.

~~~
ggplot(data = SAFI_results) + 
      geom_point(aes(x = A11_years_farm, y = B16_years_liv))
~~~

Note: Often, deciding whether to include mapping as a global setting or 
independently within geoms is a personal preference or habit. However, if, for 
example, you are adding several geom layers using the same mapping settings, 
including `aes` in the `ggplot` function will save you time and minimize the risk 
of typos.

## Building Plots Iteratively

Building plots with `ggplot2` is typically an iterative process. We start by
defining the dataset we want to use, identifing our mapping aesthetics, and 
choosing a geom.

~~~
ggplot(data = SAFI_results, aes(x = A11_years_farm, y = B16_years_liv)) +
  geom_point() 
~~~

Next, we may want to start modifying this plot to make it more visualy appealing 
or include more information. For instance, we can define the transparency of our 
points using `alpha` to avoid overplotting.

~~~
ggplot(data = SAFI_results, aes(x = A11_years_farm, y = B16_years_liv)) +
  geom_point(alpha = 0.1)
~~~

We can decide that we also prefer all of the points to be blue.

~~~
ggplot(data = SAFI_results, aes(x = A11_years_farm, y = B16_years_liv)) +
    geom_point(alpha = 0.1, color = "blue")
~~~

Upon further investigation, perhaps we decide that each point should be a 
different colour, based on which species it represents - information that is 
found in the column called `species_id`.

~~~
ggplot(data = SAFI_results, aes(x = A11_years_farm, y = B16_years_liv)) +
  geom_point(alpha = 1.0, aes(color = species_id))
~~~

Notice in the last example that we see that colour is now specified *inside* 
of an `aes` function. Why didn't we have to do that when we wanted our 
points to be blue? Because the colour is going to be dependent on something in 
our dataset, we need to include it as a component of our mapping. The same way 
that our `A11_years_farm` column is represented by x and our `B16_years_liv` 
column is represented by y, the colour of each point is going to represent a 
third dimension on our coordinate system.

> ## Exercise
>
> Create a scatterplot with the number of years farming (`A11_years_farm`) on 
> the x axis and the size of the household (`B_no_membrs`) on the y axis, along
> with the following:
>
> * The size of the points vary based on the number of plots (`D_plots_count`)
> * The transparency of the points is 0.5
> * The colour of the points is blue
>
> > ## Solution
> > 
> > ~~~
> > ggplot(data = SAFI_results, aes(x = A11_years_farm, y = B_no_membrs)) +
> >         geom_point(aes(size = D_plots_count), color = "blue", alpha = 0.5)
> > ~~~
> > 
> {: .solution}
{: .challenge}


## Boxplot

We can use boxplots to visualize the distribution of weight within each species:

~~~

ggplot(data = surveys_complete, aes(x = species_id, y = weight)) +
    geom_boxplot()
~~~

By adding points to boxplot, we can have a better idea of the number of
measurements and of their distribution:

~~~
ggplot(data = SAFI_results, aes(x = A11_years_farm, y = B_no_membrs)) +
 geom_boxplot(alpha = 0) +
 geom_jitter(alpha = 0.3, color = "tomato")
~~~

> ## Exercise
>
> Boxplots are useful summaries, but hide the *shape* of the distribution. For
> example, if the distribution is bimodal, we would not see it in a
> boxplot. An alternative to the boxplot is the violin plot where the shape (of the density of points) is drawn.
>
> Replace the box plot with a violin plot; see `geom_violin()`. 
> 
> > ## Solution
> > 
> > ggplot(data = SAFI_results, aes(x = A11_years_farm, y = B_no_membrs)) +
> >   geom_violin() +
> >   geom_jitter( color = "tomato")
> > 
> > 
> {: .solution}
{: .challenge}

## Bar plots

Bar plots are useful for comparing categorical data.

We looked at a simple bar chart in the dplyr episode. we can recreate this in ggplot.

~~~

# create a small dataframe of the wall types and their counts

wall_types <- SAFI_results %>%
  select(C02_respondent_wall_type) %>%
  group_by(C02_respondent_wall_type) %>%
  tally()

# create a bar chart of the wall types
ggplot(data = wall_types, aes(x = C02_respondent_wall_type, y = count_of_type)) +
  geom_bar(stat="identity")

~~~



The barchart can however be constructed direectly from  the SAFI_results data.

~~~
# create bar chaart directly from SAFI_results
ggplot(data=SAFI_results, aes(x=C02_respondent_wall_type)) +
  geom_bar(stat="count")

~~~

Apart from the `dplyr` work involved before creating the first plot, there are a couple of signifcant differences between the two approaches.

In the second, more direct approach, we do not specify a 'y' value. This is because the default 'stat=count' in the call to 'geom_bar' will atomatically produce counts for the x axis items and is used on the y axis .

Although you might think that the items along the x axis need to be Factors, as this is essentially how we treat them, they don't. The wall, floor and roof types are all string variables. 

We can even the 'same' code to produce barcharts fro numeric values  on the x axis. 

~~~
ggplot(data=SAFI_results, aes(x=A11_years_farm)) +
  geom_bar(stat="count")
~~~

By default all of plots so far have had the labels on the axis determined by the variable we have used. As you might expect, these can be easily changed. You can add your own x any axis labels as well as an overall plot title.

~~~
ggplot(data=SAFI_results, aes(x=factor(C02_respondent_wall_type))) +
  geom_bar(stat="count") +
  ylab("count of each wall type") +  
  xlab("wall types") +
  ggtitle("SAFI Building wall types")
~~~

> ## Exercise
>
> Create a bar chart showing the number and types of the different roof types (C01_respondent_roof_type)
> Create a bar chart showing a count of the different household sizes (B_no_membrs).
> Provide suitable labels and titles.
> 
> > ## Solution
> > 
> > ~~~
> > ggplot(data=SAFI_results, aes(x=C01_respondent_roof_type)) +
> >   geom_bar(stat="count")
> > ggplot(data=SAFI_results, aes(x=B_no_membrs)) +
> >   geom_bar(stat="count")
> > ~~~
> > 
> {: .solution}
{: .challenge}

 

## Faceting

ggplot has a special technique called *faceting* that allows the user to split one plot
into multiple plots based on a factor included in the dataset. 

Instead of looking at the wall types across all of the data, we can split it up based on the values in some other variable. Here is the wall type split by village.

~~~
# facet wrap by village
ggplot(data=SAFI_results, aes(x=C02_respondent_wall_type)) +
  geom_bar(stat="count") +
  ylab("count of wall types") +  
  xlab("wall types") +
  ggtitle("SAFI Building wall types") +
  facet_wrap(~ A09_village )
~~~

Interestingly, `ggplot2` figures can be stored as objects. This is 
particularly useful because you can modify existing `ggplot2` objects using `+`.  

For example, you are able to create a plot template and ....
conveniently explore different types of plots, so the above
plot can also be generated with code like this:

~~~
# Assign plot to a variable
SAFI_plot <- ggplot(data = SAFI_results, aes(x = A11_years_farm, y = B16_years_liv))

# Draw the plot
SAFI_plot + 
    geom_point()
~~~

> ## Exercise
>
> Create a facetted set of plots which show the different the different villages use differnet
> roof types (C01_respondent_roof_type) 
> 
> > ## Solution
> > 
> > ~~~
> > ggplot(data=SAFI_results, aes(x=A09_village)) +
> >   geom_bar(stat="count") +
> >   ylab("count of roof types") +  
> >   xlab("villages") +
> >   ggtitle("SAFI Building roof types") +
> >   facet_wrap(~ C01_respondent_roof_type ) + coord_flip()
> > ~~~
> >
> {: .solution}
{: .challenge}
