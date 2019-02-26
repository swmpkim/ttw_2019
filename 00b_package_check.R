################ INSTRUCTIONS ##################################
### Use Ctrl+A (Windows) / Cmd+A (Mac)   to select this entire script
### Then Ctrl+Enter / Cmd+Enter  to run it
### Then check the output in your console and see if you 
### need to re-install any packages

### If you do, I recommend trying one at a time, using the command
### install.packages("package_name_here")

### Then re-run this script to make sure everything worked

### If you have any problems, contact Kim

################################################################

# list of packages we need to have installed for our workflow
# original vectors copied out of status report script 00_initial_installation.R

pkg_data_wrangle <- c('broom', 'dplyr', 'lubridate', 'magrittr', 'tidyr', 'rlang', 'readxl')
pkg_analysis <- c('EnvStats', 'ggplot2', 'ggthemes', 'scales', 'RColorBrewer', 'stringr')
pkg_map <- c('leaflet', 'maptools', 'rgdal', 'rgeos', 'sp', 'mapview', 'webshot')
pkg_reporting <- c('flextable', 'officer')
pkg_swmp <- c('SWMPr', 'SWMPrExtension', 'devtools')
pkg_ttw_training <- c('rmarkdown', 'knitr', 'ggThemeAssist')


# glue the sub-categories together into one vector of packages we need
pkgs_needed <- c(pkg_data_wrangle, pkg_analysis, pkg_map, 
                 pkg_reporting, pkg_swmp, pkg_ttw_training)


# use installed.packages() to find out if the ones we want are installed
# this returns a giant data frame;
# we want all rows, but only the first column
pkgs_installed <- installed.packages()[ , 1]


# make and print a vector of packages on our "pkgs_needed" list that
# are *not* in the list of pkgs_installed
pkgs_missing_index <- which(!(pkgs_needed %in% pkgs_installed))
pkgs_missing <- pkgs_needed[pkgs_missing_index]


# print the results of this check to the console
if(length(pkgs_missing) == 0){
        message("All required packages are installed!")
} else{ message("You need to install the following packages: "); cat(pkgs_missing, sep="\n") }
