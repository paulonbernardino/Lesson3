######WUR Geo-scripting course
###Lesson3

library(raster)

#Reproducible Example
r<- s <- raster(ncol=50, nrow=50)
## Fill the raster with values
r[] <- 1:ncell(r)
r
s[] <- 2 * (1:ncell(s))
s[200:400] <- 150
s[50:150] <- 151
s
## Perform the replacement
r[s %in% c(150, 151)] <- NA
## Visualise the result
plot(r)

#Age Calculator
source('R/age_calculator.R')
ageCalculator(1990)


#The try() function
library(raster)

## Create a raster layer and fill it with "randomly" generated integer values
a <- raster(nrow=50, ncol=50)
a[] <- floor(rnorm(n=ncell(a)))

# The freq() function returns the frequency of a certain value in a RasterLayer
# We want to know how many times the value -2 is present in the RasterLayer
freq(a, value=-2)
plot(a)

# Let's imagine that you want to run this function over a whole list of RasterLayer
# but some elements of the list are impredictibly corrupted
# so the list looks as follows
b <- a
c <- NA
list <- c(a,b,c)
# In that case, b and a are raster layers, c is ''corrupted''

## Running freq(c) would return an error and stop the whole process
out <- list()
for(i in 1:length(list)) {
  out[i] <- freq(list[[i]], value=-2)
}

# Therefore by building a function that includes a try()
# we are able to catch the error,
# allowing the process to continue despite missing/corrupted data.
fun <- function(x, value) {
  tr <- try(freq(x=x, value=value), silent=TRUE)
  if (class(tr) == 'try-error') {
    return('This object returned an error')
  } else {
    return(tr)
  }
}

# Let's try to run the loop again
out <- list()
for(i in 1:length(list)) {
  out[i] <- fun(list[[i]], value=-2)
}
out

# Note that using a function of the apply family would be a more
# elegant/shorter way to obtain the same result
(out <- sapply(X=list, FUN=fun, value=-2))

##Function Debugging
foo <- function(x) {
  x <- x + 2
  print(x)
  bar(2) 
}

bar <- function(x) { 
  x <- x + a.variable.which.does.not.exist 
  print(x)
}

foo(2) 
## gives an error

traceback()
## 2: bar(2) at #1
## 1: foo(2)
# Ah, bar() is the problem

## redefine bar
bar <- function(x) {
x + 5
}
foo(2)
## [1] 4
## [1] 7