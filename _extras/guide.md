---
layout: page
title: "Instructor Notes"
---

## Dataset

The data used for this lesson are in the figshare repository at: <https://figshare.com/articles/SAFI_Survey_Results/6262019>.

This lesson uses `SAFI_clean.csv`. The direct download link for this file is:
<https://ndownloader.figshare.com/files/11492171>.

When time comes in the lesson to use this file, we recommend that the
instructors, place the `download.file()` command in the Etherpad, and that the
learners copy and paste it in their scripts to download the file directly from
figshare in their working directory. . If the learners haven't created the
`data/` directory and/or are not in the correct working directory, the
`download.file` command will produce an error. Therefore, it is important to use
the stickies at this point.

## RStudio and Multiple R Installs

Some learners may have previous R installations. On Mac, if a new install is
performed, the learner's system will create a symbolic link, pointing to the new
install as 'Current.' Sometimes this process does not occur, and, even though a
new R is installed and can be accessed via the R console, RStudio does not find
it. The net result of this is that the learner's RStudio will be running an
older R install. This will cause package installations to fail. This can be
fixed at the terminal. First, check for the appropriate R installation in the
library;

```
ls -l /Library/Frameworks/R.framework/Versions/
```

We are currently using R 3.x.y If it isn't there, they will need to install it.
If it is present, you will need to set the symbolic link to Current to point to
the 3.x.y directory:

```
ln -s /Library/Frameworks/R.framework/Versions/3.x.y /Library/Frameworks/R.framework/Version/Current
```

Then restart RStudio.

## Narrative

### Before we start

* The main goal here is to help the learners be comfortable with the RStudio
  interface. We use RStudio because it helps make using R more organized and
  user friendly.
* Go very slowly in the "Getting setup section". Make sure everyone is following
  along (remind learners to use the stickies). Plan with the helpers at this
  point to go around the room, and be available to help. It's important to make
  sure that learners are in the correct working directory, and that they create
  a `data`  (all lowercase) subfolder.

### Intro to R

* When going over the section on assignments, make sure to pause for at least 30
  seconds when asking "What do you think is the current content of the object
  `area_acres`? 123.5 or 6.175?". For learners with no programming experience,
  this is a new and important concept.
* Given that the concept of missing data is an important feature of the R
  language, it is worth spending enough time on it.

### Starting with data

The two main goals for this lessons are:

* To make sure that learners are comfortable with working with data frames, and
  can use the bracket notation to select slices/columns
* To expose learners to factors. Their behavior is not necessarily intuitive,
  and so it is important that they are guided through it the first time they are
  exposed to it. The content of the lesson should be enough for learners to
  avoid common mistakes with them.

### Manipulating data with dplyr

* This lesson works better if you have graphics demonstrating dplyr commands. 
  You can modify [this Google Slides deck](https://docs.google.com/presentation/d/1A9abypFdFp8urAe9z7GCMjFr4aPeIb8mZAtJA2F7H0w/edit#slide=id.g652714585f_0_114) and use it for your workshop.
* For this lesson make sure that learners are comfortable using pipes.
* There is also sometimes some confusion on what the arguments of `group_by`
  should be, and when to use `filter()` and `select()`.
  
### Visualizing data with ggplot2

* This lesson is a broad overview of ggplot2 and focuses on (1) getting familiar
  with the layering system of ggplot2, (2) using the argument `group` in the
  `aes()` function, (3) basic customization of the plots.


## Technical Tips and Tricks

Show how to use the 'zoom' button to blow up graphs without constantly resizing
windows

Sometimes a package will not install, try a different CRAN mirror
- Tools > Global Options > Packages > CRAN Mirror

Alternatively you can go to CRAN and download the package and install from ZIP
file
-   Tools > Install Packages > set to 'from Zip/TAR'

It is important that R, and the R packages be installed locally, not on a network drive. If a learner is using a machine with multiple users where their account is not based locally this can create a variety of issues (This often happens on university computers). Hopefully the learner will realize these issues before hand, but depending on the machine and how the IT folks that service the computer have things set up, it may be very difficult to impossible to make R work without their help. 

If learners are having issues with one package, they may have issues with another. It's often easier to make sure they have all the needed packages installed at one time, rather then deal with these issues over and over. [Here is a list of all necessary packages for these lessons.](https://github.com/datacarpentry/R-ecology-lesson/blob/master/needed_packages.R)

## Other Resources

If you encounter a problem during a workshop, feel free to contact the
maintainers by email or [open an
issue](https://github.com/datacarpentry/r-socialsci/issues/new).

For a more in-depth coverage of topics of the workshops, you may want to read "[R for Data Science](http://r4ds.had.co.nz/)" by Hadley Wickham and Garrett Grolemund.
