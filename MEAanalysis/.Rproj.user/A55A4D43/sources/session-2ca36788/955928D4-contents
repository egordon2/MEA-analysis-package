# Load raw data from .csv file

### Apply preprocessing for input_heatmap_data

baseline_data <- create_synchrony_dataset(data_path = "./data-raw/input_neuralMetric.csv",
                                          heatmap_condition = "Baseline")
agonist_challenge_data <- create_synchrony_dataset(data_path = "./data-raw/comparison_agonist_challenge_neuralMetrics.csv",
                                                   heatmap_condition = "Agonist Challenge")

df_list <- list(baseline_data, agonist_challenge_data)
input_heatmap_data <- df_list %>%
  reduce(full_join, by = 'Well')

### Apply preprocessing for input_well_barchart, input_electrode_barchart, and input_MEA_data

burst_recording_1 <- create_electrode_dataset(data_path = "./data-raw/input_electrode_burst.csv",
                                              recording_identifier = "burst_recording_1")
burst_recording_2 <- create_electrode_dataset(data_path = "./data-raw/comparison_agonist_challenge_electrode_burst_list.csv",
                                              recording_identifier = "burst_recording_2")
output_table <- rbind(burst_recording_1, burst_recording_2)

# MEA parameter data

input_MEA_data <- rbind(burst_recording_1, burst_recording_2)

# single electrode

output_table <- electrode_burst_duration(data = output_table, 0, 30, recording_identifier = "burst_recording_1")
output_table <- electrode_burst_duration(data = output_table, 30, 60, recording_identifier = "burst_recording_1")
output_table <- electrode_burst_duration(data = output_table, 60, 90, recording_identifier = "burst_recording_1")
output_table <- electrode_burst_duration(data = output_table, 60, 90, recording_identifier = "burst_recording_2")

output_table <- electrode_spikes_per_burst(data = output_table, 0, 30, recording_identifier = "burst_recording_1")
output_table <- electrode_spikes_per_burst(data = output_table, 30, 60, recording_identifier = "burst_recording_1")
output_table <- electrode_spikes_per_burst(data = output_table, 60, 90, recording_identifier = "burst_recording_1")
output_table <- electrode_spikes_per_burst(data = output_table, 60, 90, recording_identifier = "burst_recording_2")

output_table <- electrode_mean_burst_ISI(data = output_table, 0, 30, recording_identifier = "burst_recording_1")
output_table <- electrode_mean_burst_ISI(data = output_table, 30, 60, recording_identifier = "burst_recording_1")
output_table <- electrode_mean_burst_ISI(data = output_table, 60, 90, recording_identifier = "burst_recording_1")
output_table <- electrode_mean_burst_ISI(data = output_table, 60, 90, recording_identifier = "burst_recording_2")

output_table <- electrode_number_of_bursts(data = output_table, 0, 30, recording_identifier = "burst_recording_1")
output_table <- electrode_number_of_bursts(data = output_table, 30, 60, recording_identifier = "burst_recording_1")
output_table <- electrode_number_of_bursts(data = output_table, 60, 90, recording_identifier = "burst_recording_1")
output_table <- electrode_number_of_bursts(data = output_table, 60, 90, recording_identifier = "burst_recording_2")

input_electrode_barchart <- output_table

# well

output_table_2 <- rbind(burst_recording_1, burst_recording_2)

output_table_2 <- well_burst_duration(data = output_table_2, 0, 30, recording_identifier = "burst_recording_1")
output_table_2 <- well_burst_duration(data = output_table_2, 30, 60, recording_identifier = "burst_recording_1")
output_table_2 <- well_burst_duration(data = output_table_2, 60, 90, recording_identifier = "burst_recording_1")
output_table_2 <- well_burst_duration(data = output_table_2, 60, 90, recording_identifier = "burst_recording_2")

output_table_2 <- well_spikes_per_burst(data = output_table_2, 0, 30, recording_identifier = "burst_recording_1")
output_table_2 <- well_spikes_per_burst(data = output_table_2, 30, 60, recording_identifier = "burst_recording_1")
output_table_2 <- well_spikes_per_burst(data = output_table_2, 60, 90, recording_identifier = "burst_recording_1")
output_table_2 <- well_spikes_per_burst(data = output_table_2, 60, 90, recording_identifier = "burst_recording_2")

output_table_2 <- well_mean_burst_ISI(data = output_table_2, 0, 30, recording_identifier = "burst_recording_1")
output_table_2 <- well_mean_burst_ISI(data = output_table_2, 30, 60, recording_identifier = "burst_recording_1")
output_table_2 <- well_mean_burst_ISI(data = output_table_2, 60, 90, recording_identifier = "burst_recording_1")
output_table_2 <- well_mean_burst_ISI(data = output_table_2, 60, 90, recording_identifier = "burst_recording_2")

output_table_2 <- well_number_of_bursts(data = output_table_2, 0, 30, recording_identifier = "burst_recording_1")
output_table_2 <- well_number_of_bursts(data = output_table_2, 30, 60, recording_identifier = "burst_recording_1")
output_table_2 <- well_number_of_bursts(data = output_table_2, 60, 90, recording_identifier = "burst_recording_1")
output_table_2 <- well_number_of_bursts(data = output_table_2, 60, 90, recording_identifier = "burst_recording_2")

input_well_barchart <- output_table_2

# Save the cleaned data in the required R package location
usethis::use_data(input_heatmap_data, overwrite = TRUE)
usethis::use_data(input_electrode_barchart, overwrite = TRUE)
usethis::use_data(input_well_barchart, overwrite = TRUE)
usethis::use_data(input_MEA_data, overwrite = TRUE)




