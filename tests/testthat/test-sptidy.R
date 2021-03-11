helper_kmeans_data <- function(){
  kmeans_test_tib <- tibble('x' = c(1,1,1,1,3,3,3,3),
                            'y' = c(1,3,7,9,1,3,7,9))
  return(kmeans_test_tib)
}

helper_kmeans_tidy_out <- function(){
  center_0 = tibble('x' = 2, 'y' = 2)
  center_1 = tibble('x' = 2, 'y' = 8)
  kmeans_tidy_result_tib <- tibble("cluster_number" = c(0,1),
                                   "cluster_center" = c(center_0, center_1),
                                   "n_points" = c(4,4))
  return(kmeans_tidy_result_tib)
}


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

