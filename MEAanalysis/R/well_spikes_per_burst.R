
#' Well Spikes per Burst
#'
#' @description Function reads in electrode burst list data and creates new columns with the mean, SD, and SEM number of spikes per burst recorded for each well (within the specified time interval and recording).
#'
#' @param data Electrode burst list dataset preprocessed using the create_electrode_dataset function.
#' @param time_lower_bound Define lower bound of time interval for which to calculate the MEA parameter (seconds).
#' @param time_upper_bound Define upper bound of time interval for which to calculate the MEA parameter (seconds).
#' @param recording_identifier Define recording for which to calculate the MEA parameter. Use recording_identifier defined in create_electrode_dataset function.
#'
#' @return An electrode burst list table with three additional columns (mean, SD and SEM number of spikes per burst recorded for each well within the specified time interval and recording).
#' @importFrom dplyr between distinct filter group_by mutate select ungroup
#' @importFrom stats sd
#' @export
#'
#' @examples
#' output_MEA_data <- well_spikes_per_burst(data = input_MEA_data,
#'                                          time_lower_bound = 0,
#'                                          time_upper_bound = 30,
#'                                          recording_identifier = "burst_recording_1")



well_spikes_per_burst <- function(data = output_table, time_lower_bound = 0, time_upper_bound  = Inf, recording_identifier){

  # Declare variables
  data_1 <- NULL
  data_2 <- NULL
  data_3 <- NULL

  time_interval <- paste(time_lower_bound, time_upper_bound, sep="-")

  # error handling if columns already exists

  if (paste0("well_spikes_mean: ", recording_identifier, " ", time_interval, " (s)") %in% colnames(data)) {

    message("columns already exist")
    stop()

  } else if (paste0("well_spikes_sd: ", recording_identifier, " ", time_interval, " (s)") %in% colnames(data)) {

    message("columns already exist")
    stop()

  } else if (paste0("well_spikes_se: ", recording_identifier, " ", time_interval, " (s)") %in% colnames(data)) {

    message("columns already exist")
    stop()

  } else if (paste0("well_spikes_raw: ", recording_identifier, " ", time_interval, " (s)") %in% colnames(data)) {

    message("columns already exist")
    stop()

  }

  # run function if columns do not already exist

  else {

  # filter for bursts within given time interval of the recording
  data_1 <- data %>%
    filter(., between(Time_s, time_lower_bound, time_upper_bound)) %>%
    filter(., Recording_identifier == recording_identifier)

  # calculate the average, sd, and se number of spikes per burst within a well
  data_2  <- data_1 %>%
    group_by(well) %>%
    mutate(well_spikes_raw = Size_spikes) %>%
    mutate(well_spikes_mean = mean(Size_spikes)) %>%
    mutate(well_spikes_sd = sd(Size_spikes)) %>%
    mutate(well_spikes_se = sd(Size_spikes)/sqrt(length(Size_spikes))) %>%
    ungroup() %>%
    select(c(Electrode, Recording_identifier, well, Time_s, Size_spikes, Duration_s, well_spikes_raw, well_spikes_mean, well_spikes_sd, well_spikes_se)) %>%
    distinct()

  # merge calculated columns onto original dataset
  data_3 <- merge(data, data_2, by = c("Electrode", "Recording_identifier", "well", "Time_s", "Size_spikes", "Duration_s"), all = TRUE)

  names(data_3)[names(data_3) == "well_spikes_raw"] <- paste0("well_spikes_raw: ", recording_identifier, " ", time_interval, " (s)")
  names(data_3)[names(data_3) == "well_spikes_mean"] <- paste0("well_spikes_mean: ", recording_identifier, " ", time_interval, " (s)")
  names(data_3)[names(data_3) == "well_spikes_sd"] <- paste0("well_spikes_sd: ", recording_identifier, " ", time_interval, " (s)")
  names(data_3)[names(data_3) == "well_spikes_se"] <- paste0("well_spikes_se: ", recording_identifier, " ", time_interval, " (s)")

  return(data_3)

  }

}
