library(tidyverse)
library(gapminder)
dev.off()
dev.RStudioGD()
  gapminder %>% ggplot() + aes(x = gdpPercap, y = lifeExp, size = pop/pop, color = continent) +
    geom_point(alpha = 0.7) +
    scale_x_log10(limits = c(250, 120000)) +
    scale_y_continuous(limits = c(20, 90)) +
    scale_size_area(max_size = 20, guide = "none") +
    labs(
      title = paste("PerCapita GDP"),
      x = "GDP per capita (log scale)",
      y = "Life Expectancy (years)",
      color = "Continent"
    )
  
