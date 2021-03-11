

test_that("tidy_kmeans works as expected and fails gracefully", {
  # Fitting a kmeans model on our helper data, comparing it to our hand-calculated output
  expect_true(dplyr::all_equal(sptidy::tidy_kmeans(stats::kmeans(helper_kmeans_data(),
                                                                 centers = 2, helper_kmeans_data())),
                               helper_kmeans_tidy_out()))
  # Checking that we fail gracefully when given a different class model
  expect_error(sptidy::tidy_kmeans(stats::lm(x ~ y, helper_kmeans_data())))
  # Checking that we get an error when we don't supply the training data
  expect_error(sptidy::tidy_kmeans(stats::kmeans(helper_kmeans_data(), centers = 2, tibble::tibble())))
})

