################ Introduction to R ###############

# Testing some calculations
1 + 1
2 + 4
2 * 3


1 + 100
100 - 1 
2 * 2 
10 / 2
2^2

(2 + 2) * 2
5e3

log(1)
log10(10)
sin(2)
exp(0.5) # = e^(1/2)
exp(1)^(1/2)

###### Comparing Things

1 == 1
1 == 2

1 != 1
1 != 2

1 < 2
2 > 1

1 >= -9

##### Variables and assignments
x <- 1/40
x
log(x)
x <- 12
x

x <- log(x) + 1 
x

mean_boys <- 30
meanBoys <- 30


# Which of the following are valid R variable names?

# does not work
_age <- 1
min-length <- 1
2widths <- 1

# hidden variable
.mass <- 1

# Valid variable names
MaxLength <- 1
celsius2kelvin <- 1
min_height <- 1
max.height <- 1


x = 2
y <- 2

y <- 2
y<-2

####### Vectorization
1:5
x <- 1:5
x

2^x
2^(1:5)

### Managing Environment
ls()

rm(y)
rm(x)
x

rm(list=ls())

###### R Packages
install.packages("ggplot2")

library(ggplot2)


###
# What will be the value of each variable after each statement in the following program?
mass <- 47.5
age <- 122
mass <- mass * 2.3
age <- age - 20

# Compare Mass and Age --> Check for inequality
mass != age


# Remove Objects mass and age from the environment
rm(age)
rm(mass)
# rm(mass, age) or use this

# Install "tidyr" and "dplyr", "gapminder"
install.packages("dplyr")
install.packages(c("tidyr", "gapminder"))


# Access packages 
library(dplyr)
library(ggplot2)
library(tidyr)


############## Seeking Help
?mean
help(mean)

######### Download
getwd()

download.file("https://raw.githubusercontent.com/swcarpentry/r-novice-gapminder/gh-pages/_episodes_rmd/data/gapminder_data.csv", destfile = "data/gapminder_data.csv")


################ Data Structures

cats <- data.frame(coat = c("calico", "black", "tabby"),
                   weight = c(2.1, 5.0, 3.2),
                   likes_string = c(1, 0, 1))
write.csv(cats, file = "data/feline-data.csv", row.names = FALSE)

rm(cats)

cats <- read.csv(file = "data/feline-data.csv")

cats$weight
cats$coat

cats$weight + 2
cats$weight * 2

paste("My cat is", cats$coat)


cats$weight + cats$coat


##### Data Types

typeof(cats$weight)
typeof(cats$coat)
cats$coat

typeof("banana")
typeof(TRUE)

typeof(1)
typeof(1L)

class(cats)
typeof(cats)


##### Vectors 
my_vector <- vector(length = 3)
my_vector

my_vector <- c(1, 2, 3)
my_vector + 2

my_characters <- c("cat1", "cat2", "cat3")
my_characters

coercion_vector <- c("a", TRUE, 123, pi)
coercion_vector

mode(coercion_vector)
coercion_vector + 2

coercion_vector_2 <- c(0, TRUE)
coercion_vector_2
mode(coercion_vector_2)

# TRUE = 1, FALSE = 0 
# logicals -> integer -> numeric -> complex -> character

my_vector <- c("1", "2", "3")
mode(my_vector) 

my_vector_numbers <- as.numeric(my_vector)
mode(my_vector_numbers)

as.character(my_vector_numbers )


boolean <- c(TRUE, FALSE, TRUE)
mode(boolean)
boolean

boolean_numbers <- as.numeric(boolean)
as.logical(boolean_numbers)

as.logical(c(1, 4, 50, 0, -1))


cats$likes_string <- as.logical(cats$likes_string)

x <- c("a" , "b")
x
y <- c("z", "y")
y

new_vector <- c(x, y)
new_vector

new_vector_1 <- c(new_vector, "t")
new_vector_1

x <- 1:5
x
x <- c(1, 2, 3, 4, 5)
x

seq(10)
x <- seq(1, 10, by = 0.1)
head(x, 10)
tail(x, 5)
length(x)
typeof(x)
class(x)
mode(x)

is.vector(x)

my_example <- 5:8
length(my_example)
names(my_example) <- c("a", "b", "c", "d")
my_example

my_example <- 1:26
names(my_example) <- letters
letters
LETTERS

