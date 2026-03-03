---
title: Instructor Notes
---

## Dataset

The data used for this lesson are a slightly cleaned up version of the
SAFI Survey Results available on GitHub. The original data is on
[figshare](https://figshare.com/articles/dataset/SAFI_Survey_Results/6262019).

This lesson uses `SAFI_clean.csv`. The direct download link for the data file is:
[https://raw.githubusercontent.com/datacarpentry/r-socialsci/main/episodes/data/SAFI_clean.csv](https://raw.githubusercontent.com/datacarpentry/r-socialsci/main/episodes/data/SAFI_clean.csv).

## Lesson Plans

The lesson contains much more material than can be taught in a day. Instructors will 
need to pick an appropriate subset of episodes to use in a standard one day course.

Suggested path for half-day course:

- Before we Start
- Introduction to R
- Starting with Data

Suggested path for full-day course:

- Before we Start
- Introduction to R
- Starting with Data
- Data Wranging with dplyr
- (OPTIONAL) Data Wrangling with tidyr
- Data Visualisation with ggplot2

For a two-day workshop, it may be possible to cover all of the episodes. Feedback from
the community on successful lesson plans is always appreciated!

## Technical Tips and Tricks

Show how to use the 'zoom' button to blow up graphs without constantly resizing
windows.

Sometimes a package will not install. You can try a different CRAN mirror:

- Tools > Global Options > Packages > CRAN Mirror

Alternatively you can go to CRAN and download the package and install from ZIP
file:

- Tools > Install Packages > set to 'from Zip/TAR'

It's often easier to make sure they have all the needed packages installed at one
time, rather than deal with these issues over and over. See the "Setup instructions"
section on the homepage of the course website for package installation instructions.

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


