######### Exploring Data Frames #############

cats <- data.frame(coat = c("calico", "black", "tabby"),
                   weight = c(2.1, 5.0, 3.2),
                   likes_string = c(1, 0, 1))
write.csv(x = cats, file = "data/feline-data.csv", row.names = FALSE)

cats <- read.csv("data/feline-data.csv")


age <- c(1, 4, 2)

cats <- cbind(cats, age)

ncol(cats)
nrow(cats)

mean(cats$age)
mean(age)

birth <- c(2000, 2019, NA)

birth

cats <- cbind(cats, birth)

str(cats)

cats$likes_string <- as.logical(cats$likes_string)
cats$age <- as.character(cats$age)

str(cats)

new_obs <- list("tortoiseshell", 3.3, FALSE, "4", "2021")

cats <- rbind(cats, new_obs)

cats$coat <- as.character(cats$coat)

cats[4, 1] <- "tortoiseshell"


is.na(cats$birth)
any(is.na(cats$birth))


cats$birth[3] <- 2010
cats[3, 5] <- 2010


cats$birth <- NULL


cats[3, ]

cats[1, ]

cats <- cats[-c(3, 4), ]




x <- c(5.4, 6.2, 7.1, 4.8, 7.5)
names(x) <- c('a', 'b', 'c', 'd', 'e')
print(x)
# Come up with at least 2 different commands that will produce the following output:



# b   c   d 
# 6.2 7.1 4.8

x[c("b", "c", "d")]
x[c(2:4)]
x[c(2, 3, 4)]
x[2:4]
x[-c(1,5)]
x[c(FALSE, TRUE, TRUE, TRUE, FALSE)]


######## Data Frame Manipulation with dplyr
install.packages("dplyr")
install.packages("ggplot2")

library(dplyr)

df <- read.csv("data/gapminder_data.csv")

str(df)

any(is.na(df$year))

mean(df[df$continent == "Africa", "gdpPercap"])

any(is.na(df$gdpPercap))

df %>% filter(continent == "Africa") %>% summarise(mean_gdpPercap = mean(gdpPercap))

mean(df$gdpPercap)


year_country_gdp <- df %>% select(year, country, gdpPercap)

everything_but_gdpPercap <- df %>% select(-gdpPercap)
str(everything_but_gdpPercap)

year_country_gdp_EU <- df %>% filter(continent == "Europe") %>% select(year, country, gdpPercap)


gdp_by_continents <- df %>% group_by(continent) %>% summarize(mean_gdp_continent = mean(gdpPercap))
gdp_by_continents

gdp_by_country <- df %>% group_by(country) %>% summarize(mean_gdp_country = mean(gdpPercap))
gdp_by_country 

#####  How to get standard deviation by continents of gdp 
sd(df$gdpPercap)

sd_gdp_by_continents <- df %>% group_by(continent) %>% summarize(mean_gdp_country = mean(gdpPercap), 
                                                                 sd_gdp_country = sd(gdpPercap))

sd_gdp_by_continents <- df %>% group_by(continent) %>% summarize(sd_gdp_country = sd(gdpPercap))



