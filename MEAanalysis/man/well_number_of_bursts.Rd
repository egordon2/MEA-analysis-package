% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/well_number_of_bursts.R
\name{well_number_of_bursts}
\alias{well_number_of_bursts}
\title{Well Number of Bursts}
\usage{
well_number_of_bursts(
  data = output_table,
  time_lower_bound = 0,
  time_upper_bound = Inf,
  recording_identifier
)
}
\arguments{
\item{data}{Electrode burst list dataset preprocessed using the create_electrode_dataset function.}

\item{time_lower_bound}{Define lower bound of time interval for which to calculate the MEA parameter (seconds).}

\item{time_upper_bound}{Define upper bound of time interval for which to calculate the MEA parameter (seconds).}

\item{recording_identifier}{Define recording for which to calculate the MEA parameter. Use recording_identifier defined in create_electrode_dataset function.}
}
\value{
An electrode burst list table with three additional columns (mean, SD and SEM number of bursts recorded for each well within the specified time interval and recording).
}
\description{
Function reads in electrode burst list data and creates new columns with the mean, SD, and SEM number of bursts recorded for each well (within the specified time interval and recording).
}
\examples{
output_MEA_data <- well_number_of_bursts(data = input_MEA_data,
                                         time_lower_bound = 0,
                                         time_upper_bound = 30,
                                         recording_identifier = "burst_recording_1")
}
