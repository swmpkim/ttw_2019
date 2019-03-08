library(SWMPrExtension)

# the manual table of contents is a good place to find the functions:
# https://cran.r-project.org/web/packages/SWMPrExtension/SWMPrExtension.pdf


data_path <- "data/AQS_zip"
bhwq <- import_local(data_path, "gndbhwq", trace = TRUE)
bhwq <- qaqc(bhwq)


seasonal_dot(bhwq, param = "temp")

seasonal_dot(bhwq, param = "temp", lm_trend = TRUE)



#### seasonal kendall trend test
# this function is a "wrapper" for a function from the
# EnvStats package: kendallSeasonalTrendTest
sk_seasonal(bhwq, param = "temp")
sk_seasonal(bhwq, param = "sal")  # defaults to monthly mean

sk_seasonal(bhwq, param = "sal", FUN = median) # you can change that
sk_seasonal(bhwq, param = "sal", FUN = min)






## you can also return the EnvStats output if you want it:
sk_seasonal(bhwq, param = "sal", envStats_summary = TRUE)



######### threshold exceedences
do_exc <- threshold_identification(bhwq, param = "do_mgl",
                         parameter_threshold = 2,
                         threshold_type = "<",
                         time_threshold = 2)
head(do_exc)
nrow(do_exc)


threshold_criteria_plot(bhwq, param = "do_mgl", 
                        thresholds = c(2, 6),
                        threshold_labs = c("really?", "okay", "great!"),
                        monthly_smooth = TRUE)

# default colors show high values as bad; we can change them
?threshold_criteria_plot   # so we can see what the default values are

threshold_criteria_plot(bhwq, param = "do_mgl", 
                        thresholds = c(2, 6),
                        threshold_labs = c("really?", "okay", "great!"),
                        monthly_smooth = TRUE,
                        threshold_cols = c('#ABD9E9', '#FFFFCC', '#FEC596'))
ggsave("output/do_exceedences.png")



# percentile plots (if no objective threshold)
threshold_percentile_plot(bhwq, param = "temp",
                          hist_rng = c(2013, 2017),
                          target_yr = 2017)


####### threshold summary plots
threshold_summary(bhwq, param = "do_mgl", summary_type = "month",
                  parameter_threshold = 2,
                  threshold_type = c("<"),
                  time_threshold = 2) +
        theme(legend.spacing.x = unit(6, 'pt'))
