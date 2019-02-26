################ INSTRUCTIONS ##################################
### Use Ctrl+A (Windows) / Cmd+A (Mac)   to select this entire script
### Then Ctrl+Enter / Cmd+Enter  to run it

### After this completes, run the script '00b_package_check.R'
### to make sure everything installed properly
################################################################



# packages to install for SWMP Status Report workflow
# modified by Kim Cressman from status report script 00_initial_installation.R


pkg_data_wrangle <- c('broom', 'dplyr', 'lubridate', 'magrittr', 'tidyr', 'rlang', 'readxl')
pkg_analysis <- c('EnvStats', 'ggplot2', 'ggthemes', 'scales', 'RColorBrewer', 'stringr')
pkg_map <- c('leaflet', 'maptools', 'rgdal', 'rgeos', 'sp', 'mapview', 'webshot')
pkg_reporting <- c('flextable', 'officer')
pkg_swmp <- c('SWMPr', 'SWMPrExtension', 'devtools')
pkg_ttw_training <- c('rmarkdown', 'knitr', 'ggThemeAssist', 'clifro')



install.packages(c(pkg_data_wrangle, pkg_analysis, pkg_map, 
                   pkg_reporting, pkg_swmp, pkg_ttw_training))


# Load webshot package and install phantomjs
## phantomjs is required to make the grayscale reserve level maps
library(webshot)
install_phantomjs()