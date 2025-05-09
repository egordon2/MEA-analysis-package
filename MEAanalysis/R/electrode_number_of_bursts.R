
#' Electrode Number of Bursts
#'
#' @description Function reads in electrode burst list data and creates new columns with the mean, SD, and SEM number of bursts recorded by single electrodes (within the specified time interval and recording).
#'
#' @param data Electrode burst list dataset preprocessed using the create_electrode_dataset function.
#' @param time_lower_bound Define lower bound of time interval for which to calculate the MEA parameter (seconds).
#' @param time_upper_bound Define upper bound of time interval for which to calculate the MEA parameter (seconds).
#' @param recording_identifier Define recording for which to calculate the MEA parameter. Use recording_identifier defined in create_electrode_dataset function.
#'
#' @return An electrode burst list table with three additional columns (mean, SD and SEM number of bursts for single electrodes within the specified time interval and recording).
#' @importFrom dplyr between coalesce count distinct filter group_by mutate select add_count
#' @export
#'
#' @examples
#' output_MEA_data <- electrode_number_of_bursts(data = input_MEA_data,
#'                                               time_lower_bound = 0,
#'                                               time_upper_bound = 30,
#'                                               recording_identifier = "burst_recording_1")

electrode_number_of_bursts <- function(data = output_table, time_lower_bound = 0, time_upper_bound  = Inf, recording_identifier) {

  # Declare variables
  data_1 <- NULL
  data_2 <- NULL
  data_3 <- NULL

  time_interval <- paste(time_lower_bound, time_upper_bound, sep="-")

  # error handling if columns already exists

  if (paste0("electrode_number_of_bursts: ", recording_identifier, " ", time_interval, " (s)") %in% colnames(data)) {

    message("column already exists")
    stop()

  }

  # run function if columns do not already exist

  else {

  data_1 <- data %>%
    filter(., between(Time_s, time_lower_bound, time_upper_bound)) %>%
    filter(., Recording_identifier == recording_identifier)

  data_2 <- data_1 %>%
    group_by(Electrode) %>%
    add_count(Electrode, name = "burst_count") %>%
    select(c(Electrode, Recording_identifier, burst_count)) %>%
    distinct()

  data_3 <- merge(data, data_2, by = c("Electrode", "Recording_identifier"), all = TRUE) %>%
    mutate(burst_count = coalesce(burst_count, 0))

  time_interval <- paste(time_lower_bound, time_upper_bound, sep="-")
  names(data_3)[names(data_3) == "burst_count"] <- paste0("electrode_number_of_bursts: ", recording_identifier, " ", time_interval, " (s)")

  return(data_3)

  }

}






