
#' MEA_heatmap
#'
#' @description Function creates a heatmap of the synchrony index for each well grouped by heatmap condition.
#'
#' @param data Dataset containing well average synchrony index data.
#' @param x_axis_title Include title for heatmap x axis. Default is "Experimental Condition"
#' @param well_filter Argument can be used to filter for specific MEA wells to include in the heatmap.
#'
#' @return A heatmap of the synchrony index for each well grouped by heatmap condition.
#' @importFrom data.table melt
#' @importFrom dplyr rename %>%
#' @importFrom ggplot2 ggplot geom_tile scale_fill_gradient labs aes theme element_text
#' @importFrom stringr str_detect
#' @export
#'
#' @examples
#' p <- MEA_heatmap(data = input_heatmap_data,
#'             x_axis_title = "Experimental Condition",
#'             well_filter = "A1|A2|A3|A4|A5|A6|B1|B2|B3|B4|B5|B6|C1|C2|C3|C4|C5|C6|D1|D2|D3|D4|D5|D6")


MEA_heatmap <- function(data,
                        x_axis_title = "Experimental Condition",
                        well_filter = "A1|A2|A3|A4|A5|A6|B1|B2|B3|B4|B5|B6|C1|C2|C3|C4|C5|C6|D1|D2|D3|D4|D5|D6") {

  # Declare variables
  data_1 <- NULL
  data_2 <- NULL

  # remove synchrony index from column names so not included in axis labels
  colnames(data) = gsub("synchrony_index: ", "", colnames(data))

  # filter data for specific wells
  data_1 <- data[str_detect(Well, well_filter), ]

  # reformat datatable for use in heatmap
  data_2 <- melt(data_1, id = "Well") %>%
    rename(experimental_condition = variable,
           synchrony_index = value)
  data_2[, 1] <- sapply(data_2[, 1], as.factor)

  # create ggplot heatmap
  p <- data_2 %>%
    ggplot(aes(x = experimental_condition, y = Well, fill = synchrony_index)) +
    geom_tile() +
    scale_fill_gradient(low = "white", high = "red") +
    labs(fill = "Synchrony Index", x = x_axis_title, y = "Well") +
    theme(axis.text.x = element_text(angle = 90, vjust = 0.5, hjust=1))

  return(p)

}


