

test_that("electrode_mean_burst_ISI output is a datatable", {
  # Load the dataset
  dataset <- electrode_mean_burst_ISI(data = input_MEA_data,
                                                         time_lower_bound = 0,
                                                         time_upper_bound = 30,
                                                         recording_identifier = "burst_recording_1")

  expect_equal(data.table::is.data.table(dataset), TRUE)
})


