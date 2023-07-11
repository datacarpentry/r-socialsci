---
title: Code Handout - R for Social Scientists
output:
  html_document:
    df_print: paged
    code_download: yes
---



This document contains all of the core functions that were covered in the R for Social Scientists workshop. 
Each function is presented alongside an example of
how it can be used. It is split into the following 4 sections:

- Introduction to R

- Starting with Data

- Data Wrangling

- Data Visualization

Each section has instructions to load all necessary libraries or data, so you can start from any of the 4 points linked above.

## Introduction to R

The first section covers core programming concepts and functions in Base R and does not require any data or libraries to be loaded.

### Creating Objects

- `<-` -- "assignment arrow", assigns a value (vector, dataframe, single value) to the name of a variable


```r
x <- 3
```

- `c()` -- the "concatenate" function combines inputs to form a vector, the
  values have to be the same data type.


```r
animals <- c("bird", "cat", "dog")
numbers <- c(1, 14, 57, 89)
logicals <- c(TRUE, FALSE, TRUE, TRUE)
```
- `+` -- addition and other mathematical operators can be repeated on every value
  in a vector.


```r
y <- c(1, 2, 3)
z <- x + y
```

### Inspecting Objects

- `str()` -- compact display of the structure of an R object


```r
str(animals)
```

- `class()` -- returns the type of element of any R object


```r
class(logicals)
```

- `typeof()` -- returns the data type or storage mode of any R object


```r
typeof(numbers)
```

### Functions in R

- `args()` -- returns the arguments of a function


```r
args(round)
```

- named arguments -- the name of the argument the function expects
  - You can choose to not name your arguments, **if** you know the **exact**
    order they should be in!
  - However, we generally discourage this.

- `round()` -- round a decimal or fraction to a specified number of digits


```r
# Either of these work, since the digits argument is named explicitly.
round(3.14159, digits = 2)
round(digits = 2, 3.14159)

# This does not work, since the arguments are not named and in the incorrect order. 
round(2, 3.14159)
```

### Functions to Summarize Data

- `sqrt()` -- returns the square root of a numeric variable


```r
sqrt(numbers)
```

- `mean()` -- returns the mean of a numeric variable
  - You can add the `na.rm` argument, to remove `NA` values before calculating
    the mean.


```r
mean(numbers)
```

- `max()` -- returns the maximum of a numeric variable
  - You can add the `na.rm` argument, to remove `NA` values before calculating
    the max.


```r
max(numbers)
```

- `sum()` -- returns the sum of a numeric variable
  - You can add the `na.rm` argument, to remove `NA` values before calculating
    the sum.


```r
sum(numbers)
```

- `length()` -- returns the length of a vector (of any datatype)


```r
length(animals)
```

- Additional summary functions include:
  - `var()` -- find the variance of a numerical variable
  - `sd()` -- finds the standard deviation of a numerical variable
  - `IQR()` -- find the innerquartile range (Q3 - Q1) of a numerical variable
  - `median()` -- finds the median of a numerical variable

### Subsetting Data

- `[]` -- used to subset elements from a vector

- `X:Y` -- used to retrieve a "slice" of a vector starting at X and continuing through Y


```r
animals[3]
# selects the third element

animals[2:3]
# selects the second and third element

animals[c(1, 3)]
# selects the first and third element
```

- relational operators -- return logical values indicating where a relation is
  satisfied. The most commonly used logical operators for data analysis are as follows:
  - `==` means "equal to"
  - `!=` means "not equal to"
  - `>` or `<` means "greater than" or "less than"
  - `>=` or `<=` means "greater than or equal to" or "less than or equal to"


```r
animals == "dog"

animals != "cat"

numbers > 4

numbers <= 12
```

- logical operators -- join subset criteria together
  - `&` means "and" -- where two criteria must **both** be satisfied
  - `|` means "or" -- where at least one criteria must be satisfied


```r
numbers > 4 & numbers < 20

animals == "dog" | animals == "cat"
```

- `%in%` -- the "inclusion operator", allows you to test if any of the elements
  of a search vector (on the left hand side) are found in the target vector (on
  the right hand side).
  - The levels of the target vector must be included in a vector (`c()`).


```r
possessions <- c("car", "bicycle", "radio", "television", "mobile_phone")

possessions %in% c("car", "bicycle", "motorcycle")
```

### Missing Data

- `is.na()` -- returns a vector of logical values indicating which elements of
  a vector have `NA` values
  - Often combined with `!`, where the `!` negates the previous statement (e.g.
    `!TRUE` is equal to `FALSE`).


```r
missing <- c(1, 3, NA, 7, 12, NA)

is.na(missing)

!is.na(missing)
```

- `na.omit()` -- removes the observations with `NA` values


```r
na.omit(missing)
```

- `complete.cases()` -- returns a vector of logical values indicating which
  elements of a vector **are not** missing (`NA`) values


```r
complete.cases(missing)
```

## Starting with Data

In this section, we begin working with data. 
All data examples are in the context of the Palmer Penguins, found
[here (link)](https://allisonhorst.github.io/palmerpenguins/index.html).

### Packages

Packages (also called libraries) expand the capabilities of R beyond the functions that come when you install it. Each needs to be downloaded and installed only once but loaded into each R session.

- `install.packages()` -- install a new package

- `library()` -- loads packages into your `R` session


```r
# Install packages (not run)
# Delete `#` from lines below if missing packages
#install.packages("tidyverse")
#install.packages("lubridate")
#install.packages("palmerpenguins")

# Load libraries
library(tidyverse)
library(lubridate)
library(palmerpenguins) #load Palmer Penguins data as `penguins`
```

### Inspecting Data

- `dim()` - returns a vector with the number of rows as the first element,
  and the number of columns as the second element (the **dim**ensions of
  the object)


```r
dim(penguins)
```

- `nrow()` - returns the number of rows
- `ncol()` - returns the number of columns


```r
nrow(penguins)
ncol(penguins)
```

- `head()` - displays the first 6 rows of the dataframe
- `tail()` - displays the last 6 rows of the dataframe


```r
head(penguins)
tail(penguins)
```

- `names()` - returns the all of the names of an object (both row and column)
- `colnames()` - returns column names for dataframes (without row names)


```r
names(penguins)
colnames(penguins)
```

- `glimpse()` - provides a preview of the data, where column names are presented
  with their associated data types, and the entries from each column are printed
  in each row


```r
glimpse(penguins)
```

- `str()` - returns the structure of the object and information about the class,
  the names and data types of each column, and a preview of the first entries of
  each column


```r
str(penguins)
```

- `summary()` - provides summary statistics for each column
  - Note: summary statistics for character variables are not meaningful, as they
    simply state the number of observations (length) of the variable


```r
summary(penguins)
```

### Subsetting Data in Dataframes

- `[]` -- selects rows and columns from a dataframe
  - The first entry is the row number, the second entry is the column number(s),
    and they are separated with a comma.


```r
# Selects the element in the first row, second column
penguins[1, 2]

# Selects every element in the fourth row
penguins[4, ]

# Selects every element in the third column
penguins[, 3]
```

- `[[]]` -- selects a column from a dataframe
  - Inside the brackets you can pass either the number of the column or the
    name of the column (in quotations)


```r
penguins[[1]]

penguins[["island"]]
```

- `$` -- selects a column from a dataframe, where the name of the dataframe is
  on the left and the name of the column is on the right


```r
penguins$body_mass_g
```

### Working with Different Data Types

- `factor()` -- creates a categorical variable from a character or numeric
  variable, variable has a factor datatype
  - the values (level) of the factor levels is specified in the `levels`
    argument, where the levels must be specified in a vector (using `c()`)
  - Note: the order you wish for the levels to appear is how you should list
    them in the `levels` argument, you can also specify `ordered = TRUE` to
    ensure the levels remain in this order


```r
penguins$year_fct <- factor(penguins$year, 
                            levels = c("2007", "2008", "2009"), 
                            ordered = TRUE)
```

- `as.factor()` -- creates a categorical variable from a character or numeric
  variable, variable has a factor datatype
  - does not allow for you to specify the order of the levels
  - defaults to alphabetical ordering for factor levels


```r
penguins$year_fct <- as.factor(penguins$year)
```

- `levels()` -- returns the levels of a factor variable in the
  order they were stored
  - Note: this function will not work for character variables


```r
levels(penguins$year_fct)
```

- `nlevels()` -- returns the number of levels of a factor variable
  - Note: this function will not work for character variables


```r
nlevels(penguins$year_fct)
```

- `as.character()` -- creates a character variable from a numeric or factor
  variable


```r
penguins$species_chr <- as.character(penguins$species)
```

- `ymd()` -- transforms dates stored as character or numeric variables to dates
  - Note: to use this function, dates must be stored in year-month-day format
  - The function does well with heterogeneous formats (as seen below), but
    formats where some of the entries are not in double digits may not be parsed
    correctly.


```r
x <- c("2009-01-01", "2009-01-02", "2009-01-03")
ymd(x)
```

- `day()` -- extracts the day (number) of a date variable


```r
day(x)
```

- `month()` -- extracts the month (number) of a date variable


```r
month(x)
```

- `year()` -- extracts the year of a date variable


```r
year(x)
```

### Basic Data Visualization (see Data Visualization section for more)

- `plot()` -- a generic function for plotting R objects
  - In this lesson `plot()` was used to create bargraphs of categorical
    variables.


```r
plot(penguins$species)
```

## Data Wrangling 

This section continues using the [Palmer Penguins data](https://allisonhorst.github.io/palmerpenguins/index.html) and introduces concepts and functions to explore, clean and summarize data, many of which come from the `dplyr` and `plyr` tidyverse libraries.

### Packages

- `library()` -- loads packages into your `R` session


```r
library(tidyverse)
library(palmerpenguins)
```

### Inspecting Data

- `glimpse()` -- shows a summary of the dataset, the number of rows and columns,
  variable names, and the first 10 entries of each variable


```r
glimpse(penguins)
```

### Verbs of Data Wrangling

- `%>%` -- the "pipe" operator, joins sequences of data wrangling steps together,
  works with any function that has `data = ` as the first argument
- `select()` -- selects variables (columns) from a dataframe


```r
penguins %>% 
  select(species)
```

- `filter()` -- filters observations (rows) out of / into a dataframe, where
  the inputs (arguments) are the conditions to be satisfied in the data that are
  kept

**Logical operators:** Filtering for certain observations (e.g. flights from a
particular airport) is often of interest in data frames where we might want to
examine observations with certain characteristics separately from the rest of
the data. To do so, you can use the `filter` function and a series of **logical
operators**. The most commonly used logical operators for data analysis are as
follows:

- `==` means "equal to"

- `!=` means "not equal to"

- `>` or `<` means "greater than" or "less than"

- `>=` or `<=` means "greater than or equal to" or "less than or equal to"


```r
# It's nice to have a new line for each condition, so your code is easier to read!
penguins %>% 
filter(species == "Adelie",
       body_mass_g > 3000,
       year == 2008)
```

- `mutate()` -- creates new variables or modifies existing variables


```r
penguins %>% 
  filter(is.na(bill_length_mm) != TRUE, 
         is.na(bill_depth_mm) != TRUE) %>% 
  mutate(body_mass_kg = body_mass_g / 1000)
```

- `group_by()` -- groups the dataframe based on levels of a categorical variable,
  usually used alongside `summarize()`


```r
penguins %>% 
  group_by(island)
```

- summarize()`-- creates data summaries of variables in a dataframe, for grouped  summaries use alongside`group\_by()\`


```r
penguins %>% 
  filter(is.na(body_mass_g) != TRUE) %>% 
  group_by(island) %>% 
  summarize(mean_mass = mean(body_mass_g))  
```

- `ungroup()` -- removes the grouping of a dataframe, typically used after group
  summaries when additional ungrouped operations are required


```r
penguins %>% 
  filter(is.na(body_mass_g) != TRUE) %>% 
  group_by(island) %>% 
  summarize(mean_mass = mean(body_mass_g)) %>% 
  ungroup() 
```

- `arrange()` -- orders a dataframe based on the values of a numerical variable,
  paired with `desc()` to order in descending order


```r
penguins %>% 
  filter(is.na(body_mass_g) != TRUE) %>% 
  group_by(island) %>% 
  summarize(mean_mass = mean(body_mass_g)) %>% 
  arrange(desc(mean_mass))
```

Chain multiple operations together with `%>%` to create specific outputs without extra steps or dataframes being created along the way.


```r
penguins %>%
  select(species, island, body_mass_g, sex, year) %>% 
  filter(island ==   "Torgersen", 
         is.na(body_mass_g) != TRUE) %>% 
  group_by(species, year) %>% 
  summarize(mean_mass = mean(body_mass_g),
            median_mass = median(body_mass_g),
            observations = n()) %>% 
  arrange(desc(mean_mass))
```

### Other Data Wrangling Tools

- `count()` -- counts the number of observations (rows) of the different levels
  of a categorical variable
  - can add `sort = TRUE` to sort the table in descending order (similar to
    using `arrange(desc())` )


```r
penguins %>% 
  count(species)
```

- `sample_n()` -- selects $n$ rows from the dataframe, based on the value of
  `size` specified


```r
penguins %>% 
  sample_n(size = 10)
```

- `replace_na()` -- replaces NA values with the value specified
  - The values to be replaced must be passed to the function (input) as a
    `list()` object.


```r
penguins %>% 
  replace_na(list(bill_length_mm = "no_measurement", 
                  bill_depth_mm = "no_measurement")) %>% 
  glimpse()
```

- `separate_rows()` -- separates a variable with multiple values based on the
  delimiter specified.
  
  - Variables whose entries are stored as a list with commas or semicolons are
    great candidates for this function!

- `rowSums()` -- forms row sums for numeric variables
  
  - Note: In the lesson `rowSums()` was used on a `logical` variable, because
    logical values can be numerically represented as 0 (FALSE) and 1 (TRUE)


```r
x <- tibble(x1 = 3, x2 = c(4:1, 2:5))
rowSums(x)
```

### Pivoting Dataframes

- `pivot_wider()` -- transforms a dataframe from long to wide format
  - takes three principal arguments:
    1. the *data* (often passed by a `%>%`)
    2. the *names\_from* column variable whose values will become new column names
    3. the *values\_from* column variable whose values will fill the new column
      variables.
  - Further arguments include `values_fill` which, if set, fills in missing
    values with the value provided.


```r
wide <- penguins %>% 
  mutate(island_logical = TRUE) %>% 
  pivot_wider(names_from = species, 
              values_from = island_logical, 
              values_fill = list(island_logical = FALSE))

glimpse(wide)
```

- `pivot_longer()` -- transforms a dataframe from wide to long format
  - takes four principal arguments:
  1. the data
  2. *cols* are the names of the columns we use to fill the a new values variable
    (or to drop).
  3. the *names\_to* column variable we wish to create from the *cols* provided.
  4. the *values\_to* column variable we wish to create and fill with values
    associated with the *cols* provided.


```r
wide %>% 
  pivot_longer(cols = Adelie:Gentoo, 
               names_to = "species", 
               values_to = "island_logical")
```

### Extracting Data

- `write_csv()` -- writes a dataframe to a csv file, output into the file path
  specified


```r
write_csv(wide, path = "data/penguins_wide.csv")
```

### Importing Data

- `read_csv()` -- function to import a csv file.
  - First argument is the path to the data, passed as a character
    (inside quotations).
  - You can specify what values should be considered missing, using the `na`
    argument.


```r
penguins_wide <- read_csv("data/penguins_wide.csv")
```

## Data Visualization with ggplot2

This section continues using the [Palmer Penguins data](https://allisonhorst.github.io/palmerpenguins/index.html) to introduce key features of the ggplot2 package for visualizing data 
and provide examples combining data wrangling and visualization.

### Packages


```r
library(tidyverse)
library(palmerpenguins)
```

### Foundations of `ggplot()`

- `ggplot()` -- a function to create the shell of a visualization, where
  specific variables are mapped to different aspects of the plot

- `aes()` -- aesthetics that can be used when creating a `ggplot()`, where the
  aesthetics can either be hard coded (e.g. `color = "blue"`) or associated with
  a variable (e.g. `color = sex`).
  
  - The following are the aesthetic options for *most* plots:
    - `x` -- variable to use for x axis
    - `y` -- variable to use for y axis
    - `alpha` -- changes transparency
    - `color` -- produces colored outline
    - `fill` -- fills with color
    - `group` -- used with categorical variables, similar to color


```r
#nothing should appear on this plot except the axes and labels
penguins %>% 
  ggplot(aes(x = bill_length_mm, y = bill_depth_mm, color = species))
```

- **`+`** -- an important aspect creating a `ggplot()` is to note that the
  `geom_XXX()` function is separated from the `ggplot()` function with a plus
  sign, `+`.
  
  - `ggplot()` plots are constructed in series of layers, where the plus sign
    separates these layers.
  - Generally, the `+` sign can be thought of as the end of a line, so you
    should always hit enter/return after it. While it is not mandatory to move
    to the next line for each layer, doing so makes the code a lot easier to
    organize and read.

- `geom_point()` -- adds a scatter plot; see full explanation later in list


```r
penguins %>% 
  ggplot(aes(x = bill_length_mm, y = bill_depth_mm, color = species)) + 
  geom_point()
```

### Geometric Objects to Visualize the Data

- `geom_histogram()` -- adds a histogram to the plot,
  where the observations are binned into ranges of values and then frequencies
  of observations are plotted on the y-axis
  - You can specify the number of bins you want with the `bins` argument


```r
penguins %>% 
  ggplot(aes(x = bill_length_mm)) + 
  geom_histogram(bins = 20)
```

- `geom_boxplot()` -- adds a boxplot to the plot, where observations are
  aggregated (summarized), the min, Q1, median, Q3, and maximum are plotted as the
  box and whiskers, and "outliers" are plotted as points.
  - You can plot a vertical boxplot by specifying the `x` variable, or a
    horizontal boxplot by specifying the `y` variable.
  - Note: the min and max may not be included in the whiskers, if they are
    deemed to be "outliers" based on the $1.5 \\times \\text{IQR}$ rule.


```r
# Horizontal boxplot
penguins %>% 
  ggplot(aes(x = bill_length_mm)) + 
  geom_boxplot()

# Vertical boxplot
penguins %>% 
  ggplot(aes(y = bill_length_mm)) + 
  geom_boxplot()
```

- `geom_density()` -- adds a density curve to the plot, where the probability
  density is plotted on the y-axis (so the density curve has a total area of one).
  - By default this creates a density curve without shading. By specifying a
    color in the `fill` argument, the density curve is shaded.
  - Can be thought of as the "one group" violin plot (see below)


```r
penguins %>% 
  ggplot(aes(x = bill_length_mm)) + 
  geom_density(fill = "tomato")
```

- `geom_violin()` -- plots violins for each level of a categorical variable
  - Can be thought of as a hybrid mix of `geom_boxplot()` and `geom_density()`,
    as the density is displayed, but it is reflected to provide a plot similar in
    nature to a boxplot.
  - To obtain violins stacked vertically, declare the categorical variable as `y`.
    To obtain side-by-side violins, declare the categorical variable as `x`.


```r
# Stacked vertically
penguins %>% 
  ggplot(aes(x = bill_length_mm, y = species)) + 
  geom_violin()

# Side-by-side
penguins %>% 
  ggplot(aes(y = bill_length_mm, x = species)) + 
  geom_violin()
```

- `geom_bar()` -- creates a barchart of a categorical variable
  - Can produce stacked barcharts by specifying a variable as the `fill`
    aesthetic.
  - Can change from stacked barchart to a side-by-side barchart by specifying
    `position = "dodge"`.
  - If your data are already in counts (e.g. output from `count()`), then you
    can specify the `stat = "identity"` argument inside `geom_bar()`.


```r
# Stacked barchart
penguins %>%
    ggplot(aes(x = species)) +
    geom_bar(aes(fill = sex))

# Side-by-side barchart
penguins %>%
    ggplot(aes(x = species)) +
    geom_bar(aes(fill = sex),
             position = "dodge")

# If data are raw counts
penguins %>% 
  count(species, sex) %>% 
  ggplot(aes(x = species, y = n)) + 
  geom_bar(aes(fill = sex),
           stat = "identity",
           position = "dodge")
```

- `geom_point()` -- plots each observation as an (x, y) point, used to create
  scatterplots
  - Can use `alpha` to increase the transparency of the points, to reduce
    overplotting.
  - Can specify `aes`thetics inside of `geom_point()` for local aesthetics (point
    level) or inside of `ggplot()` for global aesthetics (plot level)


```r
penguins %>% 
  ggplot(aes(x = bill_length_mm, y = bill_depth_mm)) + 
  geom_point(aes(color = species))
```

- `geom_jitter()` -- plots each observation as an (x, y) point and adds a small
  amount of jitter around the point
  - Useful so that we can see each point in the locations where there are
    overlapping points.
  - Can specify the `width` and `height` of the jittering using the optional
    arguments.


```r
penguins %>% 
  ggplot(aes(y = body_mass_g, x = species)) + 
  geom_violin() + 
  geom_jitter(aes(color = sex), width = 0.25, height = 0.25)
```

- `geom_smooth()` -- plots a line over a set of points, draws the readers eye
  to a specific trend
  - The methods we will use are "lm" for a linear model (straight line), and
    "loess" for a wiggly line
  - By default, the smoother gives you gray SE bars, to remove these add
    `se = FALSE`


```r
penguins %>% 
  ggplot(aes(x = bill_length_mm, y = bill_depth_mm, color = species)) + 
  geom_point() + 
  geom_smooth(method = "lm") 
```

- `facet_wrap()` -- creates subplots of your original plot, based on the levels
  of the variable you input
  - To facet by one variable, use `~variable`.
  - To facet by two variables, use `variable1 ~ variable2`.
  - If you prefer for your facets to be organized in rows or columns, use the
    `nrow` and/or `ncol` arguments.


```r
penguins %>% 
  ggplot(aes(x = bill_length_mm, y = bill_depth_mm, color = species)) + 
  geom_point() + 
  geom_smooth(method = "lm") + 
  facet_wrap(~island, nrow = 1)
```

### Plot Characteristics

- `labs()` -- specifies the plot labels, possible labels are: x, y, color, fill,
  title, and subtitle


```r
penguins %>% 
  ggplot(aes(x = bill_length_mm, y = bill_depth_mm, color = species)) + 
  geom_point() + 
  geom_smooth(method = "lm") +
  labs(x = "Bill Length (mm)", 
       y = "Bill Depth (mm)", 
       color = "Penguin Species")
```

- `theme_bw()` -- changes the plotting background to the classic dark-on-light
  ggplot2 theme.
  - This theme may work better for presentations displayed with a projector.
  - Other common themes are `theme_minimal()`, `theme_light()`, and `theme_void()`.


```r
penguins %>% 
  ggplot(aes(x = bill_length_mm, y = bill_depth_mm, color = species)) + 
  geom_point() + 
  geom_smooth(method = "lm") +
  labs(x = "Bill Length (mm)", 
       y = "Bill Depth (mm)", 
       color = "Penguin Species") + 
  theme_bw()
```

- `theme()` -- adjust individual theme elements
  - Possible options are:
    - `panel.grid` -- controls the grid lines (`panel.grid = element_blank()`
      removes grid lines)
    - `text` -- specifies font size for the entire plot (e.g.
      `text = element_text(size = 16)`
    - `axis.text.x` -- specifies the font size for the x-axis text
    - `axis.text.y` -- specifies the font size for the y-axis text
    - `plot.title` -- specifies aspects of the plot title, can use
      `plot.title = element_text(hjust = 0.5)` to centre the title


```r
penguins %>% 
  ggplot(aes(x = bill_length_mm, y = bill_depth_mm, color = species)) + 
  geom_point() + 
  geom_smooth(method = "lm") +
  labs(x = "Bill Length (mm)", 
       y = "Bill Depth (mm)", 
       color = "Penguin Species") + 
  theme_bw() + 
  theme(axis.text.x = element_text(size = 12), 
        axis.text.y = element_text(size = 12))
```

### Exporting Plots

- `ggsave()` -- convenient function for saving a plot
  - Unless specified, defaults to the last plot that was made.
  - Uses the size of the current graphics device to determine the size of the
    plot.


```r
plot1 <- penguins %>% 
  ggplot(aes(x = bill_length_mm, y = bill_depth_mm, color = species)) + 
  geom_point() + 
  geom_smooth(method = "lm") + 
  facet_wrap(~island, nrow = 1)

ggsave(path = "images/faceted_plot.png", plot = plot1)
```


