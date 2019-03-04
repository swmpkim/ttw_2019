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
pkg_ttw_training <- c('rmarkdown', 'knitr', 'ggThemeAssist', 'clifro', 'cowplot')


# glue the sub-categories together into one vector of packages we need
pkgs_needed <- c(pkg_data_wrangle, pkg_analysis, pkg_map, 
                 pkg_reporting, pkg_swmp, pkg_ttw_training)



## now try loading each one and see if it works
# set up an output vector
pkg_result <- vector("logical", length(pkgs_needed))
# loop through the needed packages
for(i in seq_along(pkgs_needed)){
        # try to load the package and report whether it works
        # record that TRUE or FALSE in the pkg_result vector
        pkg_result[i] <- library(pkgs_needed[i], character.only = TRUE, quietly = TRUE, logical.return = TRUE)
}


# make a vector of missing packages:
# pkgs_needed that failed to load
pkgs_missing <- pkgs_needed[!pkg_result]


# print the results to the console
if(length(pkgs_missing) == 0){
        message("\n \nAll required packages are installed and loading properly! \n \n")
} else{ message("\n \nYou need to install the following packages: "); cat(pkgs_missing, sep="\n") }
