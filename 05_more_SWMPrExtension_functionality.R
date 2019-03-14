library(SWMPrExtension)

# the table of contents in the SWMPrExtension manual is a good place to find the functions:
# https://cran.r-project.org/web/packages/SWMPrExtension/SWMPrExtension.pdf


# we'll work with wq data
# if not still loaded, uncomment and run the following lines
# data_path <- "data/AQS_zip"
# bhwq <- import_local(data_path, "gndbhwq", trace = TRUE)
# bhwq_qaqc <- qaqc(bhwq)



## we can see what different parameters look like over time
seasonal_dot(bhwq_qaqc, param = "temp")
seasonal_dot(bhwq_qaqc, param = "temp", lm_trend = TRUE)


# we can see if trends are significant using a seasonal kendall trend test

# this function is a "wrapper" for a function from the
# EnvStats package: kendallSeasonalTrendTest
sk_seasonal(bhwq_qaqc, param = "temp")
sk_seasonal(bhwq_qaqc, param = "sal")  # defaults to monthly mean

sk_seasonal(bhwq_qaqc, param = "sal", FUN = median) # you can change that
sk_seasonal(bhwq_qaqc, param = "sal", FUN = min)


## you can also return the EnvStats output if you want it:
sk_seasonal(bhwq_qaqc, param = "sal", envStats_summary = TRUE)



######### threshold exceedences based on specified criteria

# get a table
do_exc <- threshold_identification(bhwq_qaqc, param = "do_mgl",
                         parameter_threshold = 2,
                         threshold_type = "<",
                         time_threshold = 2)
head(do_exc)
nrow(do_exc)


####### threshold summary plots
# see the exceedence counts on a graph
threshold_summary(bhwq_qaqc, param = "do_mgl", summary_type = "month",
                  parameter_threshold = 2,
                  threshold_type = c("<"),
                  time_threshold = 2) +
        theme(legend.spacing.x = unit(6, 'pt'))




# make a graph of the data, with different zones for "good/fair/poor" ranges
threshold_criteria_plot(bhwq_qaqc, param = "do_mgl", 
                        thresholds = c(2, 6),
                        threshold_labs = c("really?", "okay", "great!"),
                        monthly_smooth = TRUE)



# default colors show high values as bad; we can change them
?threshold_criteria_plot   # so we can see what the default values are

threshold_criteria_plot(bhwq_qaqc, param = "do_mgl", 
                        thresholds = c(2, 6),
                        threshold_labs = c("really?", "okay", "great!"),
                        monthly_smooth = TRUE,
                        threshold_cols = c('#ABD9E9', '#FFFFCC', '#FEC596'))

# and save it
ggsave("output/do_exceedences.png")



# percentile plots (if no objective threshold)
threshold_percentile_plot(bhwq_qaqc, param = "temp",
                          hist_rng = c(2013, 2017),
                          target_yr = 2017) 



