
test_that("create_synchrony_dataset output is a data table", {
  # Load dataset
  dataset <- create_synchrony_dataset(data_path = "data/input_neuralMetric.csv", heatmap_condition = "Baseline")
  expect_equal(is.data.table(dataset), TRUE)
})


test_that("create_synchrony dataset column classes are correct",{

  # Load dataset
  dataset <- create_synchrony_dataset(data_path = "data/input_neuralMetric.csv", heatmap_condition = "Baseline")

  # Define expected column names and classes
  expected_columns <- data.table(
    Well = character(),
    "synchrony_index: Baseline" = numeric()
  )
  expected_names <- colnames(expected_columns)
  expected_classes <- sapply(expected_columns, class)

  # Run checks
  expect_equal(colnames(dataset), expected_names, info = "Column names should match the expected names")
  expect_equal(sapply(dataset, class), expected_classes, info = "Column classes should match the expected classes")


})
