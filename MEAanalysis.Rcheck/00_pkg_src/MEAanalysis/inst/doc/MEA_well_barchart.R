## ----include = FALSE, echo = FALSE--------------------------------------------
knitr::opts_chunk$set(
  collapse = TRUE,
  comment = "#>"
)

## ----setup, include = FALSE---------------------------------------------------
library(MEAanalysis)
knitr::opts_knit$set(root.dir = '..')

## ----warning = FALSE, message = FALSE-----------------------------------------
burst_recording_1 <- create_electrode_dataset(data_path = "data/input_electrode_burst.csv", recording_identifier = "burst_recording_1")

# view first 10 lines of dataset

head(burst_recording_1, 10)

## ----warning = FALSE, message = FALSE-----------------------------------------
burst_recording_2 <- create_electrode_dataset(data_path = "data/comparison_agonist_challenge_electrode_burst_list.csv", recording_identifier = "burst_recording_2")

# view first 10 lines of dataset

head(burst_recording_2, 10)

## -----------------------------------------------------------------------------
output_table <- rbind(burst_recording_1, burst_recording_2)

# view first 10 lines of dataset

head(output_table, 10)

## -----------------------------------------------------------------------------
analysis_dataset <- output_table

analysis_dataset <- well_burst_duration(data = analysis_dataset, 0, 30, recording_identifier = "burst_recording_1")
analysis_dataset <- well_burst_duration(data = analysis_dataset, 30, 60, recording_identifier = "burst_recording_1")
analysis_dataset <- well_burst_duration(data = analysis_dataset, 60, 90, recording_identifier = "burst_recording_1")
analysis_dataset <- well_burst_duration(data = analysis_dataset, 60, 90, recording_identifier = "burst_recording_2")

## ----echo = FALSE-------------------------------------------------------------
# view first 10 lines of analysis dataset

knitr::kable(analysis_dataset[1:10,]) %>% kableExtra::scroll_box(width = "100%")

## ----warning = FALSE, fig.height = 5, fig.width = 7---------------------------
well_barchart(data = analysis_dataset, well_parameter = "burst_duration", well_filter = "A1|A2|A3|A4", statistic = se)

