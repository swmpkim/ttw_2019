### Intro to scripts and working with data in R

#  comments vs. code that will run

### always be careful about:
# capitalization
# parentheses
# spelling
# commas



## load the libraries we need
# good practice to do this at the top of the script
library(lubridate)




## objects and functions ----

# "everything that exists [in R] is an object
# everything that happens is a function call"
# --John Chambers

### types of objects:


# atomic vectors: character, logical, numeric-double, numeric-integer



## examples:

my_first_vector <- c(1, 1.5, 2, 2.5)   
# vocab: assignment operator; c()

# what kind of vector did we make?
class(my_first_vector)
# is it numeric?
is.numeric(my_first_vector)
# what kind of number?
is.double(my_first_vector)
is.integer(my_first_vector)




my_second_vector <- c(1, 2, 3, 4)
# what kind of vector is this? double or integer?
class(my_second_vector)



my_third_vector <- c(1L, 2L, 3L, 4L)
class(my_third_vector)



another_vector <- c("a", "b", "c", "d")
class(another_vector)



last_vector_for_now <- c("a", "b", 1, 2)
## what to do with this?

class(last_vector_for_now)
# coercion




## subset a vector:
# just one value:
another_vector[2]

# everything *but* one value:
another_vector[-2]


# multiple values
another_vector[2:4]
another_vector[c(2, 4)]







# data frames
## example: any data file we read in
## seen by R as a collection of columns
## and the columns can be used and manipulated as vectors



# matrices
# lists

# functions
## yes, functions are also objects
## they take "arguments" and return another object

# one of the most basic functions is "mean" -
# so let's start by finding the mean of our numeric vector above:
mean(my_first_vector)

# min and max are similar
min(my_first_vector)
max(my_first_vector)


# missing values are represented by NA
one_more_vector <- c(1, 3, NA, 7, 9)

# what kind of vector is this?
class(one_more_vector)

# mean:
mean(one_more_vector)





# uh-oh. we have to tell it to ignore that NA.
# to do that, use na.rm = TRUE
mean(one_more_vector, na.rm = TRUE)

# min and max work the same way
min(one_more_vector)
min(one_more_vector, na.rm = TRUE)




#### takeaways so far:
# assignment operator,  <-
# objects are things, and functions are actions
# what a vector represents
# how to tell what type of vector you're looking at
# how to subset a vector
# you can do things (math) to vectors
# NAs matter





## working with data frames ----

## read in a data file that was downloaded through
## the CDMO's AQS - Zip download system

# the specific file we'll work with is gndbhwq2017
# we will tell R to call this "bhwq"
bhwq <- read.csv("data/AQS_zip/gndbhwq2017.csv", stringsAsFactors = FALSE)


### Pop quiz: what kind of object is bhwq?
class(bhwq)


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




#### how do we find mean salinity?
mean(bhwq$Sal, ------ = TRUE)
# the dollar sign lets you specify a single column of a data frame



## make a graph ----

# we can already make a simple plot
plot(SpCond ~ Sal, data = bhwq)

# notice the format of that command was a formula: y ~ x



#### you make a graph of something that's interesting
# (don't use datetimestamp yet - it's still a character so R will freak out)
plot(--- ~ ---, data = bhwq)

# hint: if you don't remember exactly how a column name is specified,
# use names() on the data frame




## dealing with DateTimeStamp ----

# we need a date-time field to be in a format called POSIXct
# there are a few ways to do this

# I'm going to pull out the first 10 rows of the DateTimeStamp column so we can play with different methods:
datetime <- bhwq$DateTimeStamp[1:10]
# the $ specifies a column from our data frame
# the square brackets specify the rows



### Pop quiz: what kind of object is datetime right now?



# the first way to change its format is to use as.POSIXct()
# which is in base R (you don't need any packages)

# you might think this will work:
as.POSIXct(datetime)


# Nope! We did, however, get output. The WRONG output.
# It is always a good idea to make sure a command gives you the type of output you expect!



# Pull up the help file so we know how to use this command:
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


## if you hate the labels on the x-axis, you can use axis.POSIXct
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
     type = "--",
     col = "----",
     ---- = "Salinity at Bayou Heron in 2017",
     ---- = "Date/Time",
     ---- = "Salinity (psu)")


### Part 2:
## Read in one of your water quality files,
## or the provided "gndbcwq2017" file,
## and make the same graph, with whatever tweaks you like

---- <- read.csv("data/AQS_zip/-----", stringsAsFactors = FALSE)
----$DateTimeStamp <- ------(----$DateTimeStamp, tz = "America/Regina")

# hint: don't remember which command from lubridate to use? see if
# the top few values of your data will help you figure it out
# by running   head(----$DateTimeStamp)

plot(Sal ~ DateTimeStamp, data = ----,
     type = "--",
     col = "----",
     ---- = "Salinity at Bayou Cumbest in 2017",
     ---- = "Date/Time",
     ---- = "Salinity (psu)")

### Remember to put the blue sticky-note on your laptop when you finish!
### And use the orange if you need help.

