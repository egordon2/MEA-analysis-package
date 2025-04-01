## ----include = FALSE, echo = FALSE--------------------------------------------
knitr::opts_chunk$set(
  collapse = TRUE,
  comment = "#>"
)

## ----setup, include = FALSE---------------------------------------------------
library(MEAanalysis)
knitr::opts_knit$set(root.dir = '..')

## ----warning = FALSE, message = FALSE-----------------------------------------
help(package = "MEAanalysis")

## ----warning = FALSE, message = FALSE-----------------------------------------
burst_recording_1 <- create_electrode_dataset(
  data_path = system.file("extdata", "input_electrode_burst.csv", package = "MEAanalysis"), 
  recording_identifier = "burst_recording_1")

# view first 10 lines of dataset

head(burst_recording_1, 10)

## ----warning = FALSE, message = FALSE-----------------------------------------
burst_recording_2 <- create_electrode_dataset(
  data_path = system.file("extdata", "comparison_agonist_challenge_electrode_burst_list.csv", package = "MEAanalysis"), 
  recording_identifier = "burst_recording_2")

# view first 10 lines of dataset

head(burst_recording_2, 10)

## -----------------------------------------------------------------------------
output_table <- rbind(burst_recording_1, burst_recording_2)

# view first 10 lines of dataset

head(output_table, 10)

## -----------------------------------------------------------------------------
# assign the 'output_table' data table object created above to a different object name 'analysis_dataset'
# this means that when columns are added to the 'analysis_dataset' the data table can be refreshed by rerunning this line of code
analysis_dataset <- output_table

# add burst duration calculated columns for defined time intervals to the 'analysis_dataset' 
analysis_dataset <- electrode_burst_duration(data = analysis_dataset, 0, 60, recording_identifier = "burst_recording_1")
analysis_dataset <- electrode_burst_duration(data = analysis_dataset, 0, 60, recording_identifier = "burst_recording_2")
analysis_dataset <- electrode_burst_duration(data = analysis_dataset, 60, 120, recording_identifier = "burst_recording_1")
analysis_dataset <- electrode_burst_duration(data = analysis_dataset, 60, 120, recording_identifier = "burst_recording_2")

## ----echo = FALSE-------------------------------------------------------------
# view first 10 lines of analysis dataset

knitr::kable(analysis_dataset[1:10,]) %>% kableExtra::scroll_box(width = "100%")

## ----warning = FALSE, fig.height = 5, fig.width = 7---------------------------
p <- single_electrode_barchart(data = analysis_dataset, 
                               electrode_parameter = "burst_duration", 
                               electrode_filter = "A1_1|A1_2", 
                               statistic = se)
print(p)


## ----warning = FALSE, fig.height = 5, fig.width = 7---------------------------
p <- p + 
  scale_fill_grey() +
  ggtitle("A barchart to show the average burst duration detected by 
          single electrodes within a given time period")

print(p)


