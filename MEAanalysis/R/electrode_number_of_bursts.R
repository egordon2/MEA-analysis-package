
#' Electrode Number of Bursts
#'
#' @description Function reads in electrode burst list data and creates new columns with the mean, SD, and SEM number of bursts recorded by single electrodes within a given time interval and recording
#'
#' @param name data, time_lower_bound, time_upper_bound, recording_identifier
#'
#' @return electrode burst list table with three additional columns (mean, SD and SEM number of bursts for single electrodes within a given time interval and recording)
#' @export
#'
#' @examples
#' output_table <- electrode_number_of_bursts(data = output_table, 0, 30, recording_identifier = "test_data_1")


electrode_number_of_bursts <- function(data = output_table, time_lower_bound = 0, time_upper_bound  = Inf, recording_identifier) {

  time_interval <- paste(time_lower_bound, time_upper_bound, sep="-")

  # error handling if columns already exists

  if (paste0("electrode_number_of_bursts: ", recording_identifier, " ", time_interval, " (s)") %in% colnames(data)) {

    print("column already exists")
    stop()

  }

  # run function if columns do not already exist

  else {

  data_1 <- data %>%
    filter(between(Time_s, time_lower_bound, time_upper_bound)) %>%
    filter(Recording_identifier == recording_identifier)

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






