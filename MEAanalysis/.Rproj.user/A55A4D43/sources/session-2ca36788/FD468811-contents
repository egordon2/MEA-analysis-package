


test_that("well_number_of_bursts output is a datatable", {
  # Load the dataset
  dataset <- well_number_of_bursts(data = input_MEA_data,
                                 time_lower_bound = 0,
                                 time_upper_bound = 30,
                                 recording_identifier = "burst_recording_1")

  expect_equal(is.data.table(dataset), TRUE)
})


