
#' Electrode Spikes per Burst
#'
#' @description Function reads in electrode burst list data and creates new columns with the mean, SD, and SEM number of spikes per burst recorded by single electrodes within a given time interval and recording
#'
#' @param name data, time_lower_bound, time_upper_bound, recording_identifier
#'
#' @return electrode burst list table with three additional columns (mean, SD and SEM number of spikes per burst for single electrodes within a given time interval and recording)
#' @export
#'
#' @examples
#' output_table <- electrode_spikes_per_burst(data = output_table, 0, 30, recording_identifier = "test_data_1")


electrode_spikes_per_burst <- function(data = output_table, time_lower_bound = 0, time_upper_bound  = Inf, recording_identifier){

  time_interval <- paste(time_lower_bound, time_upper_bound, sep="-")

  # error handling if columns already exists

  if (paste0("electrode_spikes_mean: ", recording_identifier, " ", time_interval, " (s)") %in% colnames(data)) {

    print("columns already exist")
    stop()

  } else if (paste0("electrode_spikes_sd: ", recording_identifier, " ", time_interval, " (s)") %in% colnames(data)) {

    print("columns already exist")
    stop()

  } else if (paste0("electrode_spikes_se: ", recording_identifier, " ", time_interval, " (s)") %in% colnames(data)) {

    print("columns already exist")
    stop()

  } else if (paste0("electrode_spikes_raw: ", recording_identifier, " ", time_interval, " (s)") %in% colnames(data)) {

    print("columns already exist")
    stop()

  }

  # run function if columns do not already exist

  else {

  data_1 <- data %>%
    filter(between(Time_s, time_lower_bound, time_upper_bound)) %>%
    filter(Recording_identifier == recording_identifier)

  data_2  <- data_1 %>%
    group_by(Electrode) %>%
    mutate(spikes_raw = Size_spikes) %>%
    mutate(spikes_mean = mean(Size_spikes)) %>%
    mutate(spikes_sd = sd(Size_spikes)) %>%
    mutate(spikes_se = sd(Size_spikes)/sqrt(length(Size_spikes))) %>%
    select(c(Electrode, Recording_identifier, Time_s, Size_spikes, Duration_s, spikes_raw, spikes_mean, spikes_sd, spikes_se)) %>%
    distinct()

  data_3 <- merge(data, data_2, by = c("Electrode", "Recording_identifier", "Time_s", "Size_spikes", "Duration_s"), all = TRUE)

  names(data_3)[names(data_3) == "spikes_raw"] <- paste0("electrode_spikes_raw: ", recording_identifier, " ", time_interval, " (s)")
  names(data_3)[names(data_3) == "spikes_mean"] <- paste0("electrode_spikes_mean: ", recording_identifier, " ", time_interval, " (s)")
  names(data_3)[names(data_3) == "spikes_sd"] <- paste0("electrode_spikes_sd: ", recording_identifier, " ", time_interval, " (s)")
  names(data_3)[names(data_3) == "spikes_se"] <- paste0("electrode_spikes_se: ", recording_identifier, " ", time_interval, " (s)")

  return(data_3)

  }

}
