

test_that("tidy_kmeans works as expected and fails gracefully", {
  # Fitting a kmeans model on our helper data, comparing it to our hand-calculated output
  expect_true(dplyr::all_equal(
    sptidy::tidy_kmeans(stats::kmeans(helper_kmeans_data(), centers = 2), helper_kmeans_data()),
                               helper_kmeans_tidy_out()))
  # Checking that we fail gracefully when given a different class model
  expect_error(sptidy::tidy_kmeans(stats::lm(x ~ y, helper_kmeans_data())))
  # Checking that we get an error when we don't supply the training data
  expect_error(sptidy::tidy_kmeans(stats::kmeans(helper_kmeans_data(), centers = 2, tibble::tibble())))
})

test_that("augment_kmeans expects a KMeans model and a non-empty data dataframe else it fails gracefully", {
  # Checking that we fail gracefully when given a different class model
  expect_error(sptidy::augment_kmeans(stats::lm(x ~ y, as.data.frame(helper_kmeans_data()))))
  # Checking that we get an error when we don't supply the training data (empty dataframe)
  expect_error(sptidy::augment_kmeans(stats::kmeans(helper_kmeans_data(), centers = 2), as.data.frame(tibble::tibble())))
  # Checking that we get an error when we don't supply the training data in a dataframe
  expect_error(sptidy::augment_kmeans(stats::kmeans(helper_kmeans_data(), centers = 2), tibble::tibble()))
})


test_that("augment_kmeans returns the correct dataframe type and shape", {
  # Number of rows across X, and output should be the same
  expect_equal(nrow(as.data.frame(helper_kmeans_data())),
               nrow(sptidy::augment_kmeans(stats::kmeans(helper_kmeans_data(), centers = 2),
                                           as.data.frame(helper_kmeans_data()))))
  # Number of output columns should be x + 1
  expect_equal(ncol(as.data.frame(helper_kmeans_data())) + 1,
               ncol(sptidy::augment_kmeans(stats::kmeans(helper_kmeans_data(), centers = 2),
                                           as.data.frame(helper_kmeans_data()))))
  # Return object is a dataframe
  expect_true(is.data.frame(sptidy::augment_kmeans(stats::kmeans(helper_kmeans_data(), centers = 2),
                                                   as.data.frame(helper_kmeans_data()))))
})
