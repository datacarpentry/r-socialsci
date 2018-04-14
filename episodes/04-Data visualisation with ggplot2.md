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

## Plotting with `ggplot2`

`ggplot2` is a plotting package that makes breaks down the plotting process into three distinct parts.

You specify:

* the variables to plot.
* how they should be displayed
* boilerplate type properties of the plot

If you need to change the plot in anyway like adding new data, changing the plot type  or changing labels etc. we can do so with only need minimal changes to the code.

ggplot likes data in the 'long' format: i.e., a column for every dimension,
and a row for every observation. Well-structured data will save you lots of time
when making figures with ggplot.

ggplot graphics are built step by step by adding new elements. Adding layers in
this fashion allows for extensive flexibility and customization of plots.

Before we start we need to load the 'ggplot2' library and some data. For this episode we will be using the SAFI_results data.

~~~
library(ggplot2)
library(readr)
SAFI_results <- read_csv("SAFI_results.csv")
~~~

To build a ggplot, we need to:

- use the `ggplot()` function and bind the plot to a specific data frame using the  
      `data` argument

~~~
ggplot(data = SAFI_results)
~~~

If you run this line of code you will get a blank canvas in the plots pane. There is nothing wrong with the caode sofar, there is just nothing to show.

- define a mapping (using the aesthetic (`aes`) function), by selecting the variables to be plotted and specifying how to present them in the graph, e.g. as x/y positions or characteristics such as size, shape, color, etc.

~~~
ggplot(data = surveys_complete, aes(x = A11_years_farm, y = B16_years_liv))
~~~

When you run this line of code, you get the labels for the x and y axis, because ggplot knows the variable names and as it has the data it can calculate suitable ranges for the axes.

- add `geoms` -- graphical representation of the data in the plot (points,
      lines, bars). `ggplot2` offers many different geoms; we will use some 
      common ones today, including:
      * `geom_point()` for scatter plots, dot plots, etc.
      * `geom_boxplot()` for, well, boxplots!
      * `geom_bar()` for barplots.  

To add a geom to the plot use the `+` operator. Because we have two continuous variables,  
let's use `geom_point()` first:

~~~
# how many years farming in area v living in area
ggplot(data = SAFI_results, aes(x = A11_years_farm, y = B16_years_liv)) +
  geom_point()
~~~

No we have a complete graph!

The `+` in the `ggplot2` package is particularly useful because it allows you
to modify existing `ggplot` objects. This means you can easily set up plot
templates and conveniently explore different types of plots, so the above
plot can also be generated with code like this:

~~~
# Assign plot to a variable
SAFI_plot <- ggplot(data = SAFI_results, aes(x = A11_years_farm, y = B16_years_liv))

# Draw the plot
SAFI_plot + 
    geom_point()
~~~

**Notes:**

- Anything you put in the `ggplot()` function can be seen by any geom layers
  that you add (i.e., these are universal plot settings). This includes the x- and
  y-axis mapping you set up in `aes()`.
- You can also specify mappings for a given geom independently of the
  mappings defined globally in the `ggplot()` function. So the following works OK.
  
~~~
ggplot(data = SAFI_results) +
  aes(x = A11_years_farm, y = B16_years_liv) +
  geom_point()
~~~

- The `+` sign used to add layers must be placed at the end of each line containing
a layer. If, instead, the `+` sign is added in the line before the other layer,
`ggplot2` will not add the new layer and will return an error message.


## Building your plots iteratively

Building plots with ggplot is typically an iterative process. We start by
defining the dataset we'll use, lay out the axes, and choose a geom:

~~~

ggplot(data = SAFI_results, aes(x = A11_years_farm, y = B16_years_liv)) +
  geom_point()
  
~~~

Then, we start modifying this plot to extract more information from it. For
instance, we can add transparency (`alpha`) to avoid overplotting:

~~~

ggplot(data = SAFI_results, aes(x = A11_years_farm, y = B16_years_liv)) +
  geom_point(alpha = 0.1)
  
~~~

We can also add colors for all the points:

~~~
ggplot(data = SAFI_results, aes(x = A11_years_farm, y = B16_years_liv)) +
    geom_point(alpha = 0.1, color = "blue")
~~~

Or to color each species in the plot differently:

~~~
ggplot(data = SAFI_results, aes(x = A11_years_farm, y = B16_years_liv)) +
  geom_point(alpha = 1.0, aes(color = B_no_membrs))
~~~


> ## Exercise
>
> Create a plot of No of years farming (All_years_farm) against the size of the household (B_no_membrs)
> use the 'size' parameter within the 'aes' to vary the point size based on the number of plots (D_plots_count)
> 
> > ## Solution
> > 
> > ~~~
> > \# Years farming  v members in HH
> > \# size based on no of plots
> > ggplot(data = SAFI_results, aes(x = A11_years_farm, y = B_no_membrs)) +
> >   geom_point(aes(size = D_plots_count), color = "blue", alpha = 0.5)
> > ~~~
> > 
> {: .solution}
{: .challenge}


## Boxplot

We can use boxplots to visualize the distribution of a continuous variable 
among a categorical variable. For example, the weight recorded for each species:

~~~

ggplot(data = surveys_complete, aes(x = species_id, y = weight)) +
    geom_boxplot()
~~~

We can get a better idea of the number and distribution of points by adding a 
layer of points over the boxplots.

~~~
ggplot(data = SAFI_results, aes(x = species_id, y = weight)) +
 geom_boxplot() +
 geom_point()
~~~

This isn't particularly pretty; rather than use `geom_point` here, we can 
use `geom_jitter` to jitter or spread out the points. We can also make the 
points slightly transparent using `alpha` and change their colour.

~~~
ggplot(data = SAFI_results, aes(x = species_id, y = weight)) +
 geom_boxplot() +
 geom_jitter(alpha = 0.3, color = "tomato")
~~~

> ## Exercise
>
> Boxplots are useful summaries, but hide the *shape* of the distribution. For
> example, if the distribution is bimodal, we would not see it in a
> boxplot. An alternative to the boxplot is the violin plot, which displays 
> the shape of the density of points.
>
> Replace the box plot with a violin plot; see `geom_violin()`. 
> 
> > ## Solution
> > 
> > ggplot(data = SAFI_results, aes(x = species_id, y = weight)) +
> >   geom_violin() +
> >   geom_jitter(alpha = 0.3, color = "tomato")
> > 
> > 
> {: .solution}
{: .challenge}

## Barplots

Barplots are also useful for visualizing categorical data. By default,
`geom_bar` accepts a variable for x, and plots the number of instances 
each value of x (in this case, wall type) appears in the dataset.

~~~
ggplot(data = SAFI_results, aes(x = C02_respondent_wall_type)) +
  geom_bar()
~~~

But what if we wanted to plot the average value of a second variable 
for each wall type? We would need to first generate a dataframe with 
the appropriate information.

~~~
# Generate a dataframe of average number of years farming (A11_years_farm) 
# by wall type

wall_avs <- SAFI_results %>%
  group_by(C02_respondent_wall_type) %>%
  summarise(av = mean(A11_years_farm))
~~~

Now we can use this dataframe to build a barplot. Instead of only defining 
the x axis variable (`CO2_respondent_wall_type`), we will also 
define the y axis variable (`av`), and tell `geom_bar` that we want the actual 
values of y to be plotted by including the argument `stat = identity`.

~~~
ggplot(data = wall_types, aes(x = C02_respondent_wall_type, y = av)) +
  geom_bar(stat = "identity")
~~~

Note that `geom_bar` treats the x variable as a factor; this means that we 
can use the same code to produce a barplot that displays unique values of a 
numeric variable along the x axis.

~~~
ggplot(data = SAFI_results, aes(x = A11_years_farm)) +
  geom_bar()
~~~

If you are trying to visualize the frequency of a continuous variable, you 
should use the `geom_histogram` function rather than `geom_bar`.
~~~
ggplot(data = SAFI_results, aes(x = weight)) +
  geom_histogram()
~~~

## Adding Labels and Titles

By default, the axes labels are determined by the name of the variable 
being plotted. However, `ggplot2` offers lots of cusomization options, 
like specifing the axes labels, and adding a title to the plot with 
relatively little code.

~~~
ggplot(data = SAFI_results, aes(x = factor(C02_respondent_wall_type))) +
  geom_bar() +
  ylab("Frequency") +  
  xlab("Wall Type") +
  ggtitle("Frequency of SAFI Building Wall Types")
~~~

> ## Exercise
>
> Create a barplot of the number of records for each type of roof (`C01_respondent_roof_type`).
> Create a barplot of the average weight of each species (`species_id`).
> Provide suitable axes labels and titles for each.
> 
> > ## Solution
> > 
> > ~~~
> > ggplot(data = SAFI_results, aes(x = C01_respondent_roof_type)) +
> >   geom_bar() +
> >   xlab("Roof Type") +
> >   ylab("Frequency") +
> >   ggtitle("Frequency of SAFI Building Roof Types")
> >
> > av_weights < -SAFI_results %>%
> >   group_by(species_id) %>%
> >   summarise(av=mean(weights))
> >
> > ggplot(data = av_weights, aes(x=species_id, y=av)) +
> >   geom_bar(stat="identity") +
> >   xlab("Species") +
> >   ylab("Average Weight") +
> >   ggtitle("Average Weight by Species")
> > ~~~
> > 
> {: .solution}
{: .challenge}

## Faceting

What if, instead of wanting to visualize the frequency of wall types across 
the entire data set, we wanted to visualize the frequency of wall types by 
village? One method to do this would be to make a subset of the 
data for each village and create a plot for each individual subset. But, 
this would likely be tedious and time-consuming.

Instead, `ggplot2` has a built-in method of doing this, called *facetting*. The 
`facet_wrap` function allows the user to split one plot into multiple plots 
based on a factor included in the dataset.

We'll use this to create a barplot for each village.

~~~
ggplot(data = SAFI_results, aes(x = C02_respondent_wall_type)) +
  geom_bar() +
  ylab("Frequency") +  
  xlab("wall Type") +
  ggtitle("Frequency of SAFI Building Wall Types by Village") +
  facet_wrap(~ A09_village )
~~~

> ## Exercise
>
> Create a facetted set of plots which show the different the different villages use differnet
> roof types (C01_respondent_roof_type) 
> 
> For an extra challenge, try to create a facetted set of barplots of the average
> weight by species and village.
> 
> > ## Solution
> > 
> > ~~~
> > ggplot(data = SAFI_results, aes(x = C01_respondent_roof_type)) +
> >   geom_bar() +
> >   ylab("Frequency") +  
> >   xlab("Roof Type") +
> >   ggtitle("Frequency of SAFI Building Roof Types by Village") +
> >   facet_wrap(~ village)
> >
> > # Challenge Solution:
> > weight_av_vil <- SAFI_results %>%
> >   group_by(A09_village, species_id) %>%
> >   summarise(av = mean(weight))
> >
> > ggplot(weight_av_vil, aes(x = species_id, y = av) +
> >   geom_bar(stat = "identity") +
> >   xlab("Species") +
> >   ylab("Average Weight") +
> >   ggtitle("Average Weight of Species by Village") +
> >   facet_wrap(~ A09_village)
> >
> > ~~~
> >
> {: .solution}
{: .challenge}

