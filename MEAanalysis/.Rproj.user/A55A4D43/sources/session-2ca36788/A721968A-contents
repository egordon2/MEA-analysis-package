
########################################################################################################

### Example script for creating a bar chart of calculated MEA parameters grouped by single electrode ###

########################################################################################################

# Following code reads in electrode burst dataset produced by the axis navigator software in csv format and processes for use in analysis
# User to update the data_path (direct to electrode burst dataset) and recording identifier (used to determine time interval within specific recording)

test_data_1 <- create_electrode_dataset(data_path = "./inst/data/baseline_electrode_burst_list.csv",
                                             recording_identifier = "test_data_1")
test_data_2 <- create_electrode_dataset(data_path = "./inst/data/comparison_agonist_challenge_electrode_burst_list.csv",
                                             recording_identifier = "test_data_2")

# Following code merges datasets together vertically (list datasets for use in analysis in the rbind function, use examples below to update code)
# Rerun code if with to refresh dataset used to create barchart
# e.g., output_table <- rbind(test_data_1)
# e.g., output_table <- rbind(test_data_1, test_data_2)

output_table <- rbind(test_data_1, test_data_2)

# Following code calculates a chosen parameter for a specific time interval and recordings by single electrodes
# new columns will be added to the dataset each time a function is run (run above rbind function to refresh)
# update time interval (s) and recording identifier accordingly i.e., function(data, time_lower_bound, time_upper_bound, recording_identifier)

# output_table <- number_of_bursts() #calculates number of bursts within a given time interval by electrode (for a specific recording)
# output_table <- burst_duration() #calculates the mean, sd, and se burst duration within a given time interval by electrode (for a specific recording)
# output_table <- spikes_per_burst() #calculates mean, sd, and se number of spikes per burst within a given time interval by electrode (for a specific recording)
# output_table <- mean_burst_ISI() #calculates average, sd, and se mean ISI within a burst (sec) for a given time interval by electrode (for a specific recording)

# EXAMPLE CODE: calculates each parameter for each individual electrode within the given time interval for a recording

output_table <- electrode_burst_duration(data = output_table, 0, 30, recording_identifier = "test_data_1")
output_table <- electrode_burst_duration(data = output_table, 30, 60, recording_identifier = "test_data_1")
output_table <- electrode_burst_duration(data = output_table, 60, 90, recording_identifier = "test_data_1")
output_table <- electrode_burst_duration(data = output_table, 60, 90, recording_identifier = "test_data_2")

output_table <- electrode_spikes_per_burst(data = output_table, 0, 30, recording_identifier = "test_data_1")
output_table <- electrode_spikes_per_burst(data = output_table, 30, 60, recording_identifier = "test_data_1")
output_table <- electrode_spikes_per_burst(data = output_table, 60, 90, recording_identifier = "test_data_1")
output_table <- electrode_spikes_per_burst(data = output_table, 60, 90, recording_identifier = "test_data_2")

output_table <- electrode_mean_burst_ISI(data = output_table, 0, 30, recording_identifier = "test_data_1")
output_table <- electrode_mean_burst_ISI(data = output_table, 30, 60, recording_identifier = "test_data_1")
output_table <- electrode_mean_burst_ISI(data = output_table, 60, 90, recording_identifier = "test_data_1")
output_table <- electrode_mean_burst_ISI(data = output_table, 60, 90, recording_identifier = "test_data_2")

output_table <- electrode_number_of_bursts(data = output_table, 0, 30, recording_identifier = "test_data_1")
output_table <- electrode_number_of_bursts(data = output_table, 30, 60, recording_identifier = "test_data_1")
output_table <- electrode_number_of_bursts(data = output_table, 60, 90, recording_identifier = "test_data_1")
output_table <- electrode_number_of_bursts(data = output_table, 60, 90, recording_identifier = "test_data_2")

# Following code creates a bar chart of the calculated MEA parameter grouped by single electrode
# User to update function arguments accordingly i.e., single_electrode_barchart(data, electrode_parameter, electrode_filter, statistic)
# For electrode_parameter argument include "number_of_bursts"/ "burst_duration"/ "spikes_per_burst"/ "mean_burst_ISI"
# Note statistics will not be calculated for the number of bursts within a given time interval

single_electrode_barchart(data = output_table, electrode_parameter = "burst_duration", electrode_filter = "A1_", statistic = se)
single_electrode_barchart(data = output_table, electrode_parameter = "spikes_per_burst", electrode_filter = "A1_", statistic = se)
single_electrode_barchart(data = output_table, electrode_parameter = "mean_burst_ISI", electrode_filter = "A1_", statistic = se)
single_electrode_barchart(data = output_table, electrode_parameter = "number_of_bursts", electrode_filter = "A1_")

