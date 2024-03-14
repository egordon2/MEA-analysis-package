
##################################################################################################################################

### Example script for creating a heat map of MEA well synchrony index grouped by a specified time interval within a recording ###

##################################################################################################################################

# script uses the neuralMetric dataset produced by the axis navigator software neural metric tool
# user to run neural metric tool for desired time interval of a recording (maintain consistent parameters and inclusion criteria)

### Following code reads in neuralMetric dataset in csv format and processes for use in analysis
### Function should be run for each time interval within a recording which you wish to include as a variable of the heatmap
### User needs to update the assigned dataset titles (used for merging datasets), the data_path (direct to neural metric dataset), and heatmap_condition (determines heatmap x axis condition labels)

baseline_data <- create_synchrony_dataset(data_path = "./inst/data/baseline_neuralMetrics.csv",
                                          heatmap_condition = "Baseline")
agonist_challenge_data <- create_synchrony_dataset(data_path = "./inst/data/comparison_agonist_challenge_neuralMetrics.csv",
                                          heatmap_condition = "Agonist Challenge")

### Following code merges the above datasets by well
### User to update df_list to include the above assigned data titles for merging

df_list <- list(baseline_data, agonist_challenge_data)
heatmap_data <- df_list %>%
  reduce(full_join, by = 'Well')

# Following code generates a heatmap grouped by the heatmap_condition specified above

MEA_heatmap(data = heatmap_data, well_filter = "A1|A2|A3|A4|A5|A6|B1|B2|B3|B4|B5|B6|C1|C2|C3|C4|C5|C6|D1|D2|D3|D4|D5|D6")
