
library(dplyr)
library(tidyr)

# entry by columns
cats <- data.frame(
  coat = c("calico", "black", "tabby"),
  weight = c(2.1, 5.0, 3.2),
  likes_string = c(1, 0, 1)
)

# entry by rows (using a list of lists)
cats2 <- list(
  list(
    coat = "black",
    weight = 5.0,
    likes_string = 0
  ),
  list(
    coat = "calico",
    weight = 2.1,
    likes_string = 1
  ),
  list(
    name = "Garfield",
    coat = "tabby",
    weight = 3.2,
    likes_string = 1
  )
)



# normal dataframe
# wide dataframe
# long dataframe

# one-row-per-country/year
d_normal <- data.frame(
  country = c("China", "China", "USA", "USA"),
  year = c(1997, 1998, 1997, 1998),
  pop = c(1000, 1200, 300, 310),
  gdpPercap = c(40, 45, 65, 70)
)

# one-row-per-country
d_wide <- data.frame(
  country = c("China", "USA"),
  pop_1997 = c(1000, 300),
  pop_1998 = c(1200, 310),
  gdpPercap_1997 = c(40, 65),
  gdpPercap_1998 = c(45, 70)
)

# one-row-per-element-attribute-value
d_long <- data.frame(
  country = c("China", "China", "China", "China", "USA", "USA", "USA", "USA"),
  year = c(1997, 1997, 1998, 1998, 1997, 1997, 1998, 1998),
  attribute = c("pop", "gdpPercap", "pop", "gdpPercap", "pop", "gdpPercap", "pop", "gdpPercap"),
  value = c(1000, 40, 1200, 45, 300, 65, 310, 70)
)

# tidyr idea: pivot to long-form to convert between normal and wide!

# normal to long

d_normal %>%
  pivot_longer(
    cols = c("pop", "gdpPercap"),
    names_to = "attribute", values_to = "value"
  )

# long to normal

d_long %>%
  pivot_wider(
    names_from = attribute,
    values_from = value
  )

# wide to long

d_wide %>%
  pivot_longer(
    cols = c(
      starts_with("pop"),
      starts_with("gdpPercap")
    ),
    names_to = "attribute_year",
    values_to = "value"
  ) %>%
  separate(attribute_year, into = c("attribute", "year"), sep = "_")

# long to wide

d_long %>%
  unite(column_names, attribute, year, sep = "_") %>%
  pivot_wider(
    names_from = column_names,
    values_from = value
  )
