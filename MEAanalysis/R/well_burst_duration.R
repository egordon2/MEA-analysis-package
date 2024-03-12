
#' Well Burst Duration
#'
#' @description Function reads in electrode burst list data and creates new columns with the mean, SD, and SEM burst duration recorded for each well within a given time interval of a recording
#'
#' @param name data, time_lower_bound, time_upper_bound, recording_identifier
#'
#' @return electrode burst list table with three additional columns (mean, SD and SEM burst duration recorded for each well within a given time interval of a recording)
#' @export
#'
#' @examples
#' output_table <- well_burst_duration(data = output_table, 0, 30, recording_identifier = "test_data_1")


well_burst_duration <- function(data = output_table, time_lower_bound = 0, time_upper_bound = Inf, recording_identifier){

  time_interval <- paste(time_lower_bound, time_upper_bound, sep="-")

  # error handling if columns already exists

  if (paste0("well_duration_mean: ", recording_identifier, " ", time_interval, " (s)") %in% colnames(data)) {

    print("columns already exist")
    stop()

  } else if (paste0("well_duration_sd: ", recording_identifier, " ", time_interval, " (s)") %in% colnames(data)) {

    print("columns already exist")
    stop()

  } else if (paste0("well_duration_se: ", recording_identifier, " ", time_interval, " (s)") %in% colnames(data)) {

    print("columns already exist")
    stop()

  } else if (paste0("well_duration_raw: ", recording_identifier, " ", time_interval, " (s)") %in% colnames(data)) {

    print("columns already exist")
    stop()

  }

  # run function if columns do not already exist

  else {

  # filter for bursts within given time interval of the recording
  data_1 <- data %>%
    filter(between(Time_s, time_lower_bound, time_upper_bound)) %>%
    filter(Recording_identifier == recording_identifier)

  # calculate the average, sd, and se burst duration within a well
  data_2  <- data_1 %>%
    group_by(well) %>%
    mutate(well_duration_raw = Duration_s) %>%
    mutate(well_duration_mean = mean(Duration_s)) %>%
    mutate(well_duration_sd = sd(Duration_s)) %>%
    mutate(well_duration_se = sd(Duration_s)/sqrt(length(Duration_s))) %>%
    ungroup() %>%
    select(c(Electrode, Recording_identifier, well, Time_s, Size_spikes, Duration_s, well_duration_raw, well_duration_mean, well_duration_sd, well_duration_se)) %>%
    distinct()

  # merge calculated columns onto original dataset
  data_3 <- merge(data, data_2, by = c("Electrode", "Recording_identifier", "well", "Time_s", "Size_spikes", "Duration_s"), all = TRUE)

  # rename column titles to include time interval
  names(data_3)[names(data_3) == "well_duration_raw"] <- paste0("well_duration_raw: ", recording_identifier, " ", time_interval, " (s)")
  names(data_3)[names(data_3) == "well_duration_mean"] <- paste0("well_duration_mean: ", recording_identifier, " ", time_interval, " (s)")
  names(data_3)[names(data_3) == "well_duration_sd"] <- paste0("well_duration_sd: ", recording_identifier, " ", time_interval, " (s)")
  names(data_3)[names(data_3) == "well_duration_se"] <- paste0("well_duration_se: ", recording_identifier, " ", time_interval, " (s)")

  return(data_3)

  }

}

