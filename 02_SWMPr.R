### Intro to SWMPr  

# SWMPr is an R package developed by Marcus Beck
# specifically to make certain taks involving SWMP data easier
# this is where you can find lots of info:
# https://github.com/fawda123/SWMPr#overview

# Additionally, links to past workshops are on swmprats.net
# Materials for the 2015 workshop are here: 
# http://swmprats.net/workshop-2015

# Materials for the 2016 workshop are here, 
# as are recordings of the training sessions:
# http://swmprats.net/2016-workshop


## load libraries  
library(SWMPr)


## read in data ----

# first tell R where to look (this can be different
# from your working directory, and may need to start with C://)
data_path <- "data/AQS_zip"

# now read in all files that have what we specify
# this will glue together multiple years
bhwq <- import_local(data_path, "gndbhwq")


## examine the data  
head(bhwq)
tail(bhwq)
str(bhwq)

## what do you notice about this data frame?  


## (classes of object?)
## (start and end dates?)
## (format of datetimestamp?)
## (parameter names?)
## (trailing white space?)



## qaqc functions ----

# see what qaqc codes are present:
qaqcchk(bhwq)

# run the qaqc function, making a new data frame:
bhwq_qaqc <- qaqc(bhwq)

# what do you notice about this object?
head(bhwq_qaqc)
tail(bhwq_qaqc)
str(bhwq_qaqc)




## f_ columns are gone
## "bad" data was replaced with NAs



## The default for the qaqc() function is to only keep 0 flags
# you can make it keep others using qaqc_keep:
bhwq_qaqc2 <- qaqc(bhwq, qaqc_keep = c(0, 1, 4))

# this gets tougher when you want to keep certain combinations
# (like 1 SDG) because of the <>, (), and [] in our codes
# but it can be done: