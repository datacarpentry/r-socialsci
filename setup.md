---
layout: page
title: Setup
---

## Setup instructions

**R** and **RStudio** are separate downloads and installations. R is the
underlying statistical computing environment, but using R alone is no
fun. RStudio is a graphical integrated development environment (IDE) that makes
using R much easier and more interactive. You need to install R before you
install RStudio. Once installed, because RStudio is an IDE, RStudio will run R in 
the background.  You do not need to run it separately. 

After installing both programs, 
you will need to install the **`tidyverse`** package from within RStudio. The 
**`tidyverse`** package is a powerful collection of data science tools within **R** 
see the [**`tidyverse`** website](https://tidyverse.tidyverse.org) for more details. 
Follow the instructions below for your operating system, and then follow the 
instructions to install **`tidyverse`**.

### Windows

#### If you already have R and RStudio installed

* Open RStudio, and click on "Help" > "Check for updates". If a new version is
	available, quit RStudio, and download the latest version for RStudio.
* To check which version of R you are using, start RStudio and the first thing
  that appears in the console indicates the version of R you are
  running. Alternatively, you can type `sessionInfo()`, which will also display
  which version of R you are running. Go on
  the [CRAN website](https://cran.r-project.org/bin/windows/base/) and check
  whether a more recent version is available. If so, you can update R using
  the `installr` package, by running:
  
~~~
if( !("installr" %in% installed.packages()) ){install.packages("installr")}
installr::updateR(TRUE)
~~~
{: .language-r}

#### If you don't have R and RStudio installed

* Download R from
  the [CRAN website](http://cran.r-project.org/bin/windows/base/release.htm).
* Run the `.exe` file that was just downloaded.
* Go to the [RStudio download page](https://www.rstudio.com/products/rstudio/download/#download).
* Under *Installers* select **RStudio x.yy.zzz - Windows.
  Vista/7/8/10** (where x, y, and z represent version numbers).
* Double click the file to install it.
* Once it's installed, open RStudio to make sure it works and you don't get any
  error messages.


### macOS

#### If you already have R and RStudio installed

* Open RStudio, and click on "Help" > "Check for updates". If a new version is
	available, quit RStudio, and download the latest version for RStudio.
* To check the version of R you are using, start RStudio and the first thing
  that appears on the terminal indicates the version of R you are running. Alternatively, you can type `sessionInfo()`, which will also display which version of R you are running. Go on
  the [CRAN website](https://cran.r-project.org/bin/macosx/) and check
  whether a more recent version is available. If so, please download and install
  it. In any case, make sure you have at least R 3.2.

#### If you don't have R and RStudio installed

* Download R from
  the [CRAN website](http://cran.r-project.org/bin/macosx/).
* Select the `.pkg` file for the latest R version.
* Double click on the downloaded file to install R.
* It is also a good idea to install [XQuartz](https://www.xquartz.org/) (needed
  by some packages).
* Go to the [RStudio download page](https://www.rstudio.com/products/rstudio/download/#download).
* Under *Installers* select **RStudio x.yy.zzz - Mac OS X 10.6+ (64-bit)**
  (where x, y, and z represent version numbers).
* Double click the file to install RStudio.
* Once it's installed, open RStudio to make sure it works and you don't get any
  error messages.


### Linux

* Follow the instructions for your distribution
  from [CRAN](https://cloud.r-project.org/bin/linux), they provide information
  to get the most recent version of R for common distributions. For most
  distributions, you could use your package manager (e.g., for Debian/Ubuntu run
  `sudo apt-get install r-base`, and for Fedora `sudo yum install R`), but we
  don't recommend this approach as the versions provided by this approach are
  usually out of date. In any case, make sure you have at least R 3.2.
* Go to the
  [RStudio download page](https://www.rstudio.com/products/rstudio/download/#download).
* Under *Installers* select the version that matches your distribution, and
  install it with your preferred method (e.g., with Debian/Ubuntu `sudo dpkg -i
  rstudio-x.yy.zzz-amd64.deb` at the terminal).
* Once it's installed, open RStudio to make sure it works and you don't get any
  error messages.
* Before installing the `tidyverse` package, **Ubuntu** (and related) users may
  need to install the following dependencies: `libcurl4-openssl-dev libssl-dev libxml2-dev`
  (e.g. `sudo apt install libcurl4-openssl-dev libssl-dev libxml2-dev`).

### For everyone

**After installing R and RStudio, you need to install the `tidyverse` and `here` packages.**

* After starting RStudio, at the console type:
  `install.packages("tidyverse")` followed by the enter key. Once this has installed, type 
  `install.packages("here")` followed by the enter key. Both packages should now be installed.

* For reference, the lesson uses `SAFI_clean.csv`. The direct download link for
this file is: <https://ndownloader.figshare.com/files/11492171>. To download
from `R`:

`download.file("https://ndownloader.figshare.com/files/11492171","data/SAFI_clean.csv", mode = "wb")`

* The [json episode](https://datacarpentry.org/r-socialsci/06-json/index.html) uses 
`SAFI.json`. The downlink link is <https://datacarpentry.org/r-socialsci/data/SAFI.json>.
