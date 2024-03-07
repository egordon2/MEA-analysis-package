
##################################################################################################################################################################

######  function creates new columns with the mean, SD, and SEM mean ISI within a burst (sec) for each well within a given time interval of a recording   ########

##################################################################################################################################################################

well_mean_burst_ISI <- function(data = output_table, time_lower_bound = 0, time_upper_bound = Inf, recording_identifier) {
  
  time_interval <- paste(time_lower_bound, time_upper_bound, sep="-")
  
  # error handling if columns already exists
  
  if (paste0("well_avg_mean_burst_ISI: ", recording_identifier, " ", time_interval, " (s)") %in% colnames(data)) {
    
    print("columns already exist")
    stop()
    
  } else if (paste0("well_sd_mean_burst_ISI: ", recording_identifier, " ", time_interval, " (s)") %in% colnames(data)) {
    
    print("columns already exist")
    stop() 
    
  } else if (paste0("well_se_mean_burst_ISI: ", recording_identifier, " ", time_interval, " (s)") %in% colnames(data)) {
    
    print("columns already exist")
    stop() 
    
  } else if (paste0("well_raw_mean_burst_ISI: ", recording_identifier, " ", time_interval, " (s)") %in% colnames(data)) {
    
    print("columns already exist")
    stop() 
    
  }
  
  # run function if columns do not already exist
  
  else {
  
  # filter for bursts within given time interval of the recording
  data_1 <- data %>% 
    filter(between(Time_s, time_lower_bound, time_upper_bound)) %>% 
    filter(Recording_identifier == recording_identifier) 
  
  #calculate mean ISI within a burst (sec)
  data_2 <- data_1 %>% 
    mutate(mean_burst_ISI_s = Duration_s / (Size_spikes - 1)) %>% 
    #calculate average mean ISI within a burst (sec) for each well
    group_by(well) %>% 
    mutate(well_avg_mean_burst_ISI = mean(mean_burst_ISI_s)) %>% 
    mutate(well_sd_mean_burst_ISI = sd(mean_burst_ISI_s)) %>% 
    mutate(well_se_mean_burst_ISI = sd(mean_burst_ISI_s)/sqrt(length(mean_burst_ISI_s))) %>% 
    ungroup() %>% 
    select(c(Electrode, Recording_identifier, well, Time_s, Size_spikes, Duration_s, mean_burst_ISI_s, well_avg_mean_burst_ISI, well_sd_mean_burst_ISI, well_se_mean_burst_ISI)) %>% 
    distinct()
  
  # merge calculated columns onto original dataset
  data_3 <- merge(data, data_2, by = c("Electrode", "Recording_identifier", "well", "Time_s", "Size_spikes", "Duration_s"), all = TRUE)
  
  # rename column titles to include time interval
  names(data_3)[names(data_3) == "mean_burst_ISI_s"] <- paste0("well_raw_mean_burst_ISI: ", recording_identifier, " ", time_interval, " (s)")
  names(data_3)[names(data_3) == "well_avg_mean_burst_ISI"] <- paste0("well_avg_mean_burst_ISI: ", recording_identifier, " ", time_interval, " (s)")
  names(data_3)[names(data_3) == "well_sd_mean_burst_ISI"] <- paste0("well_sd_mean_burst_ISI: ", recording_identifier, " ", time_interval, " (s)")
  names(data_3)[names(data_3) == "well_se_mean_burst_ISI"] <- paste0("well_se_mean_burst_ISI: ", recording_identifier, " ", time_interval, " (s)")
  
  return(data_3) 
  
  }
  
}






