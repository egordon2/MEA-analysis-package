pkgname <- "MEAanalysis"
source(file.path(R.home("share"), "R", "examples-header.R"))
options(warn = 1)
options(pager = "console")
base::assign(".ExTimings", "MEAanalysis-Ex.timings", pos = 'CheckExEnv')
base::cat("name\tuser\tsystem\telapsed\n", file=base::get(".ExTimings", pos = 'CheckExEnv'))
base::assign(".format_ptime",
function(x) {
  if(!is.na(x[4L])) x[1L] <- x[1L] + x[4L]
  if(!is.na(x[5L])) x[2L] <- x[2L] + x[5L]
  options(OutDec = '.')
  format(x[1L:3L], digits = 7L)
},
pos = 'CheckExEnv')

### * </HEADER>
library('MEAanalysis')

base::assign(".oldSearch", base::search(), pos = 'CheckExEnv')
base::assign(".old_wd", base::getwd(), pos = 'CheckExEnv')
cleanEx()
nameEx("MEA_heatmap")
### * MEA_heatmap

flush(stderr()); flush(stdout())

base::assign(".ptime", proc.time(), pos = "CheckExEnv")
### Name: MEA_heatmap
### Title: MEA_heatmap
### Aliases: MEA_heatmap

### ** Examples

MEA_heatmap(data = input_heatmap_data, well_filter = "A1|A2|A3|A4|A5|A6|B1|B2|B3|B4|B5|B6|C1|C2|C3|C4|C5|C6|D1|D2|D3|D4|D5|D6")



base::assign(".dptime", (proc.time() - get(".ptime", pos = "CheckExEnv")), pos = "CheckExEnv")
base::cat("MEA_heatmap", base::get(".format_ptime", pos = 'CheckExEnv')(get(".dptime", pos = "CheckExEnv")), "\n", file=base::get(".ExTimings", pos = 'CheckExEnv'), append=TRUE, sep="\t")
cleanEx()
nameEx("create_electrode_dataset")
### * create_electrode_dataset

flush(stderr()); flush(stdout())

base::assign(".ptime", proc.time(), pos = "CheckExEnv")
### Name: create_electrode_dataset
### Title: Create Electrode Data set
### Aliases: create_electrode_dataset

### ** Examples

output_electrode_burst <- create_electrode_dataset(data_path = system.file("extdata", "input_electrode_burst.csv", package = "MEAanalysis"), recording_identifier = "burst_recording_1")



base::assign(".dptime", (proc.time() - get(".ptime", pos = "CheckExEnv")), pos = "CheckExEnv")
base::cat("create_electrode_dataset", base::get(".format_ptime", pos = 'CheckExEnv')(get(".dptime", pos = "CheckExEnv")), "\n", file=base::get(".ExTimings", pos = 'CheckExEnv'), append=TRUE, sep="\t")
cleanEx()
nameEx("create_synchrony_dataset")
### * create_synchrony_dataset

flush(stderr()); flush(stdout())

base::assign(".ptime", proc.time(), pos = "CheckExEnv")
### Name: create_synchrony_dataset
### Title: Create Synchrony Data Set
### Aliases: create_synchrony_dataset

### ** Examples

output_neuralMetric <- create_synchrony_dataset(data_path = system.file("extdata", "input_neuralMetric.csv", package = "MEAanalysis"), heatmap_condition = "SI_condition_1")



base::assign(".dptime", (proc.time() - get(".ptime", pos = "CheckExEnv")), pos = "CheckExEnv")
base::cat("create_synchrony_dataset", base::get(".format_ptime", pos = 'CheckExEnv')(get(".dptime", pos = "CheckExEnv")), "\n", file=base::get(".ExTimings", pos = 'CheckExEnv'), append=TRUE, sep="\t")
cleanEx()
nameEx("electrode_burst_duration")
### * electrode_burst_duration

flush(stderr()); flush(stdout())

base::assign(".ptime", proc.time(), pos = "CheckExEnv")
### Name: electrode_burst_duration
### Title: Electrode Burst Duration
### Aliases: electrode_burst_duration

### ** Examples

output_MEA_data <- electrode_burst_duration(data = input_MEA_data, 0, 30, recording_identifier = "burst_recording_1")



base::assign(".dptime", (proc.time() - get(".ptime", pos = "CheckExEnv")), pos = "CheckExEnv")
base::cat("electrode_burst_duration", base::get(".format_ptime", pos = 'CheckExEnv')(get(".dptime", pos = "CheckExEnv")), "\n", file=base::get(".ExTimings", pos = 'CheckExEnv'), append=TRUE, sep="\t")
cleanEx()
nameEx("electrode_mean_burst_ISI")
### * electrode_mean_burst_ISI

flush(stderr()); flush(stdout())

base::assign(".ptime", proc.time(), pos = "CheckExEnv")
### Name: electrode_mean_burst_ISI
### Title: Electrode Mean Burst ISI
### Aliases: electrode_mean_burst_ISI

### ** Examples

output_MEA_data <- electrode_mean_burst_ISI(data = input_MEA_data, 0, 30, recording_identifier = "burst_recording_1")



base::assign(".dptime", (proc.time() - get(".ptime", pos = "CheckExEnv")), pos = "CheckExEnv")
base::cat("electrode_mean_burst_ISI", base::get(".format_ptime", pos = 'CheckExEnv')(get(".dptime", pos = "CheckExEnv")), "\n", file=base::get(".ExTimings", pos = 'CheckExEnv'), append=TRUE, sep="\t")
cleanEx()
nameEx("electrode_number_of_bursts")
### * electrode_number_of_bursts

flush(stderr()); flush(stdout())

base::assign(".ptime", proc.time(), pos = "CheckExEnv")
### Name: electrode_number_of_bursts
### Title: Electrode Number of Bursts
### Aliases: electrode_number_of_bursts

### ** Examples

output_MEA_data <- electrode_number_of_bursts(data = input_MEA_data, 0, 30, recording_identifier = "burst_recording_1")



base::assign(".dptime", (proc.time() - get(".ptime", pos = "CheckExEnv")), pos = "CheckExEnv")
base::cat("electrode_number_of_bursts", base::get(".format_ptime", pos = 'CheckExEnv')(get(".dptime", pos = "CheckExEnv")), "\n", file=base::get(".ExTimings", pos = 'CheckExEnv'), append=TRUE, sep="\t")
cleanEx()
nameEx("electrode_spikes_per_burst")
### * electrode_spikes_per_burst

flush(stderr()); flush(stdout())

base::assign(".ptime", proc.time(), pos = "CheckExEnv")
### Name: electrode_spikes_per_burst
### Title: Electrode Spikes per Burst
### Aliases: electrode_spikes_per_burst

### ** Examples

output_MEA_data <- electrode_spikes_per_burst(data = input_MEA_data, 0, 30, recording_identifier = "burst_recording_1")



base::assign(".dptime", (proc.time() - get(".ptime", pos = "CheckExEnv")), pos = "CheckExEnv")
base::cat("electrode_spikes_per_burst", base::get(".format_ptime", pos = 'CheckExEnv')(get(".dptime", pos = "CheckExEnv")), "\n", file=base::get(".ExTimings", pos = 'CheckExEnv'), append=TRUE, sep="\t")
cleanEx()
nameEx("single_electrode_barchart")
### * single_electrode_barchart

flush(stderr()); flush(stdout())

base::assign(".ptime", proc.time(), pos = "CheckExEnv")
### Name: single_electrode_barchart
### Title: Single Electrode Bar chart
### Aliases: single_electrode_barchart

### ** Examples

single_electrode_barchart(data = input_electrode_barchart, electrode_parameter = "burst_duration", electrode_filter = "A1_", statistic = se)
single_electrode_barchart(data = input_electrode_barchart, electrode_parameter = "spikes_per_burst", electrode_filter = "A1_", statistic = se)
single_electrode_barchart(data = input_electrode_barchart, electrode_parameter = "mean_burst_ISI", electrode_filter = "A1_", statistic = se)
single_electrode_barchart(data = input_electrode_barchart, electrode_parameter = "number_of_bursts", electrode_filter = "A1_")



base::assign(".dptime", (proc.time() - get(".ptime", pos = "CheckExEnv")), pos = "CheckExEnv")
base::cat("single_electrode_barchart", base::get(".format_ptime", pos = 'CheckExEnv')(get(".dptime", pos = "CheckExEnv")), "\n", file=base::get(".ExTimings", pos = 'CheckExEnv'), append=TRUE, sep="\t")
cleanEx()
nameEx("well_barchart")
### * well_barchart

flush(stderr()); flush(stdout())

base::assign(".ptime", proc.time(), pos = "CheckExEnv")
### Name: well_barchart
### Title: Well Bar chart
### Aliases: well_barchart

### ** Examples

well_barchart(data = input_well_barchart, well_parameter = "burst_duration", well_filter = "A1|A2|A3|A4", statistic = se)
well_barchart(data = input_well_barchart, well_parameter = "spikes_per_burst", well_filter = "A1|A2|A3|A4", statistic = se)
well_barchart(data = input_well_barchart, well_parameter = "mean_burst_ISI", well_filter = "A1|A2|A3|A4", statistic = se)
well_barchart(data = input_well_barchart, well_parameter = "number_of_bursts", well_filter = "A1|A2|A3|A4", statistic = se)



base::assign(".dptime", (proc.time() - get(".ptime", pos = "CheckExEnv")), pos = "CheckExEnv")
base::cat("well_barchart", base::get(".format_ptime", pos = 'CheckExEnv')(get(".dptime", pos = "CheckExEnv")), "\n", file=base::get(".ExTimings", pos = 'CheckExEnv'), append=TRUE, sep="\t")
cleanEx()
nameEx("well_burst_duration")
### * well_burst_duration

flush(stderr()); flush(stdout())

base::assign(".ptime", proc.time(), pos = "CheckExEnv")
### Name: well_burst_duration
### Title: Well Burst Duration
### Aliases: well_burst_duration

### ** Examples

output_MEA_data <- well_burst_duration(data = input_MEA_data, 0, 30, recording_identifier = "burst_recording_1")



base::assign(".dptime", (proc.time() - get(".ptime", pos = "CheckExEnv")), pos = "CheckExEnv")
base::cat("well_burst_duration", base::get(".format_ptime", pos = 'CheckExEnv')(get(".dptime", pos = "CheckExEnv")), "\n", file=base::get(".ExTimings", pos = 'CheckExEnv'), append=TRUE, sep="\t")
cleanEx()
nameEx("well_mean_burst_ISI")
### * well_mean_burst_ISI

flush(stderr()); flush(stdout())

base::assign(".ptime", proc.time(), pos = "CheckExEnv")
### Name: well_mean_burst_ISI
### Title: Well Mean Burst ISI
### Aliases: well_mean_burst_ISI

### ** Examples

output_MEA_data <- well_mean_burst_ISI(data = input_MEA_data, 0, 30, recording_identifier = "burst_recording_1")



base::assign(".dptime", (proc.time() - get(".ptime", pos = "CheckExEnv")), pos = "CheckExEnv")
base::cat("well_mean_burst_ISI", base::get(".format_ptime", pos = 'CheckExEnv')(get(".dptime", pos = "CheckExEnv")), "\n", file=base::get(".ExTimings", pos = 'CheckExEnv'), append=TRUE, sep="\t")
cleanEx()
nameEx("well_number_of_bursts")
### * well_number_of_bursts

flush(stderr()); flush(stdout())

base::assign(".ptime", proc.time(), pos = "CheckExEnv")
### Name: well_number_of_bursts
### Title: Well Number of Bursts
### Aliases: well_number_of_bursts

### ** Examples

output_MEA_data <- well_number_of_bursts(data = input_MEA_data, 0, 30, recording_identifier = "burst_recording_1")



base::assign(".dptime", (proc.time() - get(".ptime", pos = "CheckExEnv")), pos = "CheckExEnv")
base::cat("well_number_of_bursts", base::get(".format_ptime", pos = 'CheckExEnv')(get(".dptime", pos = "CheckExEnv")), "\n", file=base::get(".ExTimings", pos = 'CheckExEnv'), append=TRUE, sep="\t")
cleanEx()
nameEx("well_spikes_per_burst")
### * well_spikes_per_burst

flush(stderr()); flush(stdout())

base::assign(".ptime", proc.time(), pos = "CheckExEnv")
### Name: well_spikes_per_burst
### Title: Well Spikes per Burst
### Aliases: well_spikes_per_burst

### ** Examples

output_MEA_data <- well_spikes_per_burst(data = input_MEA_data, 0, 30, recording_identifier = "burst_recording_1")



base::assign(".dptime", (proc.time() - get(".ptime", pos = "CheckExEnv")), pos = "CheckExEnv")
base::cat("well_spikes_per_burst", base::get(".format_ptime", pos = 'CheckExEnv')(get(".dptime", pos = "CheckExEnv")), "\n", file=base::get(".ExTimings", pos = 'CheckExEnv'), append=TRUE, sep="\t")
### * <FOOTER>
###
cleanEx()
options(digits = 7L)
base::cat("Time elapsed: ", proc.time() - base::get("ptime", pos = 'CheckExEnv'),"\n")
grDevices::dev.off()
###
### Local variables: ***
### mode: outline-minor ***
### outline-regexp: "\\(> \\)?### [*]+" ***
### End: ***
quit('no')
