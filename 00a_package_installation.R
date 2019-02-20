# packages to install for SWMP Status Report workflow
# modified by Kim Cressman from status report script 00_initial_installation.R


pkg_data_wrangle <- c('broom', 'dplyr', 'lubridate', 'magrittr', 'tidyr', 'rlang', 'readxl')
pkg_analysis <- c('EnvStats', 'ggplot2', 'ggthemes', 'scales', 'RColorBrewer', 'stringr')
pkg_map <- c('leaflet', 'maptools', 'rgdal', 'rgeos', 'sp', 'mapview', 'webshot')
pkg_reporting <- c('flextable', 'officer')
pkg_swmp <- c('SWMPr', 'SWMPrExtension', 'devtools')


install.packages(c(pkg_data_wrangle, pkg_analysis, pkg_map, pkg_reporting, pkg_swmp))


# Load webshot package and install phantomjs
## phantomjs is required to make the grayscale reserve level maps
library(webshot)
install_phantomjs()