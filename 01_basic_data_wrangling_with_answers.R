### Intro to scripts and working with data in R

## load the libraries we need
library(lubridate)


## read in a data file that was downloaded through
## the CDMO's AQS - Zip download system

# the specific file we'll work with is gndbhwq2017
# we will tell R to call this "bhwq"
bhwq <- read.csv("data/AQS_zip/gndbhwq2017.csv", stringsAsFactors = FALSE)


### Pop quiz: what kind of object is bhwq?


## examine the data ----

# names
names(bhwq)

# structure: variable type and first few values
str(bhwq)
# notice it sees DateTimeStamp as a character
# and there are trailing spaces after some characters

# first 6 rows
head(bhwq)

# last 6 rows
tail(bhwq)

# numerical summaries
summary(bhwq)




## make a graph ----

# we can already make a simple plot
plot(SpCond ~ Sal, data = bhwq)

# notice the format of that command was a formula: y ~ x

# you make a graph of something that's interesting
# (don't use datetimestamp yet - it's still a character so R will freak out)
plot(DO_mgl ~ Temp, data = bhwq)
# hint: if you don't remember exactly how a column name is specified,
# use names() on the data frame




## dealing with DateTimeStamp ----

# we need a date-time field to be in a format called POSIXct
# there are a few ways to do this

# I'm going to pull out the first 10 rows of the DateTimeStamp column so we can play with different methods:
datetime <- bhwq$DateTimeStamp[1:10]
# the $ specifies a column from our data frame
# the square brackets specify the rows
# square brackets are useful to subset in a LOT of contexts; we'll cover more later


### Pop quiz: what kind of object is datetime?


# the first way to change its format is to use as.POSIXct()
# which is in base R (you don't need any packages)

# you might think this will work:
as.POSIXct(datetime)


# Nope! Pull up the help file so we know how to use this command:
?as.POSIXct


# now specify the exact format that the column is already using
# and specify a timezone
as.POSIXct(datetime, format = "%m/%d/%Y %H:%M", tz = "America/Regina")


## easier way to deal with date-time fields ----

# the lubridate package makes it easier
# the function name is simply the order in which your date-time is formatted:
mdy_hm(datetime, tz = "America/Regina")



## turn that column in the data frame into POSIXct ----
bhwq$DateTimeStamp <- mdy_hm(bhwq$DateTimeStamp, tz = "America/Regina")

# did it work?
str(bhwq$DateTimeStamp)


## make a time-series graph ----
plot(Sal ~ DateTimeStamp, data = bhwq)


## if you hate that x-axis label, you can use axis.POSIXct
# first make the plot, telling it not to include an x-axis:
plot(Sal ~ DateTimeStamp, data = bhwq, xaxt = "n")
# then call axis.POSIXct and specify the format you want the labels to be in:
axis.POSIXct(1, x = bhwq$DateTimeStamp, format = "%m/%d")
# the help file will give you more options:   ?axis.POSIXct



### Challenge ----

### Part 1:
## Make that time-series graph a little nicer!
## Use the help file ( ?plot ) to fill in the blanks below
## Make this a line graph, where the line is blue
## The graph's title is "Salinity at Bayou Heron in 2017"
## and the x- and y- axes have appropriate names

plot(Sal ~ DateTimeStamp, data = bhwq,
     type = "l",
     col = "blue",
     main = "Salinity at Bayou Heron in 2017",
     xlab = "Date/Time",
     ylab = "Salinity (psu)")


### Part 2:
## Read in one of your water quality files,
## or the provided "gndbcwq2017" file,
## and make the same graph, with whatever tweaks you like

bcwq <- read.csv("data/AQS_zip/gndbcwq2017.csv", stringsAsFactors = FALSE)
bcwq$DateTimeStamp <- mdy_hm(bcwq$DateTimeStamp, tz = "America/Regina")

# hint: don't remember which command from lubridate to use? see if
# the top few values of your data will help you figure it out
# by running   head(----$DateTimeStamp)

plot(Sal ~ DateTimeStamp, data = bcwq,
     type = "l",
     col = "red",
     main = "Salinity at Bayou Cumbest in 2017",
     xlab = "Date/Time",
     ylab = "Salinity (psu)")

### Remember to put the blue sticky-note on your laptop when you finish!
### And use the orange if you need help.

