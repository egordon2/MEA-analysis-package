

#' Single Electrode Bar chart
#'
#' @description Function creates a bar chart of calculated MEA parameters by single electrode for a given time interval and recording.
#'
#' @param data Dataset containing electrode burst data and calculated MEA parameter.
#'  Use create_electrode_dataset and electrode parameter functions to preprocess data before use in this function (i.e., electrode_burst_duration, electrode_mean_burst_ISI, electrode_number_of_bursts, electrode_spikes_per_burst).
#' @param electrode_parameter Include "number_of_bursts"/ "burst_duration"/ "spikes_per_burst"/ "mean_burst_ISI" to determine the parameter visualised in the barchart.
#' @param electrode_filter Argument can be used to filter for single electrodes to include in the barchart.
#' @param statistic Include "se" or "sd" to determine whether bar chart error bars represent the standard error or standard deviation of the mean.
#'
#' @return A bar chart of calculated MEA parameters by single electrode for a given time interval and recording.
#' @importFrom data.table melt
#' @importFrom dplyr contains distinct filter group_by ungroup mutate select slice
#' @importFrom ggplot2 geom_bar geom_errorbar geom_point ggplot labs aes position_dodge position_jitterdodge scale_fill_grey
#' @importFrom stringr str_detect
#' @importFrom tidyr pivot_wider unnest
#' @export
#'
#' @examples
#' p <- single_electrode_barchart(data = input_electrode_barchart,
#'                           electrode_parameter = "burst_duration",
#'                           electrode_filter = "A1_",
#'                           statistic = se)
#'
#' p <- single_electrode_barchart(data = input_electrode_barchart,
#'                           electrode_parameter = "spikes_per_burst",
#'                           electrode_filter = "A1_",
#'                           statistic = se)
#'
#' p <- single_electrode_barchart(data = input_electrode_barchart,
#'                           electrode_parameter = "mean_burst_ISI",
#'                           electrode_filter = "A1_",
#'                           statistic = se)
#'
#' p <- single_electrode_barchart(data = input_electrode_barchart,
#'                           electrode_parameter = "number_of_bursts",
#'                           electrode_filter = "A1_")

single_electrode_barchart <- function(data = output_table,
                                electrode_parameter,
                                electrode_filter =
                                  "A1|A2|A3|A4|A5|A6|B1|B2|B3|B4|B5|B6|C1|C2|C3|C4|C5|C6|D1|D2|D3|D4|D5|D6",
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
    filter(., str_detect(Electrode, electrode_filter))

  #assign y axis title dependent on chosen electrode parameter
  #(include "number_of_bursts"/ "burst_duration"/ "spikes_per_burst"/ "mean_burst_ISI")

  if (electrode_parameter == "number_of_bursts") {
    y_axis_title <- "Number of Bursts"
    analysis_dataset_2 <- select(analysis_dataset, "Electrode"|contains("electrode_number_of_bursts"))

  } else if (electrode_parameter == "burst_duration") {
    y_axis_title <- "Burst Duration - Average (sec)"
    analysis_dataset_2 <- select(analysis_dataset, "Electrode"|contains("electrode_duration_raw")|contains("electrode_duration_mean")|contains("electrode_duration_sd")|contains("electrode_duration_se"))
    colnames(analysis_dataset_2) = gsub("electrode_duration_", "", colnames(analysis_dataset_2))

  } else if (electrode_parameter == "spikes_per_burst") {
    y_axis_title <- "Number of Spikes per Burst - Average"
    analysis_dataset_2 <- select(analysis_dataset, "Electrode"|contains("electrode_spikes_raw")|contains("electrode_spikes_mean")|contains("electrode_spikes_sd")|contains("electrode_spikes_se"))
    colnames(analysis_dataset_2) = gsub("electrode_spikes_", "", colnames(analysis_dataset_2))

  } else if (electrode_parameter == "mean_burst_ISI") {
    y_axis_title <- "Mean ISI within Burst - Average (sec)"
    analysis_dataset_2 <- select(analysis_dataset, "Electrode"|contains("electrode_raw_mean_burst_ISI")|contains("electrode_avg_mean_burst_ISI")|contains("electrode_sd_mean_burst_ISI")|contains("electrode_se_mean_burst_ISI"))
    colnames(analysis_dataset_2) = gsub("_mean_burst_ISI", "", colnames(analysis_dataset_2))
    colnames(analysis_dataset_2) = gsub("electrode_", "", colnames(analysis_dataset_2))
    colnames(analysis_dataset_2) = gsub("avg", "mean", colnames(analysis_dataset_2))


  }  else {

  }

  #reformat data for plotting
  analysis_dataset_3 <- melt(analysis_dataset_2, id = "Electrode")
  analysis_dataset_3$recording_time = gsub(pattern = ".*:", replacement = "", x = analysis_dataset_3$variable)
  analysis_dataset_3$parameter = gsub(pattern = "\\:.*", replacement = "", x = analysis_dataset_3$variable)
  analysis_dataset_3 <- analysis_dataset_3 %>%
    select(-c(variable))

  # remove duplicate rows if not raw value
  # create analysis dataset for use in bar plot dependent on chosen parameter

  if (electrode_parameter == "number_of_bursts") {

    #remove duplicate rows where value is NA (grouped by electrode, recording_time, and parameter)
    analysis_dataset_4 <- analysis_dataset_3 %>%
      group_by(Electrode, recording_time, parameter) %>%
      filter(value == max(value)) %>%
      distinct() %>%
      ungroup()

    #pivot data wider so can plot individual columns
    analysis_dataset_5 <- analysis_dataset_4 %>%
      pivot_wider(id_cols = c(Electrode, recording_time),
                  names_from = parameter,
                  values_from = value)

  }  else {

    # create data frame of raw values
    raw_values <- analysis_dataset_3 %>%
      filter(., parameter == "raw")

    # create data frame of distinct calculated statistics
    calculated_statistics <- analysis_dataset_3 %>%
      filter(., parameter != "raw") %>%
      distinct() %>%
      group_by(Electrode, recording_time, parameter) %>%
      slice(which.max(!is.na(value)))

    # pivot raw data wider so can plot
    analysis_dataset_4 <- raw_values %>%
      pivot_wider(id_cols = c(Electrode, recording_time),
                  names_from = parameter,
                  values_from = value,
                  values_fn = list) %>%
      unnest(cols = c(raw))


    # pivot data wider so can plot individual columns
    analysis_dataset_5 <- calculated_statistics %>%
      pivot_wider(id_cols = c(Electrode, recording_time),
                  names_from = parameter,
                  values_from = value,
                  values_fn = list)

    # reassign column name and class
    analysis_dataset_5[, 3:5] <- sapply(analysis_dataset_5[, 3:5], as.numeric)


  }

    # plot barchart
  if (electrode_parameter == "number_of_bursts") {

    p <- analysis_dataset_5 %>%
      ggplot(aes(x = Electrode, y = electrode_number_of_bursts, fill = recording_time)) +
      geom_bar(stat='identity', position=position_dodge()) +
      labs(fill = "Time Interval", y = y_axis_title)

  } else {

    p <- analysis_dataset_5 %>%
      ggplot(aes(x = Electrode, y = mean, fill = recording_time)) +
      geom_bar(stat='identity', position=position_dodge()) +
      geom_errorbar(aes(ymin = mean - {{statistic}}, ymax = mean + {{statistic}}), linewidth = 0.4, colour = "orange", alpha = 0.9, size = 1.5, position=position_dodge()) +
      geom_point(data = analysis_dataset_4, aes(x = Electrode, y = raw, fill = recording_time), position = position_jitterdodge(jitter.width = 0.1, dodge.width = 0.9)) +
      labs(fill = "Time Interval", y = y_axis_title)

  }

  return(p)
}


