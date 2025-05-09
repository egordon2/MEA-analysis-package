
test_that("create_electrode_dataset output is a datatable", {
  # Load the dataset
  dataset <- create_electrode_dataset(data_path = system.file("extdata", "input_electrode_burst.csv", package = "MEAanalysis"), recording_identifier = "burst_recording_1")

  expect_equal(data.table::is.data.table(dataset), TRUE)
})


test_that("create_electrode_dataset column classes are correct", {
  # Load the dataset
  dataset <- create_electrode_dataset(data_path = system.file("extdata", "input_electrode_burst.csv", package = "MEAanalysis"), recording_identifier = "burst_recording_1")

  # Define expected column classes
  expected_columns <- data.table::data.table(
    Electrode = character(),
    Time_s = numeric(),
    Size_spikes = numeric(),
    Duration_s = numeric(),
    Recording_identifier= character(),
    well = character())
  expected_classes <- sapply(expected_columns, class)

  # Check that the column classes match the expected classes
  expect_equal(sapply(dataset, class), expected_classes,
               info = "Column classes should match the expected classes")
})

test_that("create_electrode_dataset output does not contain missing values", {
  # Load the dataset
  dataset <- create_electrode_dataset(data_path = system.file("extdata", "input_electrode_burst.csv", package = "MEAanalysis"), recording_identifier = "burst_recording_1")

  expect_equal(anyNA(dataset), FALSE)
})


