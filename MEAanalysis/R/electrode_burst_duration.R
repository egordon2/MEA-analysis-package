
#' Electrode Burst Duration
#'
#' @description Function reads in electrode burst list data and creates new columns with the mean, SD, and SEM burst duration recorded by single electrodes (within the specified time interval and recording).
#'
#' @param data Electrode burst list dataset preprocessed using the create_electrode_dataset function.
#' @param time_lower_bound Define lower bound of time interval for which to calculate the MEA parameter (seconds).
#' @param time_upper_bound Define upper bound of time interval for which to calculate the MEA parameter (seconds).
#' @param recording_identifier Define recording for which to calculate the MEA parameter. Use recording_identifier defined in create_electrode_dataset function.
#'
#' @return An electrode burst list table with three additional columns (mean, SD and SEM burst duration for single electrodes within the specified time interval and recording).
#' @importFrom dplyr between distinct filter group_by mutate select
#' @importFrom stats sd
#' @export
#'
#' @examples
#' output_MEA_data <- electrode_burst_duration(data = input_MEA_data,
#'                                             time_lower_bound = 0,
#'                                             time_upper_bound = 30,
#'                                             recording_identifier = "burst_recording_1")

electrode_burst_duration <- function(data = output_table, time_lower_bound = 0, time_upper_bound = Inf, recording_identifier){

  # Declare variables
  data_1 <- NULL
  data_2 <- NULL
  data_3 <- NULL

  time_interval <- paste(time_lower_bound, time_upper_bound, sep="-")

  # error handling if columns already exists

  if (paste0("electrode_duration_mean: ", recording_identifier, " ", time_interval, " (s)") %in% colnames(data)) {

    message("columns already exist")
    stop()

  } else if (paste0("electrode_duration_sd: ", recording_identifier, " ", time_interval, " (s)") %in% colnames(data)) {

    message("columns already exist")
    stop()

  } else if (paste0("electrode_duration_se: ", recording_identifier, " ", time_interval, " (s)") %in% colnames(data)) {

    message("columns already exist")
    stop()

  } else if (paste0("electrode_duration_raw: ", recording_identifier, " ", time_interval, " (s)") %in% colnames(data)) {

    message("columns already exist")
    stop()

  }

  # run function if columns do not already exist

  else {

    # filter for time interval of specified recording
     data_1 <- data %>%
      filter(., between(Time_s, time_lower_bound, time_upper_bound)) %>%
      filter(., Recording_identifier == recording_identifier)

    # calculate new columns
    data_2  <- data_1 %>%
      group_by(Electrode) %>%
      mutate(duration_raw = Duration_s) %>%
      mutate(duration_mean = mean(Duration_s)) %>%
      mutate(duration_sd = sd(Duration_s)) %>%
      mutate(duration_se = sd(Duration_s)/sqrt(length(Duration_s))) %>%
      select(c(Electrode, Recording_identifier, Time_s, Size_spikes, Duration_s, duration_raw, duration_mean, duration_sd, duration_se)) %>%
      distinct()

    # merge new columns onto original dataset
    data_3 <- merge(data, data_2, by = c("Electrode", "Recording_identifier", "Time_s", "Size_spikes", "Duration_s"), all = TRUE)

    # create column of raw data only for specified time interval and recording

    names(data_3)[names(data_3) == "duration_raw"] <- paste0("electrode_duration_raw: ", recording_identifier, " ", time_interval, " (s)")
    names(data_3)[names(data_3) == "duration_mean"] <- paste0("electrode_duration_mean: ", recording_identifier, " ", time_interval, " (s)")
    names(data_3)[names(data_3) == "duration_sd"] <- paste0("electrode_duration_sd: ", recording_identifier, " ", time_interval, " (s)")
    names(data_3)[names(data_3) == "duration_se"] <- paste0("electrode_duration_se: ", recording_identifier, " ", time_interval, " (s)")

    return(data_3)

  }

}

