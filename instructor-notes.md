---
title: Instructor Notes
---

## Dataset

The data used for this lesson are in the figshare repository at: [https://figshare.com/articles/SAFI\_Survey\_Results/6262019](https://figshare.com/articles/SAFI_Survey_Results/6262019).

This lesson uses `SAFI_clean.csv`. The direct download link for this file is:
[https://ndownloader.figshare.com/files/11492171](https://ndownloader.figshare.com/files/11492171).

## Narrative

### Before we start

- The main goal here is to help the learners be comfortable with the RStudio
  interface.
- Go very slowly in the "Getting set up" section. Make sure everyone is following
  along (remind learners to use the stickies). Plan with the helpers at this
  point to go around the room, and be available to help. It's important to make
  sure that learners are in the correct working directory, and that they create
  a `data` (all lowercase) subfolder.

### Intro to R

### Starting with data

The two main goals for this lessons are:

- To make sure that learners are comfortable with working with data frames, and
  can use the bracket notation to select slices/columns.
- To expose learners to factors. Their behavior is not necessarily intuitive,
  and so it is important that they are guided through it the first time they are
  exposed to it. The content of the lesson should be enough for learners to
  avoid common mistakes with them.

### Data wrangling with dplyr and tidyr

- This lesson works better if you have graphics demonstrating dplyr commands.
  You can modify [this Google Slides deck](https://docs.google.com/presentation/d/1A9abypFdFp8urAe9z7GCMjFr4aPeIb8mZAtJA2F7H0w/edit#slide=id.g652714585f_0_114) and use it for your workshop.
- For this lesson make sure that learners are comfortable using pipes.
- There is also sometimes some confusion on what the arguments of `group_by`
  should be, and when to use `filter()` and `select()`.

### Visualizing data with ggplot2

- This lesson is a broad overview of ggplot2 and focuses on (1) getting familiar
  with the layering system of ggplot2, (2) using the argument `group` in the
  `aes()` function, (3) basic customization of the plots.

### Getting started with R Markdown (Optional)

- This is an optional lesson intended to introduce learners to R Markdown.
- While it is listed after the core lessons, some instructors may prefer to teach it early
  in the workshop, depending on the audience.

### Processing JSON data (Optional)

- This is an optional lessons intended to introduce learners to JSON data, as well as how to
  read JSON data into R and how to convert the data into a data frame or array.
- Note that his lesson was community-contributed and remains a work in progress. As such, it could
  benefit from feedback from instructors and/or workshop participants.

## Technical Tips and Tricks

Show how to use the 'zoom' button to blow up graphs without constantly resizing
windows.

Sometimes a package will not install. You can try a different CRAN mirror:

- Tools > Global Options > Packages > CRAN Mirror

Alternatively you can go to CRAN and download the package and install from ZIP
file:

- Tools > Install Packages > set to 'from Zip/TAR'

It's often easier to make sure they have all the needed packages installed at one
time, rather than deal with these issues over and over.
[Here is a list of all necessary packages for these lessons.](https://github.com/datacarpentry/R-ecology-lesson/blob/master/needed_packages.R)

**`|` character on Spanish keyboards:** The Spanish Mac keyboard does not have a `|` key.
This character can be created using:

```
`alt` + `1`
```

## Other Resources

If you encounter a problem during a workshop, feel free to contact the
maintainers by email or [open an
issue](https://github.com/datacarpentry/r-socialsci/issues/new).

For a more in-depth coverage of topics of the workshops, you may want to read "[R for Data Science](http://r4ds.had.co.nz/)" by Hadley Wickham and Garrett Grolemund.


