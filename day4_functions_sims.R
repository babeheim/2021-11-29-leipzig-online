
# functions in R
my_function <- function(parameters) {
  # performing actions on parameters
  # return value
}

# example: convert between fahrenheit and kelvin 

fahr_to_kelvin <- function(temp) {
  # converts temp in degrees fahrenheit to kelvin
  out <- ((temp - 32) * (5/9)) + 273.15
  return(out)
}

fahr_to_kelvin(100)
fahr_to_kelvin(0)
fahr_to_kelvin(temp = 32)

fahr_to_kelvin(temp = c(0, 32, 100))


kelvin_to_celcius <- function(temp) {
  # converts temp in degrees kelvin to celcius
  out <- temp - 273.15
  return(out)
}

kelvin_to_celcius(310)

temp <- 100

kelvin_to_celcius(temp = 0)

temp

fahr_to_celcius <- function(temp_fahr) {
  temp_kelvin <- fahr_to_kelvin(temp = temp_fahr)
  out <- kelvin_to_celcius(temp = temp_kelvin)
  return(out)
}

fahr_to_celcius(100)


fahr_to_celcius_mark_ii <- function(temp_fahr) {
  # checks that temp_fahr is numeric
  stopifnot(is.numeric(temp_fahr))
  # converts fahrenheit to celcius
  temp_kelvin <- fahr_to_kelvin(temp = temp_fahr)
  out <- kelvin_to_celcius(temp = temp_kelvin)
  return(out)
}


# create some functions for gapminder

# goal 1: we want a function which subsets gapminder to a specific year OR a specific country OR BOTH
# goal 2: create new variable gdp

rm(list = ls())

gapminder <- read.csv("data/gapminder_data.csv")

calcGDP <- function(dat, year = NULL, country = NULL){
  if(!is.null(year)) {
    dat <- dat[dat$year == year,]
    print(paste("year", year, "detected"))
  }
  if(!is.null(country)) {
    dat <- dat[dat$country == country,]
    print(paste("country", country, "detected"))
  }
  dat$gdp <- dat$gdpPercap * dat$pop
  return(dat)
}

# helpful to save functions to a source and load it all at once like so:
# source("functions/my_functions.R")

calcGDP(dat = gapminder, year = 2007)

gapminder_2007 <- calcGDP(dat = gapminder, year = 2007)
gapminder_de <- calcGDP(dat = gapminder, country = "Germany")

gapminder_de_2007 <- calcGDP(dat = gapminder, country = "Germany", year = 2007)

gapminder_de_2007 <- calcGDP(dat = gapminder, country = "Germany", year = 2007)
gapminder_de_2007 <- calcGDP(year = 2007, dat = gapminder, country = "Germany")
gapminder_de_2007 <- calcGDP(gapminder, "Germany", 2007)


# using paste to make messages

paste("a ", " sentence")
paste0("a", "sentence")

fence <- function(text, wrapper) {
  text <- c(wrapper, text, wrapper)
  paste(text, collapse = " ")
}
fence(text = c("this", "is", "a", "test"), wrapper = "*****")



# using R for generative simulation

# sample()
# rnorm()

set.seed(2)
barplot(table(sample(LETTERS, 1000, replace = TRUE)))
abline(h = 1000/26, lty = 2)

draws <- sample(LETTERS, 100000, replace = TRUE)
barplot(table(draws))
abline(h = 100000/26, lty = 2)

# custom probability 'function'
bias_to_z <- (1:26)/sum(1:26)

draws <- sample(LETTERS, 100000, replace = TRUE, prob = bias_to_z)
barplot(table(draws))
abline(h = 100000/26, lty = 2)


# using rnorm to data dredge! and p-hack! and do replications!

hist(rnorm(n = 100000))

mean(rnorm(n = 100000))

mean(rnorm(n = 100000, sd = 100))

# lm()

y <- rnorm(10)
x <- rnorm(10)
m1 <- lm(y ~ x)
summary(m1)

n_obs <- 20000
y <- rnorm(n_obs)
X <- matrix(rnorm(n_obs * 100), nrow = n_obs, ncol = 100)
m2 <- lm(y ~ X)
summary(m2)
big_effects <- which(abs(coef(m2)) >= 0.016) - 1
if (length(big_effects) == 0) print("no big effects found!")
X2 <- X[, big_effects]
m2_phacked <- lm(y ~ X2)
summary(m2_phacked)
X_new <- matrix(rnorm(n_obs * 100), nrow = n_obs, ncol = 100)
X2_new <- X_new[, big_effects]
m2_preregistered <- lm(y ~ X2_new)
summary(m2_preregistered)



# simulating non-null studies

## a null relationship has correlation near 0
x <- rnorm(10000)
y <- rnorm(10000)
cor(x, y) # -1 and 1, where 0 means 'no' correlation
plot(x, y)

## how to create a fixed correlation between two variables?
r <- 0.8
x <- rnorm(10000)
y <- rnorm(10000, mean = r * x, sd = sqrt(1 - r^2))
cor(x, y)
plot(x, y)

correlator <- function(r, n = 1000) {
  stopifnot(r >= (-1) & r <= 1)
  x <- rnorm(n)
  y <- rnorm(n, mean = r * x, sd = sqrt(1 - r^2))
  out <- data.frame(x = x, y = y)
  return(out)
}

df <- correlator(0.5, n = 1000000)
cor(df$x, df$y)
plot(df$x, df$y)
summary(lm(y ~ x, data = df))


correlator_mark_ii <- function(r, x_mean = 0, y_mean = 0, n = 1000) {
  stopifnot(r >= (-1) & r <= 1)
  x <- rnorm(n, mean = x_mean)
  y <- rnorm(n, mean = r * (x - x_mean) + y_mean, sd = sqrt(1 - r^2))
  out <- data.frame(x = x, y = y)
  return(out)
}

df <- correlator_mark_ii(0.5, x_mean = 50, y_mean = (-4), n = 1000)
cor(df$x, df$y)
plot(df$x, df$y)
summary(lm(y ~ x, data = df))

correlator_mark_iii <- function(r, x_mean = 0, x_sd = 1, y_mean = 0, y_sd = 1, n = 1000) {
  stopifnot(r >= (-1) & r <= 1)
  x <- rnorm(n, mean = x_mean, sd = x_sd)
  y <- rnorm(n, mean = (y_sd/x_sd) * r * (x - x_mean) + y_mean, sd = sqrt(1 - r^2) * y_sd)
  out <- data.frame(x = x, y = y)
  return(out)
}

df <- correlator_mark_iii(0.5, x_mean = 0, x_sd = 1, y_mean = 0, y_sd = 10, n = 1000)
cor(df$x, df$y)
plot(df$x, df$y, xlim = c(-3, 3), ylim = c(-3, 3))
abline(lm(y ~ x, data = df))
summary(lm(y ~ x, data = df))



# now create a regression dataset

## weak effects!
x <- rnorm(1000)
y <- rnorm(1000, mean = 0.5 * x, sd = 10)
summary(lm(y ~ x))
cor(x, y)


# final simulation exercise: make an animation! with a loop!


rs <- seq(-1, 1, by = 0.01)

for(i in rs) {
  df <- correlator_mark_iii(i, n = 1000)
  plot(df$x, df$y, xlim = c(-3, 3), ylim = c(-3, 3),
    main = i)
  Sys.sleep(0.1)
}



