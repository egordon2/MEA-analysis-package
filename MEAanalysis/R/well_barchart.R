
#' Well Bar chart
#'
#' @description Function creates a bar chart of calculated MEA parameters by well for a given time interval and recording.
#'
#' @param data Dataset containing electrode burst data and calculated MEA parameter.
#'  Use create_electrode_dataset and well parameter functions to preprocess data before use in this function (i.e., well_burst_duration, well_mean_burst_ISI, well_number_of_bursts, well_spikes_per_burst).
#' @param well_parameter Include "number_of_bursts"/ "burst_duration"/ "spikes_per_burst"/ "mean_burst_ISI" to determine the parameter visualised in the barchart.
#' @param well_filter Argument can be used to filter for specific MEA wells to include in the barchart.
#' @param statistic Include "se" or "sd" to determine whether bar chart error bars represent the standard error or standard deviation of the mean.
#'
#' @return A bar chart of calculated MEA parameters by single electrode for a given time interval and recording.
#' @importFrom data.table melt
#' @importFrom dplyr contains distinct filter group_by mutate select slice
#' @importFrom ggplot2 geom_bar geom_errorbar geom_point ggplot labs aes position_dodge position_jitterdodge scale_fill_grey
#' @importFrom stringr str_detect
#' @importFrom tidyr pivot_wider unnest
#'
#'
#' @export
#'
#' @examples
#' p <- well_barchart(data = input_well_barchart,
#'               well_parameter = "burst_duration",
#'               well_filter = "A1|A2|A3|A4",
#'               statistic = se)
#'
#' p <- well_barchart(data = input_well_barchart,
#'               well_parameter = "spikes_per_burst",
#'               well_filter = "A1|A2|A3|A4",
#'               statistic = se)
#'
#' p <- well_barchart(data = input_well_barchart,
#'               well_parameter = "mean_burst_ISI",
#'               well_filter = "A1|A2|A3|A4",
#'               statistic = se)
#'
#' p <- well_barchart(data = input_well_barchart,
#'               well_parameter = "number_of_bursts",
#'               well_filter = "A1|A2|A3|A4",
#'               statistic = se)

well_barchart <- function(data = output_table, well_parameter,
                                      well_filter = "A1|A2|A3|A4|A5|A6|B1|B2|B3|B4|B5|B6|C1|C2|C3|C4|C5|C6|D1|D2|D3|D4|D5|D6",
                                      statistic = se) {

  # Declare variables
  analysis_dataset <- NULL
  analysis_dataset_2 <- NULL
  analysis_dataset_3 <- NULL
  analysis_dataset_4 <- NULL
  analysis_dataset_5 <- NULL
  raw_values <- NULL
  calculated_statistics <- NULL

  #filter data for plotting
  analysis_dataset <- data %>%
    select(-c(Time_s, Duration_s, Size_spikes, Recording_identifier)) %>%
    distinct() %>%
    filter(., str_detect(well, well_filter))

  #assign y axis title dependent on chosen well parameter
  #(include "number_of_bursts"/ "burst_duration"/ "spikes_per_burst"/ "mean_burst_ISI")

  if (well_parameter == "number_of_bursts") {
    y_axis_title <- "Average Number of Bursts in Well per Electrode"
    analysis_dataset_2 <- select(analysis_dataset, "well"|contains("well_burst_count_raw")|contains("well_burst_count_mean")|contains("well_burst_count_sd")|contains("well_burst_count_se"))
    colnames(analysis_dataset_2) = gsub("well_burst_count_", "", colnames(analysis_dataset_2))

  } else if (well_parameter == "burst_duration") {
    y_axis_title <- "Burst Duration - Well Average (sec)"
    analysis_dataset_2 <- select(analysis_dataset, "well"|contains("well_duration_raw")|contains("well_duration_mean")|contains("well_duration_sd")|contains("well_duration_se"))
    colnames(analysis_dataset_2) = gsub("well_duration_", "", colnames(analysis_dataset_2))

  } else if (well_parameter == "spikes_per_burst") {
    y_axis_title <- "Number of Spikes per Burst - Well Average"
    analysis_dataset_2 <- select(analysis_dataset, "well"|contains("well_spikes_raw")|contains("well_spikes_mean")|contains("well_spikes_sd")|contains("well_spikes_se"))
    colnames(analysis_dataset_2) = gsub("well_spikes_", "", colnames(analysis_dataset_2))

  } else if (well_parameter == "mean_burst_ISI") {
    y_axis_title <- "Mean ISI within Burst - Well Average (sec)"
    analysis_dataset_2 <- select(analysis_dataset, "well"|contains("well_raw_mean_burst_ISI")|contains("well_avg_mean_burst_ISI")|contains("well_sd_mean_burst_ISI")|contains("well_se_mean_burst_ISI"))
    colnames(analysis_dataset_2) = gsub("_mean_burst_ISI", "", colnames(analysis_dataset_2))
    colnames(analysis_dataset_2) = gsub("well_", "", colnames(analysis_dataset_2))
    colnames(analysis_dataset_2) = gsub("avg", "mean", colnames(analysis_dataset_2))


  }  else {

  }

  #reformat data for plotting
  analysis_dataset_3 <- melt(analysis_dataset_2, id = "well")
  analysis_dataset_3$recording_time = gsub(pattern = ".*:", replacement = "", x = analysis_dataset_3$variable)
  analysis_dataset_3$parameter = gsub(pattern = "\\:.*", replacement = "", x = analysis_dataset_3$variable)
  analysis_dataset_3 <- analysis_dataset_3 %>%
    select(-c(variable))

  # create data frame of raw values
  raw_values <- analysis_dataset_3 %>%
    filter(., parameter == "raw")

  # create data frame of distinct calculated statistics
  calculated_statistics <- analysis_dataset_3 %>%
    filter(., parameter != "raw") %>%
    distinct() %>%
    group_by(well, recording_time, parameter) %>%
    slice(which.max(!is.na(value)))

  # pivot raw data wider so can plot
  analysis_dataset_4 <- raw_values %>%
    pivot_wider(id_cols = c(well, recording_time),
                names_from = parameter,
                values_from = value,
                values_fn = list) %>%
    unnest(cols = c(raw))


  # pivot data wider so can plot individual columns
  analysis_dataset_5 <- calculated_statistics %>%
    pivot_wider(id_cols = c(well, recording_time),
                names_from = parameter,
                values_from = value,
                values_fn = list)

  # reassign column name and class
  analysis_dataset_5[, 3:5] <- sapply(analysis_dataset_5[, 3:5], as.numeric)

  #plot barchart
  p <- analysis_dataset_5 %>%
    ggplot(aes(x = well, y = mean, fill = recording_time)) +
    geom_bar(stat='identity', position=position_dodge()) +
    geom_errorbar(aes(ymin = mean - {{statistic}}, ymax = mean + {{statistic}}), linewidth = 0.4, colour = "orange", alpha = 0.9, size = 1.5, position=position_dodge()) +
    geom_point(data = analysis_dataset_4, aes(x = well, y = raw, fill = recording_time), position = position_jitterdodge(jitter.width = 0.1, dodge.width = 0.9)) +
    labs(fill = "Time Interval", y = y_axis_title)

  return(p)

}


