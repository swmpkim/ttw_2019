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
class(bhwq)  # type of object
nrow(bhwq)   # number of rows
ncol(bhwq)   # number of columns
dim(bhwq)    # could just get both dimensions at once
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

# could use unique() to check out a single column:
unique(bhwq$f_ph)

# run the qaqc function, making a new data frame:
bhwq_qaqc <- qaqc(bhwq)


# (what happens if we forget to assign it to something?)
qaqc(bhwq)




## it just prints to the console and we can't do anything else with it





## but we did assign it to an object. what do you notice about it?
class(bhwq_qaqc)
dim(bhwq_qaqc)
head(bhwq_qaqc)
tail(bhwq_qaqc)
str(bhwq_qaqc)
names(bhwq_qaqc)




## f_ columns are gone
## "bad" data was replaced with NAs



## The default for the qaqc() function is to only keep 0 flags
# you can make it keep others using qaqc_keep:
# (assigning this to a different data frame so we can compare them later)
bhwq_qaqc2 <- qaqc(bhwq, qaqc_keep = c(0, 1, 4))



### Challenge ----
## read in and qaqc your own water quality data
## or you can use gndbcwq

# import data
------  <-  --------(data_path, "-----")

# run qaqc step, keeping only 0 flags
----_qaqc <- -----(-----)

# run qaqc step, keeping 0, 1, and 4 flags
----_qaqc2 <- ----(-----, ----- = c(0, 1, 4))



## we're going to use the Bayou Heron data again here, but
## I encourage you to type in code to examine the data frame you just made

# see how these two data frames are different:
summary(bhwq_qaqc)
summary(bhwq_qaqc2)


## we should have fewer NAs when we kept more qc codes
# (fewer NAs in qaqc2 than in qaqc)
# how do we count NAs?
# (let's just look at salinity)

is.na(bhwq_qaqc$sal)



## fortunately, R "sees" TRUE as 1 and FALSE as 0
## so we can add up how many TRUEs there are,
## using the sum() function:
sum(is.na(bhwq_qaqc$sal))


# getting tired of typing that all out, so I'm going to assign it to an object:
na1 <- sum(is.na(bhwq_qaqc$sal))


# and now we can find out how many are in the other data frame
sum(is.na(bhwq_qaqc2$sal))
na2 <- sum(is.na(bhwq_qaqc2$sal))


# we can actually ask R if one is less than the other:
na2 < na1


# or greater
na2 > na1


# or equal to
#### NOTICE THE DOUBLE EQUALS SIGN
# this is how we query equality
na2 == na1




# keeping things gets tougher when you want to keep certain combinations
# (like 1 SDG) because of the () and [] in our codes -
# R sees those as special characters, so you need some backslashes to 
# tell it they're part of a character string
# but it can be done.

# for example, we only want to keep 0 and 1 SDG (but not other 1s):
bhwq_qaqc3 <- qaqc(bhwq, qaqc_keep = c(0, "<1> \\[SDG\\]"))

# compare pH NAs to the other ways we qc'd:
sum(is.na(bhwq_qaqc$ph))    # only 0s kept
sum(is.na(bhwq_qaqc2$ph))   # 0, all 1s, and 4 kept
sum(is.na(bhwq_qaqc3$ph))   # 0 and ONLY 1 SDG
