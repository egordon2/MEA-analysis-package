#' Create Synchrony Data Set
#'
#' @description This function reads in, filters, and reformats neural metric csv files produced by the axis navigator neural metric tool
#' (Axion Biosystems) for use in synchrony index analysis.
#'
#' @param data_path Include path to neural metric dataset csv or excel file produced by the axis navigator neural metric tool. This path should be written within quotation marks and with respect to the current working directory.
#' @param heatmap_condition Include a unique identifier for this neuralMetric dataset's experimental condition, this argument will be used by the MEA_heatmap function to group data.
#'
#' @return A reformatted and filtered neural metric dataset for use in synchrony index analysis.
#' @importFrom data.table setDT transpose
#' @importFrom janitor row_to_names
#' @importFrom readr read_csv
#' @importFrom readxl read_excel
#' @importFrom stringr str_detect
#' @export
#'
#' @examples output_neuralMetric <- create_synchrony_dataset(
#'                                  data_path = system.file("extdata", "input_neuralMetric.csv",
#'                                                           package = "MEAanalysis"),
#'                                  heatmap_condition = "SI_condition_1")

create_synchrony_dataset <- function(data_path, heatmap_condition) {

  # Declare variables
  input_data <- NULL
  data_1 <- NULL
  data_2 <- NULL

  # read in electrode_burst_list file produced by axis navigator software (update data_path accordingly)
  if (str_detect(data_path, ".csv")) {

    input_data <- read_csv(file = data_path, skip = 29, col_names = FALSE, show_col_types = FALSE)
    # convert data frame to data table format for efficiency
    setDT(input_data)
    # extract well and synchrony index data
    data_1 <- input_data[str_detect(X1, "Well Averages|Synchrony Index"), ]

  } else if (str_detect(data_path, ".xlsx")) {

    input_data <- read_excel(path = data_path, skip = 29, col_names = FALSE)
    # convert data frame to data table format for efficiency
    setDT(input_data)
    # extract well and synchrony index data
    data_1 <- input_data[str_detect(...1, "Well Averages|Synchrony Index"), ]

  } else if (str_detect(data_path, ".xls")) {

    input_data <- read_excel(path = data_path, skip = 29, col_names = FALSE)
    # convert data frame to data table format for efficiency
    setDT(input_data)
    # extract well and synchrony index data
    data_1 <- input_data[str_detect(...1, "Well Averages|Synchrony Index"), ]

  } else {
    stop("Unsupported file format. Please provide a CSV or Excel file.")
  }

  # transpose data table
  data_2 <- transpose(data_1)
  setDT(data_2)
  data_2 <- row_to_names(data_2, row_number = 1)
  colnames(data_2)[1] <- c("Well")

  data_2 <- data_2[str_detect(Well, "A1|A2|A3|A4|A5|A6|B1|B2|B3|B4|B5|B6|C1|C2|C3|C4|C5|C6|D1|D2|D3|D4|D5|D6"), ]
  data_2[, 2] <- sapply(data_2[, 2], as.numeric)

  # include heatmap_condition in synchrony index column name
  names(data_2)[names(data_2) == "Synchrony Index"] <- paste0("synchrony_index: ", heatmap_condition)

  return(data_2)


}




