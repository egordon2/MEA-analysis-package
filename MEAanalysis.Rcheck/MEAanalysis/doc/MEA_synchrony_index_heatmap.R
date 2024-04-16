## ----include = FALSE, echo = FALSE--------------------------------------------
knitr::opts_chunk$set(
  collapse = TRUE,
  comment = "#>"
)

## ----setup, include = FALSE---------------------------------------------------
library(MEAanalysis)
knitr::opts_knit$set(root.dir = '..')

## ----warning = FALSE, message = FALSE-----------------------------------------
baseline_data <- create_synchrony_dataset(data_path = system.file("extdata", "input_neuralMetric.csv", package = "MEAanalysis"),
                                          heatmap_condition = "Baseline")

# view first 10 lines of dataset
head(baseline_data, 10)

## ----warning = FALSE, message = FALSE-----------------------------------------
agonist_challenge_data <- create_synchrony_dataset(data_path = system.file("extdata", "comparison_agonist_challenge_neuralMetrics.csv", package = "MEAanalysis"),
                                          heatmap_condition = "Agonist Challenge")

# view first 10 lines of dataset
head(agonist_challenge_data, 10)

## -----------------------------------------------------------------------------
df_list <- list(baseline_data, agonist_challenge_data)
heatmap_data <- df_list %>%
  reduce(full_join, by = 'Well')

# view first 10 lines of dataset
head(heatmap_data, 10)

## ----warning = FALSE, fig.height = 5, fig.width = 7---------------------------
MEA_heatmap(data = heatmap_data, well_filter = "A1|A2|A3|A4|A5|A6|B1|B2|B3|B4|B5|B6|C1|C2|C3|C4|C5|C6|D1|D2|D3|D4|D5|D6")

