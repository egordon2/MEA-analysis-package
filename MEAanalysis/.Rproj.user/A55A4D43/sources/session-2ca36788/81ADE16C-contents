
test_that("create_synchrony_dataset output is a data table", {
  # Load dataset
  dataset <- create_synchrony_dataset(data_path = system.file("extdata", "input_neuralMetric.csv", package = "MEAanalysis"), heatmap_condition = "Baseline")
  expect_equal(is.data.table(dataset), TRUE)
})


test_that("create_synchrony dataset column classes are correct",{

  # Load dataset
  dataset <- create_synchrony_dataset(data_path = system.file("extdata", "input_neuralMetric.csv", package = "MEAanalysis"), heatmap_condition = "Baseline")

  # Define expected column names and classes
  expected_columns <- data.table(
    Well = character(),
    "synchrony_index: Baseline" = numeric()
  )
  expected_classes <- sapply(expected_columns, class)
  expect_equal(sapply(dataset, class), expected_classes, info = "Column classes should match the expected classes")

})


test_that("create_synchrony_dataset output does not contain missing values", {

  # Load dataset
  dataset <- create_synchrony_dataset(data_path = system.file("extdata", "input_neuralMetric.csv", package = "MEAanalysis"), heatmap_condition = "Baseline")
  expect_equal(anyNA(dataset), FALSE)

})

