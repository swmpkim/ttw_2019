library(SWMPr)
library(lubridate)
library(ggplot2)

# if you need to re-read the data:

# data_path <- "data/AQS_zip"
# bhwq <- import_local(data_path, "gndbhwq", trace = TRUE)
# bhwq_qaqc <- qaqc(bhwq)
# met_data <- import_local(data_path, "gndcrmet", trace = TRUE)
# met_qc <- qaqc(met_data, qaqc_keep = c(0, 1, 4, 5))



### A brief introduction to functions and for loops



### When you copy and paste code a lot, only changing one or two things,
### you probably want to make a function or run a loop


### For loops ----

## Will start with loops because I'm going to go into less depth on them
# the idea is, you have some set of things that you want to iterate over

#  for each _____, do ______

# for example, you want to perform some action for each of your monitoring stations
# the status reports work this way
# so do the QA/QC scripts



# typically we use the letter "i" as the index
# for (i in some_set_of_things) { do something }

stns <- c("gndbhwq", "gndbcwq", "gndblwq", "gndpcwq")

for(i in 1:length(stns)){
        print(stns[i])
}


# another option
for(i in seq_along(stns)){
        print(stns[i])
}


# make sure a loop is working by setting i to something
# and running only the code inside the curly braces, e.g.
i <- 2
print(stns[i])




# there are easier ways to do this, but it's a good example for a loop:
# you want to find out what type of column it is

names(bhwq_qaqc)

for(i in seq_along(names(bhwq_qaqc))){
        col_class <- class(bhwq_qaqc[ , names(bhwq_qaqc[i])])
        print(paste("The column", names(bhwq_qaqc[i]), "is type", col_class))
}




### Challenge

## make a vector of 5 different types of fruit
## make another vector of 5 adjectives to describe the fruit
## write a for loop to print "[fruit type] is [adjective]"








### Writing a function ----


## Example: there's a formula you use a lot
## say, to calculate standard error
## this is the formula, for salinity:
sd(bhwq_qaqc$sal, na.rm = TRUE) / sqrt(length(bhwq_qaqc$sal))


## and you don't want to type it every time you want to calculate it for something


#### how do you generalize it? (if you're copying and pasting, what are you changing every time?)



# bhwq_qaqc$sal

# so we want to assign that to something and feed that into our formula:

x <- bhwq_qaqc$sal
sd(x, na.rm = TRUE) / sqrt(length(x))


## and now, we can make it a function. RStudio helps with this:
## higlight the formula

## then, from the "Code" menu, select "Extract Function"
## when it asks you for a function name, type "sterr"

sd(x, na.rm = TRUE) / sqrt(length(x))

## it will turn it into this:

sterr <- function(x) {
  sd(x, na.rm = TRUE) / sqrt(length(x))
}


# run that code to make the function available to you

# and you can use it:
sterr(bhwq_qaqc$sal)

sterr(bhwq_qaqc$ph)



#### your turn (pick a parameter):






## You can also do write functions for graphs
## it gets a little more complicated to generalize


# say we put a lot of effort into this graph:
ggplot(data = bhwq_qaqc, aes(x = datetimestamp, y = sal)) +
        geom_line(aes(col = "15-min data")) +
        geom_smooth(aes(col = "smoothed"), size = 2) +
        labs(x = "Date",
             y = "sal") +
        scale_color_manual(values = c("gray60", "red3"),
                           labels = c("15-min data", "monthly average")) +
        theme_bw()


# and now we want to make other graphs that look the same
# we could copy and paste. what would we need to change in the code?









# data frame
# parameter





# let's start with generalizing the parameter:

# define our parameter
param <- "sal"

# make a subset of the data for graphing purposes
# remember this square bracketing thing?

graph_dat <- ------[ c("datetimestamp", param) ]   # fill in the dashes
## where does the comma go?
## (do we really need it?)



# give the defined parameter column the name "param"
names(graph_dat) <- c("datetimestamp", "param")



# now make the plot, using "param" in place of "sal"
# do you need quotation marks around it here?
ggplot(data = graph_dat, aes(x = datetimestamp, y = -----)) +
        geom_line(aes(col = "15-min data")) +
        geom_smooth(aes(col = "smoothed"), size = 2) +
        labs(x = "Date",
             y = ------) +
        scale_color_manual(values = c("gray60", "red3"),
                           labels = c("15-min data", "monthly average")) +
        theme_bw()




## okay, now see if we can generalize the data frame

# one easy way is to make a duplicate of our original data frame, and name it dat
dat <- bhwq_qaqc

# subset and rename
graph_dat <- dat[c("datetimestamp", param)]
names(graph_dat) <- c("datetimestamp", "param")


## where do you change it below to make the graph?
ggplot(data = -----, aes(x = datetimestamp, y = param)) +
        geom_line(aes(col = "15-min data")) +
        geom_smooth(aes(col = "smoothed"), size = 2) +
        labs(x = "Date",
             y = param) +
        scale_color_manual(values = c("gray60", "red3"),
                           labels = c("15-min data", "monthly average")) +
        theme_bw()




## so in a function, we need to be able to specify the data frame
## and the parameter of interest
## and it looks like this:

plot_smoothed <- function(data, param){
        dat <- data
        graph_dat <- dat[ , c("datetimestamp", param)]
        names(graph_dat) <- c("datetimestamp", "param")
        ggplot(data = graph_dat, aes(x = datetimestamp, y = param)) +
                geom_line(aes(col = "15-min data")) +
                geom_smooth(aes(col = "smoothed"), size = 2) +
                labs(x = "Date",
                     y = param) +
                scale_color_manual(values = c("gray60", "red3"),
                                   labels = c("15-min data", "monthly average")) +
                theme_bw()
}

plot_smoothed(bhwq_qaqc, "sal")
plot_smoothed(bhwq_qaqc, "temp")
plot_smoothed(met_qc, "atemp")




#### Challenge

## Change the function so that you can specify a title.
## name the function argument "my_title"

plot_smoothed <- function(data, param, -----){
        dat <- data
        graph_dat <- dat[ , c("datetimestamp", param)]
        names(graph_dat) <- c("datetimestamp", "param")
        ggplot(data = graph_dat, aes(x = datetimestamp, y = param)) +
                geom_line(aes(col = "15-min data")) +
                geom_smooth(aes(col = "smoothed"), size = 2) +
                labs(title = ------,
                     x = "Date",
                     y = param) +
                scale_color_manual(values = c("gray60", "red3"),
                                   labels = c("15-min data", "monthly average")) +
                theme_bw()
}

## run your new function on at least one WQ and one MET parameter




