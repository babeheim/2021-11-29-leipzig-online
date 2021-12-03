
#### Intro ####

# change my error language to english
Sys.setenv(LANG = "en")

### loading the gapminder data

gapminder <- read.csv("data/gapminder_data.csv")

# you can also plot in base R
# its easy for simple plots
# its faster if you are generating many plots automatically
# kinda clunky syntax and is harder to make look nice

plot(gapminder$year, gapminder$lifeExp)

# loading ggplot

library("ggplot2")

### the ggplot layer system - data, coordinates, geoms

ggplot(data = gapminder, mapping = aes(x = gdpPercap, y = lifeExp)) +
  geom_point()
# call first the ggplot function
# you tell ggplot what data you are working with
# mapping --> uses the aes() function = 'aesthetics'
# this here includes the variables for the coordinates
# you don't have to use correct R subsetting here, as ggplot already knows
# to look in 'data' --> only use column names

### the base layer of coordinates and data

ggplot(data = gapminder, mapping = aes(x = gdpPercap, y = lifeExp))

# this draws up a grid of our coordinates, but does not plot data
# because we have no geoms, which are responsible for data plotting

# so we re-add the points

ggplot(data = gapminder, mapping = aes(x = gdpPercap, y = lifeExp)) +
  geom_point()

#### Challenge 1 ####

# modify the example to show changes in life expectancy over time

ggplot(data = gapminder, mapping = aes(x = gdpPercap, y = lifeExp)) + 
  geom_point()

# hint: there is a column called year

# one solution:

ggplot(data = gapminder, mapping = aes(x = year, y = lifeExp)) + 
  geom_point()

#### Challenge 2 ####

# we used aes() so far for coordinates
# we can also use the aesthetic 'color'
# Q: modify the code to color by continent
# do you see additional trends?


# Solution:

ggplot(data = gapminder, mapping = aes(x = year, y = lifeExp, color = continent)) + 
  geom_point()


# trends: continents with stronger economy, the life exp is higher

# scatter plot here is a bit ugly, so lets make a line plot instead

ggplot(data = gapminder, mapping = aes(x = year, y = lifeExp, 
                                       by = country,
                                       color = continent)) + 
  geom_line()+
  geom_point()

# note that you need the 'by' aesthetic to tell what points should be
# connected by lines

# note that layers are drawn on top of each other
# so points are drawn on top of lines

ggplot(data = gapminder, mapping = aes(x = year, y = lifeExp, 
                                       by = country)) + 
  geom_line(aes(color = continent))+ # add the color aes to line only
  geom_point()


#### inheriting aes() ####

# note that aes() and other arguments in ggplot are inherited for the
# underlying layers unless overwritten
# so here I moved the color aes to the geom_line only, so that 
# geom_point doesn't inherit the color and just turns black

# also note that you don't have to write out mapping and data everytime
# ggplot will reckognize also this


ggplot(gapminder, aes(x = year, y = lifeExp, by = country)) + 
  geom_line(aes(color = continent))+ # add the color aes to line only
  geom_point()

# so now we can clearly see that the points are drawn on top of the lines

#### aes values instead of mapping ####

# this doesnt work:

ggplot(gapminder, aes(x = year, y = lifeExp, by = country)) + 
  geom_line(aes(color = "blue"))+ 
  geom_point()

# because aes expects some kind of groups to map colors to
# if you are setting just one value you move this outside the aes function

ggplot(gapminder, aes(x = year, y = lifeExp, by = country)) + 
  geom_line(color = "blue")+ # add the color aes to line only
  geom_point()

#### Challenge 3 ####

#Q: what happens if you switch the order of the points and lines?
#A: the lines get plotted on top

ggplot(gapminder, aes(x = year, y = lifeExp, by = country)) + 
  geom_point() +
  geom_line(color = "blue")
  

## TIP
# the last line can't have a + at the end, otherwise ggplot will 
# add whatever you run next to its plot
# this can be really annoying of youre wanting to change the order of things

# you can use:
ggplot(gapminder, aes(x = year, y = lifeExp, by = country)) + 
  geom_line(color = "blue")+ # add the color aes to line only
  geom_point()+
  NULL
# to always have a fixed endpoint and shuffle your lines around
# without adding and removing plusses all the time


#### transformations and stats ####

# ggplot can also add visualizations for statistics, or let you
# directly transform data to be plotted a certain way

# lets go back to our first example

ggplot(data = gapminder, mapping = aes(x = gdpPercap, y = lifeExp)) +
  geom_point()
# some outliers in gdp are making things hard to see
# lets use a different scale and unit of x axis

ggplot(data = gapminder, mapping = aes(x = gdpPercap, y = lifeExp)) +
  geom_point() + 
  scale_x_log10()

# we can also use transparency to avoid overplotting points

ggplot(data = gapminder, mapping = aes(x = gdpPercap, y = lifeExp)) +
  geom_point(alpha = 0.5) + 
  scale_x_log10()

# remember that by setting alpha outside aes we hard code a single value
# we can also map alpha to a variable

ggplot(data = gapminder, mapping = aes(x = gdpPercap, y = lifeExp)) +
  geom_point(aes(alpha = continent)) + 
  scale_x_log10()

#### fit a linear model and plot it ####

ggplot(data = gapminder, mapping = aes(x = gdpPercap, y = lifeExp)) +
  geom_point() + 
  scale_x_log10() + 
  geom_smooth(method = "lm")# method 'linear model'


# we can also change the visual of the linear model

ggplot(data = gapminder, mapping = aes(x = gdpPercap, y = lifeExp)) +
  geom_point() + 
  scale_x_log10() + 
  geom_smooth(method = "lm", size = 1.5)# size controls line thickness of lm

#### Challenge 4 ####

#Q: modify the geom_point color and size to a specific value

#A:

ggplot(data = gapminder, mapping = aes(x = gdpPercap, y = lifeExp)) +
  geom_point(size = 3, color = "orange") + 
  scale_x_log10() + 
  geom_smooth(method = "lm", size = 1.5)


# Q: now use the color of points to represent different continents
# and use a different shape

ggplot(data = gapminder, mapping = aes(x = gdpPercap, y = lifeExp, 
                                       color = continent)) +
  geom_point(size = 3, shape = 17) + # use pch numbers for shapes
  scale_x_log10() + 
  geom_smooth(method = "lm", size = 1.5)

# note that introducing mapping groups will automatically
# make geom_smooth inherit these groups and make multiple trendlines

# what would you to to avoid this???

#A: put color into points, not ggplot call

ggplot(data = gapminder, mapping = aes(x = gdpPercap, y = lifeExp)) +
  geom_point(size = 3, shape = 17, aes(color = continent)) + 
  scale_x_log10() + 
  geom_smooth(method = "lm", size = 1.5)

#### multiple panels ####

# if your plot is very crowded with different aspects, you can make panels
# f ex we can make panels for different countries

# lets make a subset of countries in the americas
americas <- gapminder[gapminder$continent == "Americas",]


ggplot(data = americas, mapping = aes(x = year, y = lifeExp)) +
  geom_line() +
  facet_wrap( ~ country) # make facets ( = panels)
# the facet wrap takes a 'formula' argument denoted by the tilde sign
# we tell the facet what the group is that should be used for the panels

# our text in x now massively overlaps
# we can use the theme() function to change some plot layout options

ggplot(data = americas, mapping = aes(x = year, y = lifeExp)) +
  geom_line() +
  facet_wrap( ~ country) +
  theme_classic()

# in the theme all arguments take these element options
# this is used to tell the theme that this is a text option
# so element_text, element_line etc
# or element_blank() for removing an element
# the help page for theme wil  list all the options that can be modified

# themes

# the default theme is really ugly!
# you can use some preset other themes to modify the plot appearance

ggplot(data = americas, mapping = aes(x = year, y = lifeExp)) +
  geom_line() +
  facet_wrap( ~ country) +
  theme_classic()+
  theme(axis.text.x = element_text(angle = 45))
# or
ggplot(data = americas, mapping = aes(x = year, y = lifeExp)) +
  geom_line() +
  facet_wrap( ~ country) +
  theme_bw()+
  theme(axis.text.x = element_text(angle = 45))

# setting a theme for all plots --> use theme_set to set and theme_get to query

mytheme <- theme_bw()+
  theme(axis.text.x = element_text(angle = 45))

theme_set(mytheme)


#### changing text ####

# lets clean up the axis titles etc
# we can further format the x axis labels in the theme options

ggplot(data = americas, mapping = aes(x = year, y = lifeExp)) +
  geom_line() +
  facet_wrap( ~ country) +
  theme_bw()+
  theme(axis.text.x = element_text(angle = 90, hjust = 1))
# hjust controls the text alignment ie left alignes, right aligned, centered

# changing titles using the labs function

ggplot(data = americas, mapping = aes(x = year, y = lifeExp)) +
  geom_line() + 
  facet_wrap( ~ country) +
  labs(
    x = "Year",              # x axis title
    y = "Life expectancy",   # y axis title
    title = "Figure 1",      # main title of figure
    color = "Continent"      # title of legend
  ) +
  theme_bw()+
  theme(axis.text.x = element_text(angle = 90, hjust = 1))

# changing axis limits

ggplot(data = americas, mapping = aes(x = year, y = lifeExp)) +
  geom_line() + 
  facet_wrap( ~ country) +
  labs(
    x = "Year",              # x axis title
    y = "Life expectancy",   # y axis title
    title = "Figure 1",      # main title of figure
    color = "Continent"      # title of legend
  ) +
  xlim(1950,1980)+
  theme_bw()+
  theme(axis.text.x = element_text(angle = 90, hjust = 1))

#### exporting a plot ####

# you can manually export a plot using the RStudio feature
# but this is annoying if you are re-saving etc

# --> use ggsave function

# you can see that ggsave takes a 'plot' argument
# the default is last_plot(), the plot that is currently open
# but to avoid errors we should write our plot into an object
# and save that

lifeExp_plot <- ggplot(data = americas, mapping = aes(x = year, y = lifeExp)) +
  geom_line() + 
  facet_wrap( ~ country) +
  labs(
    x = "Year",              # x axis title
    y = "Life expectancy",   # y axis title
    title = "Figure 1",      # main title of figure
    color = "Continent"      # title of legend
  ) +
  theme_bw()+
  theme(axis.text.x = element_text(angle = 90, hjust = 1))

ggsave(filename = "lifeExp.png", plot = lifeExp_plot, width = 12, 
       height = 10, dpi = 300, units = "cm")

# ggsave will use the file extension to determine the file type
# but you can use the device argument to hard code

#### Challenge - boxplot ####

#Q: make a boxplot of life expectancy between continents during
# available years


ggplot(data = gapminder, mapping = aes(x = continent, y = lifeExp, 
                                       fill = continent)) +
  geom_boxplot() + 
  facet_wrap(~ year) +
  ylab("Life Expectancy") +
  theme_bw()+
  theme(axis.title.x=element_blank(),
        axis.text.x = element_blank(),
        axis.ticks.x = element_blank())

#### optional ####
# alternative is often a violin plot

ggplot(data = gapminder, mapping = aes(x = continent, y = lifeExp, 
                                       fill = continent)) +
  geom_violin(color = NA, alpha = 0.5) + 
  geom_point(shape = 21, position = position_jitter(width = 0.2), alpha = 0.5)+
  #facet_wrap(~ year) +
  ylab("Life Expectancy") +
  theme_bw()+
  theme(axis.title.x=element_blank(),
        axis.text.x = element_blank(),
        axis.ticks.x = element_blank())

# we now used an additional mapping option: the fill
# color in boxplots actually controls the line color
# we can use ylab or xlab to seperately set axis titles
# we removed here the x axis labels, as they are the same as the colors
# in the legend


#### optional - packages ####

library("patchwork") 
# really simple package for putting multiple plots in one figure

lifeExp_plot/lifeExp_plot # on top of each other

lifeExp_plot + lifeExp_plot # next to each other


library("cowplot")

plot_grid(lifeExp_plot, lifeExp_plot, align = "v")






