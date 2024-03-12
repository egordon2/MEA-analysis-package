

#' Create Synchrony Data Set
#'
#' @description Function reads in neural metric output dataset and reformats for use in synchrony index analysis
#'
#' @param name data_path, heatmap_condition
#'
#' @return Reformatted and filtered neural metric dataset for use in synchrony analysis
#' @export
#'
#' @examples
#' baseline_data <- create_synchrony_dataset(data_path = "C:/Users/Emily Gordon/baseline_neuralMetrics.csv", heatmap_condition = "Baseline")


create_synchrony_dataset <- function(data_path, heatmap_condition) {

  # read in electrode_burst_list file produced by axis navigator software (update data_path accordingly)
  input_data <- read_csv(file = data_path, skip = 29, col_names = FALSE, show_col_types = FALSE)

  # convert data frame to data table format for efficiency
  setDT(input_data)

  # extract well and synchrony index data
  data_1 <- input_data[str_detect(X1, "Well Averages|Synchrony Index"), ]

  # transpose data table
  data_2 <- transpose(data_1) %>%
    row_to_names(row_number = 1)

  colnames(data_2)[1] <- c("Well")

  data_2 <- data_2[str_detect(Well, "A1|A2|A3|A4|A5|A6|B1|B2|B3|B4|B5|B6|C1|C2|C3|C4|C5|C6|D1|D2|D3|D4|D5|D6"), ]
  data_2[, 2] <- sapply(data_2[, 2], as.numeric)

  # include heatmap_condition in synchrony index column name
  names(data_2)[names(data_2) == "Synchrony Index"] <- paste0("synchrony_index: ", heatmap_condition)

  return(data_2)


}




