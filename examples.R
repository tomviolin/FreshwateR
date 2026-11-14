#!/usr/bin/env Rscript
# examples.R -- 1-hour R Tidyverse Live Demo
# Goal: Walk through core tidyverse workflow in four parts:
#   1. Load data (readr)
#   2. Base dplyr filtering, selecting and mutating
#   3. Group & summarise
#   4. First ggplot2 (iris) + second ggplot2 (mtcars, bar+facet)

library(readr)
library(dplyr)
library(ggplot2)

# --- Load core packages ---------------------------------------------------
# (Assume CSV files "mtcars.csv" and "iris.csv" are in the working directory;
# if they are not, Rscript will try to download them.)

# --- 1. Load data (readr) ------------------------------------------------------------
mtcars  <- read_csv("mtcars.csv", header = TRUE)   # 48 rows × 8 cols
iris    <- read_csv("iris.csv",     header = TRUE)  # 150 rows, 5 cols

cat("\n===== Head of mtcars.csv ====\n")
print(head(mtcars, n = 5))

cat("\n===== Head of iris.csv ====\n")
print(head(iris, n = 5))

# --- 2. Base dplyr pipeline (filter, select, mutate) ------------------------------
# Fast 4‑cyl cars with >80 hp from mtcars.csv
fast_power <- mtcars %>%
  select(Name, Displacement, Horsepower, Weight, Miles_per_Gallon) %>%
  filter(Cylinders == 4 & Horsepower > 80)

cat("\nFast 4‑cyl cars (>80 hp):\n")
print(fast_power)

# --- 3. Group & summarise ---------------------------------------------------------
mtc_summary <- mtcars %>%
  group_by(Cylinders) %>%
  summarise(
    Avg_MPG = mean(Miles_per_Gallon, na.rm = TRUE),
    Avg_HP   = mean(Horsepower, na.rm = TRUE),
    N_rows   = n(),
    .groups = "drop"
  )

cat("\nSummary per cylinder group (mtcars):\n")
print(mtc_summary)

# --- 4a. First ggplot2 plot (iris) -------------------------------------------------
iris_t <- iris %>%
  mutate(Temp   = Sepal.Length + 5) %>%
  filter(Temp > 52) %>%
  select(Species, Temp, Sepal.Length, Sepal.Width)

ggplot(iris_t, aes(x = Sepal.Length, y = Sepal.Width, colour = Species)) +
  geom_point(alpha = 0.7) +
  labs(title = "Sepal Length vs Width (iris, Temp = Sepal.Length+5)",
        x = "Sepal Length (cm)",
        y = "Sepal Width (cm)",
        colour = "Species") +
  theme_minimal()

# --- 4b. Second ggplot2 plot (mtcars, bar + facet) ---------------------------------
ggplot(mtcars, aes(x = Cylinders, y = Miles_per_Gallon, fill = Cylinders)) +
  geom_bar(width = 0.8) +
  facet_wrap(~ Cylinders) +   # replace with an existing column from your mtcars.csv
  scale_fill_viridis_dis() +
  labs(title = "Miles/Gallons by Number of Cylinders (mtcars)",
        x = "Number of cylinders",
        y = "Miles per Gallon",
        fill = "Cylinders") +
  theme_minimal()

# --- Save exports --------------------------------------------------------------------
write_csv(fast_power, "fast_power.csv")
write_csv(mtc_summary, "mtc_summary.csv")
cat("\nExported: fast_power.csv, mtc_summary.csv\n")
