
#' Heatmap
#'
#' @description Function creates a heatmap of the synchrony index for each well grouped by heatmap condition
#'
#' @param name data, well_filter
#'
#' @return heatmap of the synchrony index for each well grouped by heatmap condition
#'
#' @export
#'
#' @examples
#' heatmap(data = heatmap_data, well_filter = "A1|A2|A3|A4|A5|A6|B1|B2|B3|B4|B5|B6|C1|C2|C3|C4|C5|C6|D1|D2|D3|D4|D5|D6")


heatmap <- function(data,
                    well_filter = "A1|A2|A3|A4|A5|A6|B1|B2|B3|B4|B5|B6|C1|C2|C3|C4|C5|C6|D1|D2|D3|D4|D5|D6") {

  # remove synchrony index from column names so not included in axis labels
  colnames(data) = gsub("synchrony_index: ", "", colnames(data))

  # filter data for specific wells
  data_1 <- data[str_detect(Well, well_filter), ]

  # reformat datatable for use in heatmap
  data_2 <- melt(data_1, id = "Well") %>%
    rename(experimental_condition = variable,
           synchrony_index = value)

  # create ggplot heatmap
  data_2 %>%
    ggplot(aes(x = experimental_condition, y = Well, fill = synchrony_index)) +
    geom_tile() +
    scale_fill_gradient(low = "white", high = "red") +
    labs(fill = "Synchrony Index", x = "Experimental Condition", y = "Well")

}
