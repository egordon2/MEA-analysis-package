% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/single_electrode_barchart.R
\name{single_electrode_barchart}
\alias{single_electrode_barchart}
\title{Single Electrode Bar chart}
\usage{
single_electrode_barchart(
  data = output_table,
  electrode_parameter,
  electrode_filter =
    "A1_|A2_|A3_|A4_|A5_|A6_|B1_|B2_|B3_|B4_|B5_|B6_|C1_\\n                                  |C2_|C3_|C4_|C5_|C6_|D1_|D2_|D3_|D4_|D5_|D6_",
  statistic = se
)
}
\arguments{
\item{data}{Dataset containing electrode burst data and calculated MEA parameter.
Use create_electrode_dataset and electrode parameter functions to preprocess data before use in this function (i.e., electrode_burst_duration, electrode_mean_burst_ISI, electrode_number_of_bursts, electrode_spikes_per_burst).}

\item{electrode_parameter}{Include "number_of_bursts"/ "burst_duration"/ "spikes_per_burst"/ "mean_burst_ISI" to determine the parameter visualised in the barchart.}

\item{electrode_filter}{Argument can be used to filter for single electrodes to include in the barchart.}

\item{statistic}{Include "se" or "sd" to determine whether bar chart error bars represent the standard error or standard deviation of the mean.}
}
\value{
A bar chart of calculated MEA parameters by single electrode for a given time interval and recording.
}
\description{
Function creates a bar chart of calculated MEA parameters by single electrode for a given time interval and recording.
}
\examples{
p <- single_electrode_barchart(data = input_electrode_barchart,
                          electrode_parameter = "burst_duration",
                          electrode_filter = "A1_",
                          statistic = se)

p <- single_electrode_barchart(data = input_electrode_barchart,
                          electrode_parameter = "spikes_per_burst",
                          electrode_filter = "A1_",
                          statistic = se)

p <- single_electrode_barchart(data = input_electrode_barchart,
                          electrode_parameter = "mean_burst_ISI",
                          electrode_filter = "A1_",
                          statistic = se)

p <- single_electrode_barchart(data = input_electrode_barchart,
                          electrode_parameter = "number_of_bursts",
                          electrode_filter = "A1_")
}
