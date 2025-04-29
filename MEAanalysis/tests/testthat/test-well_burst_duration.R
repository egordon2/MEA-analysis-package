


test_that("well_burst_duration output is a datatable", {
  # Load the dataset
  dataset <- well_burst_duration(data = input_MEA_data,
                                                         time_lower_bound = 0,
                                                         time_upper_bound = 30,
                                                         recording_identifier = "burst_recording_1")

  expect_equal(data.table::is.data.table(dataset), TRUE)
})
