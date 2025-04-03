
#' Create Electrode Data Set
#'
#' @description This function reads in, filters, and reformats electrode burst csv files produced by the axis navigator tool
#' (Axion Biosystems) for use in analysis. This function filters the data to only contain information relating to single electrodes
#' and burst characteristics. It also adds a 'Recording_identifier' column to enable other MEAanalysis functions to calculate
#' burst parameters for a specific recording, as well as a column to identify the well a burst was recorded in.
#'
#' @param data_path Include path to electrode burst dataset csv or excel file produced by the axis navigator tool. This path should be written within quotation marks and with respect to the current working directory.
#' @param recording_identifier Include a unique identifier for the MEA recording being loaded. This identifier will be added to the 'Recording_identifier' column and be used by other MEAanalysis functions to filter the data and calculate burst parameters.
#'
#' @return A reformatted and filtered electrode burst list for use in analysis.
#' @importFrom data.table setcolorder setDT
#' @importFrom readr read_csv
#' @importFrom stringr str_detect
#' @export
#'
#' @examples output_electrode_burst <- create_electrode_dataset(
#'                                     data_path = system.file("extdata", "input_electrode_burst.csv",
#'                                                             package = "MEAanalysis"),
#'                                     recording_identifier = "burst_recording_1")

create_electrode_dataset <- function(data_path, recording_identifier) {

  # Declare variables
  data_1 <- NULL
  data_2 <- NULL
  data_3 <- NULL

  # read in electrode_burst_list file produced by axis navigator software (update data_path accordingly)
  if (str_detect(data_path, ".csv")) {
    input_data <- read_csv(file = data_path, col_select = 3:6, show_col_types = FALSE)
  } else if (str_detect(data_path, ".xlsx")) {
    input_data <- read_xlsx(path = data_path) %>%
      select(3:6)
  } else if (str_detect(data_path, ".xls")) {
    input_data <- read_xls(path = data_path) %>%
      select(3:6)
  } else {
    stop("Unsupported file format. Please provide a CSV or Excel file.")
  }

  # convert data frame to data table format for efficiency
  setDT(input_data)

  # filter to only include data relevant to electrode recordings
  data_1 <- input_data[str_detect(Electrode, "A1_|A2_|A3_|A4_|A5_|A6_|B1_|B2_|B3_|B4_|B5_|B6_|C1_|C2_|C3_|C4_|C5_|C6_|D1_|D2_|D3_|D4_|D5_|D6_"), ]

  # reassign column name and class
  setcolorder(data_1, c("Electrode", "Time (s)", "Size (spikes)", "Duration (s)"))
  colnames(data_1)[2:4] <- c("Time_s", "Size_spikes", "Duration_s")

  # Create a function to convert non-numeric values to NA
  convert_to_numeric <- function(x) {
    as.numeric(as.character(x), na.rm = TRUE)
  }

  # Apply the conversion function to selected columns
  data_1[, (2:4) := lapply(.SD, convert_to_numeric), .SDcols = 2:4]

  # sort and group data by electrode
  # add extra columns to identify well and recording
  data_1 <- data_1[order(data_1$Electrode)]
  data_2 <- data_1[, Recording_identifier := recording_identifier , by = Electrode]
  data_3 <- data_2[, well := str_sub(Electrode, start = 1L, end = 2L)]

  return(data_3)

}
