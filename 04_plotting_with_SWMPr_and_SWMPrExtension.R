library(SWMPr)
library(SWMPrExtension)
# library(cowplot)  we will load this later because it messes with some defaults
# so we don't want to load it till we need it. it is otherwise fantastic.


# assuming wq and met data are still loaded up
# if not, read some in again with import_local
# and run the qaqc step


## SWMPr does have some additional non-plotting functions that you should check out:

#   na.approx()   to linearly interpolate missing values (NAs)
#   comb()        for combining different types of data (wq + met + nut)
#   ecometab()    given WQ and MET data, calculates ecosystem metabolism
#                 based on the open-water method
#   decomp() and decompcj()    decompose a time series into trend, seasonal,
#                 and residual components
#   cens_id()     for nutrients - create a column to identify readings that
#                 are below detection or at the detection limit
#   overplot()    a way to plot with multiple axes (use with caution)



## now we'll focus on some plotting functions
## they're really quite easy; just pick a parameter to look at

###########################################

# SWMPr plots

###########################################

# summary plots ----
# like the SWMPrats widget!
plot_summary(bhwq_qaqc, param = "sal")
plot_summary(met_qc, param = "atemp")
# now you pick one:
------(----, -----)



# wind roses! ----
# default is most recent year
plot_wind(met_qc)

# can specify a range of years
plot_wind(met_qc, years = 2016:2018)

# can divide up by month
plot_wind(met_qc, years = 2016:2018, type = "month")
# or by season
plot_wind(met_qc, years = 2016:2018, type = "season")
# or others; look in the help file

# you make one!
------(---)



# historical quantiles ----
# this was inspired by the needs and graphs of some of you
# and a version of it has ended up in the status reports too
plot_quants(met_qc, paramtoplot = "atemp", 
            yr = 2018, yrstart = 2016, yrend = 2017)

# your turn. include arguments for years.
------(-----, paramtoplot = "----")


###########################################

# SWMPrExtension plots

###########################################

## historical range plots ----

# using defaults:
historical_range(met_qc, param = "atemp")

# using a different historical range:
historical_range(met_qc, param = "atemp",
                 hist_rng = 2016:2017,
                 target_yr = 2018)


# another option is to include a horizontal line for some threshold:
historical_range(met_qc, param = "atemp",
                 hist_rng = 2016:2017,
                 target_yr = 2018,
                 criteria = 25)

# did you notice that legend? how do we fix it?
?historical_range

historical_range(met_qc, param = "atemp",
                 hist_rng = 2016:2017,
                 target_yr = 2018,
                 criteria = 25,
                 ------ = "MET threshold")


# by day instead of by month
historical_daily_range(met_qc, param = "atemp",
                       hist_rng = 2016:2017,
                       target_yr = 2018)


## your turn: make something fun using one of these functions
---------(------, param = -----)





## boxplots ----

raw_boxplot(met_qc, "atemp")
seasonal_boxplot(met_qc, "atemp")


# notice those warnings that tell us we haven't specified certain things
# so let's look in the help file
?raw_boxplot
# and specify something here:
raw_boxplot(met_qc, "atemp", target_yr = 2018)
# what did that do?



# seasonal boxplot is a little different
?seasonal_boxplot




seasonal_boxplot(met_qc, "atemp", 
                 hist_rng = 2016:2017,
                 target_yr = 2018)


seasonal_boxplot(met_qc, "atemp", 
                 hist_rng = 2016:2017,
                 target_yr = 2018,
                 plot_title = TRUE) 


##### Some things to notice about the SWMPrExtension plots

## if you like something from the status report output,
## you can make it using a function with the same name as the folder
## that the plot was in

## they are based on ggplot2, so
## to fiddle with formatting, it is useful to know something about ggplot2

# so let's talk a bit about options
# ggplot2 and SWMPr/SWMPrExtension ----

# ggplot2 builds graphs using layers
# we will go into more detail a bit later, but will start with the easy stuff:
# adding to already-made SWMPrExtension plots

# let's give the seasonal boxplot a different title, and an x-axis label

seasonal_boxplot(met_qc, "atemp", 
                 hist_rng = 2016:2017,
                 target_yr = 2018,
                 plot_title = TRUE)  + 
        labs(title = "Air Temp at Crooked Bayou",
             subtitle = "2018, compared to 2016 and 2017",
             x = "Month")


# highlight the seasonal_boxplot call,
# then go up to the add-ins menu and select ggThemeAssist
# we can fix some of these irritating formatting issues
# we can click around to choose and change things,
# and when we select "done", code is added below:
seasonal_boxplot(met_qc, "atemp", 
                 hist_rng = 2016:2017,
                 target_yr = 2018,
                 plot_title = TRUE)  




# assign that to an object so we can use it again later
atemp_plot <- seasonal_boxplot(met_qc, "atemp", 
                              hist_rng = 2016:2017,
                              target_yr = 2018,
                              plot_title = TRUE)  + 
        theme(plot.subtitle = element_text(hjust = 0.5), 
              legend.position = "bottom") +
        labs(title = "Air Temp at Crooked Bayou", 
             x = "Month", subtitle = "2018, compared to 2016 and 2017")

# another great function from ggplot2 is ggsave()
ggsave(filename = "atemp_plot.png", plot = atemp_plot)


# we may want that to go into our output folder, and we can specify that in 
# the filename. let's also change the size and resolution.
ggsave(filename = "output/atemp_plot2.png", plot = atemp_plot,
       width = 5, height = 4, units = "in", dpi = 400)


# now make one of water temp, either from our bayou heron data frame
# or with your own water quality data
wtemp_plot <- seasonal_boxplot(bhwq_qaqc, "temp", 
                               hist_rng = 2016:2017,
                               target_yr = 2018,
                               plot_title = TRUE)  + 
        theme(plot.subtitle = element_text(hjust = 0.5), 
              legend.position = "bottom") +
        labs(title = "Water Temp at Bayou Heron", 
             x = "Month", subtitle = "2018, compared to 2016 and 2017")

# look at it
wtemp_plot


# save it
ggsave(filename = ------, plot = -----)


# let's put them both together, using cowplot
library(cowplot)

# plot_grid is the function we want
plot_grid(atemp_plot, wtemp_plot)


?plot_grid


# tell it to only use one column
plot_grid(atemp_plot, wtemp_plot, ncol = 1)


# and make sure axes are aligned
plot_grid(atemp_plot, wtemp_plot, ncol = 1, align = "hv")



# about to get very tired of this, so assign it to an object
gridded_temps <- plot_grid(atemp_plot, wtemp_plot, ncol = 1, align = "hv")


# let's put this thing in a different window so we can play with the size
windows()
gridded_temps
dev.size()

# save it with those sizes
ggsave("output/gridded_temps.png", gridded_temps,
       width = 7.5, height = 9.2, units = "in",
       dpi = 400)
