2019 TTW R Workshop
================

-   [Things to have on your computer **before** the workshop:](#things-to-have-on-your-computer-before-the-workshop)
    -   [Software](#software)
        -   [1. R, v. 3.5.2 or higher](#r-v.-3.5.2-or-higher)
        -   [2. RStudio, v. 1.1.463 or higher](#rstudio-v.-1.1.463-or-higher)
        -   [3. R Packages](#r-packages)
    -   [Reserve-specific data](#reserve-specific-data)
        -   [1. Status Report package](#status-report-package)
        -   [2. Raw sonde and/or MET files](#raw-sonde-andor-met-files)

This page is the central hub of materials for the R training that will be held at the SWMP Technician Training Workshop on March 15, 2019.

Things to have on your computer **before** the workshop:
========================================================

Software
--------

You need to install R first, then RStudio. **You may need a system administrator for installation**, so do this early!

### 1. R, v. 3.5.2 or higher

Download from [CRAN](https://cran.r-project.org/) for any operating system.

### 2. RStudio, v. 1.1.463 or higher

Download the free Desktop version from [RStudio](https://www.rstudio.com/products/rstudio/download/) for any operating system.

### 3. R Packages

There are two `.r` files you need to run. They will be in a pre-workshop email. Save them to your computer (it doesn't matter where). Then, open each in RStudio (first open RStudio, then from the toolbar select `file --> open file` and navigate to it).

The first one to run is: `00a_package_installation.R`: [click here](https://github.com/swmpkim/ttw_2019/blob/master/00a_package_installation.R); either use your downloaded file or copy and paste from that link into RStudio, and follow the instructions at the top.

After that has finished, run `00b_package_check.R` to make sure all packages installed properly; [click here](https://github.com/swmpkim/ttw_2019/blob/master/00b_package_check.R); either use your downloaded file or copy and paste from that link into RStudio, and follow the instructions at the top.

Reserve-specific data
---------------------

### 1. Status Report package

The link for this will be emailed before the workshop. Please download the zip folder!

### 2. Raw sonde and/or MET files

Choose your own adventure on this - bring files straight off your EXOs, and bring a handful of `---_QC.csv` WQ and MET files that are automatically emailed when you upload raw data to the CDMO. Data from Grand Bay will be provided, but it's always more fun to work with your own!
