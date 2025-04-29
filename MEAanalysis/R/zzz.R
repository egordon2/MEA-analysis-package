# zzz.R
utils::globalVariables(c(
  # Operators and internal variables
  ".", ":=", ".SD", "...1",
  
  # General variables used across functions
  "Well", "Electrode", "Recording_identifier", "Duration_s", "Size_spikes", 
  "Time_s", "value", "variable", "output_table", "parameter", "recording_time", 
  "experimental_condition", "synchrony_index", "X1", "se",
  
  # Electrode-specific metrics
  "duration_raw", "duration_mean", "duration_sd", "duration_se",
  "mean_burst_ISI_s", "avg_mean_burst_ISI", "sd_mean_burst_ISI", "se_mean_burst_ISI",
  "spikes_raw", "spikes_mean", "spikes_sd", "spikes_se",
  "burst_count", "electrode_burst_count",
  
  # Well-specific metrics
  "well", "well_duration_raw", "well_duration_mean", "well_duration_sd", "well_duration_se",
  "well_avg_mean_burst_ISI", "well_sd_mean_burst_ISI", "well_se_mean_burst_ISI",
  "well_burst_count_mean", "well_burst_count_sd", "well_burst_count_se",
  "well_spikes_raw", "well_spikes_mean", "well_spikes_sd", "well_spikes_se"
))