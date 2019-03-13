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
library(ggplot2)




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


### Challenge ----

# read in the file gndbcwq2017.csv:
bcwq <- ------(------, stringsAsFactors = FALSE)


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

# the SWMPr package takes care of it for us, but if you're not using
# that package, or have this in other data, you need to know these steps
# and the lubridate package helps with more than just POSIXct


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


### now do this for bcwq too:
bcwq$DateTimeStamp <- ------(---$------, tz = "America/Regina")


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


### Brief intro to ggplot2 ----

# gg = "grammar of graphics"
# this package is part of the tidyverse
# and is meant to provide a consistent, coherent framework
# for graphing


# graphs are built in layers, additively using "+"

ggplot() +
        geom_point(data = bhwq, aes(x = DateTimeStamp, y = Sal))


# anything in the top layer gets carried through the plot; 
# this gives us the same graph:
ggplot(data = bhwq, aes(x = DateTimeStamp, y = Sal)) +
        geom_point()


# that can be useful for adding multiple layers for one set of data points:
ggplot(data = bhwq, aes(x = DateTimeStamp, y = Sal)) +
        geom_point() +
        geom_line(col = "blue") +
        geom_smooth(col = "red")  # geom_smooth can be used for many types of smoothing


# I typically leave the top line blank and specify with each layer
# this helps if you want to graph something from multiple stations
ggplot() +
        geom_point(data = bhwq, aes(x = DateTimeStamp, y = Sal), col = "blue") +
        geom_point(data = bcwq, aes(x = DateTimeStamp, y = Sal), col = "red")


## geom_line gives you lines instead of points
## can make points and lines more transparent using "alpha":
ggplot() +
        geom_line(data = bhwq, aes(x = DateTimeStamp, y = Sal), col = "blue") +
        geom_line(data = bcwq, aes(x = DateTimeStamp, y = Sal), col = "red", alpha = 0.5)



## notice there's no legend
# we can specify a characteristic of the data inside aes()
# (we want to use the site name as the difference between color values)
ggplot() +
        geom_line(data = bhwq, aes(x = DateTimeStamp, y = Sal, col = "Bayou Heron")) +
        geom_line(data = bcwq, aes(x = DateTimeStamp, y = Sal, col = "Bayou Cumbest"), alpha = 0.5)




### Challenge ----
# make a ggplot comparing pH at Bayou Heron and Bayou Cumbest
------ +
        -------(---- = bhwq, ---(x = DateTimeStamp, y = pH, col = "Bayou Heron")) +
        -------(---- = bcwq, ---(x = DateTimeStamp, y = pH, col = "Bayou Cumbest"))

########




## use scale_color_manual / scale_fill_manual and friends
# (see "data visualization" cheatsheet)
# to force the colors to be what you want
ggplot() +
        geom_line(data = bhwq, 
                  aes(x = DateTimeStamp, y = Sal, col = "Bayou Heron")) +
        geom_line(data = bcwq, 
                  aes(x = DateTimeStamp, y = Sal, col = "Bayou Cumbest"), 
                  alpha = 0.5) +
        scale_color_manual(values = c("blue", "red"),
                          name = "Station",
                          limits = c("Bayou Heron", "Bayou Cumbest"))



# another nice thing about ggplot2 is that you can save the 
# it as an object, and then add other layers to it:
p <- ggplot() +
        geom_line(data = bhwq, 
                  aes(x = DateTimeStamp, y = Sal, col = "Bayou Heron")) +
        geom_line(data = bcwq, 
                  aes(x = DateTimeStamp, y = Sal, col = "Bayou Cumbest"), 
                  alpha = 0.5)


p



p + scale_color_manual(values = c("blue", "red"),
                       name = "Station",
                       limits = c("Bayou Heron", "Bayou Cumbest"))


# write over "p":
p <- p + scale_color_manual(values = c("blue", "red"),
                            name = "Station",
                            limits = c("Bayou Heron", "Bayou Cumbest"))


p



## add some titles and axis labels:
p <- p + 
        labs(title = "Salinity at Grand Bay",
             subtitle = "in 2017",
             x = "Date",
             y = "Salinity (psu")


## get rid of the ugly gray background
# ggplot2 has lots of themes you can explore
p + theme_bw()

p + theme_minimal()

p + theme_dark()


# you can also make your own theme
## ggThemeAssist is a helpful package that provides
# a point and click interface to build your plot;
# then it returns the code for you

## highlight code for a ggplot
# then up top in the "Addins" pull down menu,
# select "ggplot Theme Assistant"
# and make the desired modifications
p

# when you want to make the same plot, you can use the same code


## save with "ggsave":
ggsave("output/sal2017.png")
