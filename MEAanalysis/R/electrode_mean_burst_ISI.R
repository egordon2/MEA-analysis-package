
###########################################################################################################################################################################################

######  function creates new columns with the mean, SD, and SEM mean ISI within a burst (sec) recorded by specific electrodes within a given time interval in a specific recording   ###### 

###########################################################################################################################################################################################

electrode_mean_burst_ISI <- function(data = output_table, time_lower_bound = 0, time_upper_bound = Inf, recording_identifier) {
  
  time_interval <- paste(time_lower_bound, time_upper_bound, sep="-")
  
  # error handling if columns already exists
  
  if (paste0("electrode_avg_mean_burst_ISI: ", recording_identifier, " ", time_interval, " (s)") %in% colnames(data)) {
    
    print("columns already exist")
    stop()
    
  } else if (paste0("electrode_sd_mean_burst_ISI: ", recording_identifier, " ", time_interval, " (s)") %in% colnames(data)) {
    
    print("columns already exist")
    stop() 
    
  } else if (paste0("electrode_se_mean_burst_ISI: ", recording_identifier, " ", time_interval, " (s)") %in% colnames(data)) {
    
    print("columns already exist")
    stop() 
    
  } else if (paste0("electrode_raw_mean_burst_ISI: ", recording_identifier, " ", time_interval, " (s)") %in% colnames(data)) {
    
    print("columns already exist")
    stop() 
    
  }
  
  # run function if columns do not already exist
  
  else {
  
  #filter data for time interval and recording identifier
  data_1 <- data %>% 
    filter(between(Time_s, time_lower_bound, time_upper_bound)) %>% 
    filter(Recording_identifier == recording_identifier)
  
  #calculate mean ISI within a burst (sec)
  data_2 <- data_1 %>% 
    mutate(mean_burst_ISI_s = Duration_s / (Size_spikes - 1)) %>% 
    #calculate average mean ISI within a burst (sec) recorded by a specific electrode
    group_by(Electrode) %>% 
    mutate(avg_mean_burst_ISI = mean(mean_burst_ISI_s)) %>% 
    mutate(sd_mean_burst_ISI = sd(mean_burst_ISI_s)) %>% 
    mutate(se_mean_burst_ISI = sd(mean_burst_ISI_s)/sqrt(length(mean_burst_ISI_s))) %>% 
    select(c(Electrode, Recording_identifier, Time_s, Size_spikes, Duration_s, mean_burst_ISI_s, avg_mean_burst_ISI, sd_mean_burst_ISI, se_mean_burst_ISI)) %>% 
    distinct()
  
  data_3 <- merge(data, data_2, by = c("Electrode", "Recording_identifier", "Time_s", "Size_spikes", "Duration_s"), all = TRUE)

  names(data_3)[names(data_3) == "mean_burst_ISI_s"] <- paste0("electrode_raw_mean_burst_ISI: ", recording_identifier, " ", time_interval, " (s)")
  names(data_3)[names(data_3) == "avg_mean_burst_ISI"] <- paste0("electrode_avg_mean_burst_ISI: ", recording_identifier, " ", time_interval, " (s)")
  names(data_3)[names(data_3) == "sd_mean_burst_ISI"] <- paste0("electrode_sd_mean_burst_ISI: ", recording_identifier, " ", time_interval, " (s)")
  names(data_3)[names(data_3) == "se_mean_burst_ISI"] <- paste0("electrode_se_mean_burst_ISI: ", recording_identifier, " ", time_interval, " (s)")
  
  return(data_3)
  
  }
  
}
