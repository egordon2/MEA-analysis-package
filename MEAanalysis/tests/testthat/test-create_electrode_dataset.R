
test_that("create_electrode_dataset output is a datatable", {
  # Load the dataset
  dataset <- create_electrode_dataset(data_path = "data/input_electrode_burst.csv", recording_identifier = "burst_recording_1")

  expect_equal(is.data.table(dataset), TRUE)
})

test_that("create_electrode_dataset column names are correct", {
  # Load the dataset
  dataset <- create_electrode_dataset(data_path = "data/input_electrode_burst.csv", recording_identifier = "burst_recording_1")

  # Define expected column names
  expected_names <- c("Electrode", "Time_s", "Size_spikes", "Duration_s", "Recording_identifier", "well")

  # Assert that the column names match the expected names
  expect_equal(colnames(dataset), expected_names,
               info = "Column names should match the expected names")

})

test_that("create_electrode_dataset column classes are correct", {
  # Load the dataset
  dataset <- create_electrode_dataset(data_path = "data/input_electrode_burst.csv", recording_identifier = "burst_recording_1")

  # Define expected column classes
  expected_columns <- data.table(
    Electrode = character(),
    Time_s = numeric(),
    Size_spikes = numeric(),
    Duration_s = numeric(),
    Recording_identifier= character(),
    well = character())
  expected_classes <- sapply(expected_columns, class)

  # Assert that the column classes match the expected classes
  expect_equal(sapply(dataset, class), expected_classes,
               info = "Column classes should match the expected classes")
})



