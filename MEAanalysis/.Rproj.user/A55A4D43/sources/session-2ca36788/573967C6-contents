


test_that("electrode_spikes_per_burst output is a datatable", {
  # Load the dataset
  dataset <- electrode_spikes_per_burst(data = input_MEA_data,
                                                         time_lower_bound = 0,
                                                         time_upper_bound = 30,
                                                         recording_identifier = "burst_recording_1")

  expect_equal(is.data.table(dataset), TRUE)
})
