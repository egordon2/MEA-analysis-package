
#' Well Number of Bursts
#'
#' @description Function reads in electrode burst list data and creates new columns with the mean, SD, and SEM number of bursts recorded for each well (within the specified time interval and recording).
#'
#' @param data Electrode burst list dataset preprocessed using the create_electrode_dataset function.
#' @param time_lower_bound Define lower bound of time interval for which to calculate the MEA parameter (seconds).
#' @param time_upper_bound Define upper bound of time interval for which to calculate the MEA parameter (seconds).
#' @param recording_identifier Define recording for which to calculate the MEA parameter. Use recording_identifier defined in create_electrode_dataset function.
#'
#' @return An electrode burst list table with three additional columns (mean, SD and SEM number of bursts recorded for each well within the specified time interval and recording).
#' @importFrom dplyr between distinct filter group_by mutate select
#' @export
#'
#' @examples
#' output_MEA_data <- well_number_of_bursts(data = input_MEA_data, 0, 30, recording_identifier = "burst_recording_1")

well_number_of_bursts <- function(data = output_table, time_lower_bound = 0, time_upper_bound  = Inf, recording_identifier) {

  # Declare variables
  electrode_list <- NULL
  data_1 <- NULL
  data_2 <- NULL
  data_3 <- NULL
  data_4 <- NULL
  data_5 <- NULL

  time_interval <- paste(time_lower_bound, time_upper_bound, sep="-")

  # error handling if columns already exists

  if (paste0("well_burst_count_mean: ", recording_identifier, " ", time_interval, " (s)") %in% colnames(data)) {

    print("columns already exist")
    stop()

  } else if (paste0("well_burst_count_sd: ", recording_identifier, " ", time_interval, " (s)") %in% colnames(data)) {

    print("columns already exist")
    stop()

  } else if (paste0("well_burst_count_se: ", recording_identifier, " ", time_interval, " (s)") %in% colnames(data)) {

    print("columns already exist")
    stop()

  } else if (paste0("well_burst_count_raw: ", recording_identifier, " ", time_interval, " (s)") %in% colnames(data)) {

    print("columns already exist")
    stop()

  }

  # run function if columns do not already exist

  else {

  #obtain list of electrodes and their recording
  electrode_list <- data %>%
    select(Electrode, Recording_identifier, well) %>%
    distinct()

  # filter for bursts within given time interval of the recording
  data_1 <- data %>%
    filter(., between(Time_s, time_lower_bound, time_upper_bound)) %>%
    filter(., Recording_identifier == recording_identifier)

  # calculate number of bursts detected by an electrode during the given time interval of the recording
  data_2 <- data_1 %>%
    group_by(Electrode) %>%
    add_count(Electrode, name = "electrode_burst_count") %>%
    ungroup() %>%
    select(c(Electrode, well, Recording_identifier, electrode_burst_count)) %>%
    distinct()

  # merge to electrode burst list to add count of 0 to electrodes where no bursts were detected during the time interval
  data_3 <- merge(electrode_list, data_2, by = c("Electrode", "well", "Recording_identifier"), all = TRUE) %>%
    mutate(electrode_burst_count = coalesce(electrode_burst_count, 0))

  # calculate average, sd, and se number of bursts detected by an electrode within a given well (includes all electrodes whether or not active during time interval)
  data_4 <- data_3 %>%
    group_by(well) %>%
    mutate(well_burst_count_mean = mean(electrode_burst_count)) %>%
    mutate(well_burst_count_sd = sd(electrode_burst_count)) %>%
    mutate(well_burst_count_se = sd(electrode_burst_count)/sqrt(length(electrode_burst_count))) %>%
    ungroup() %>%
    select(c(Electrode, Recording_identifier, electrode_burst_count, well_burst_count_mean, well_burst_count_sd, well_burst_count_se)) %>%
    distinct()

  # merge to original dataset
  data_5 <- merge(data, data_4, by = c("Electrode", "Recording_identifier"), all = TRUE)

  # rename column titles to include time interval
  names(data_5)[names(data_5) == "electrode_burst_count"] <- paste0("well_burst_count_raw: ", recording_identifier, " ", time_interval, " (s)")
  names(data_5)[names(data_5) == "well_burst_count_mean"] <- paste0("well_burst_count_mean: ", recording_identifier, " ", time_interval, " (s)")
  names(data_5)[names(data_5) == "well_burst_count_sd"] <- paste0("well_burst_count_sd: ", recording_identifier, " ", time_interval, " (s)")
  names(data_5)[names(data_5) == "well_burst_count_se"] <- paste0("well_burst_count_se: ", recording_identifier, " ", time_interval, " (s)")

  return(data_5)

  }

}









