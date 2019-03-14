## things that are probably too much
## but I don't want to lose them completely


##############################################################################
# originally after aggreswmp in SWMPr_part2
##############################################################################

### potential application:

## what if we want to subset the met_qc data frame 
## to only that day of max rainfall


## first problem:
# datetimestamp gives us more than just a date

## solution: make a new column, using the as.Date function
met_qc$date <- as.Date(met_qc$datetimestamp)


# now to subset.
# it is very similar, but includes some extra notation because
# we have to get very specific.

# we want the ROWS of met_qc
# where the date column matches
# the datetimestamp identified as max rain in the daily_rain data frame

rainiest_day <- met_qc[met_qc$date == daily_rain$datetimestamp[which.max(daily_rain$totprcp)], ]

## if that's too crazy, you can assign that date to a variable
date_i_want <- daily_rain$datetimestamp[which.max(daily_rain$totprcp)]

rainiest_day <- met_qc[met_qc$date == date_i_want, ]    # much more readable

## we could subset one of our water quality data frames the same way
## (after making a date column, of course)

##############################################################################
##############################################################################


### originally after subsetting in 03_SWMPr_part2:


# if all we really want is the date, and we don't care about the total,
# we can subset this way:
daily_rain[row_index, 1]

# or
daily_rain[row_index, "datetimestamp"]

# or
daily_rain$datetimestamp[row_index]  ## no comma here

# notice these are simplifying from a data frame to a vector of 1
# if we want to keep the data frame structure, 
# we have to include drop = FALSE:
daily_rain[row_index, 1, drop = FALSE]

##############################################################################
##############################################################################
