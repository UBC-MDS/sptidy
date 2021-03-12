# helper_kmeans_data <- function(){
#   kmeans_test_tib <- tibble('x' = c(1,1,1,1,3,3,3,3),
#                             'y' = c(1,3,7,9,1,3,7,9))
#   return(kmeans_test_tib)
# }

# helper_kmeans_tidy_out <- function(){
#   center_0 = tibble('x' = 2, 'y' = 2)
#   center_1 = tibble('x' = 2, 'y' = 8)
#   kmeans_tidy_result_tib <- tibble("cluster_number" = c(0,1),
#                                    "cluster_center" = c(center_0, center_1),
#                                    "n_points" = c(4,4))
#   return(kmeans_tidy_result_tib)
# }


# test_that("tidy_kmeans works as expected and fails gracefully", {
#   # Fitting a kmeans model on our helper data, comparing it to our hand-calculated output
#   expect_true(dplyr::all_equal(sptidy::tidy_kmeans(stats::kmeans(helper_kmeans_data(),
#                                                                  centers = 2, helper_kmeans_data())),
#                                helper_kmeans_tidy_out()))
#   # Checking that we fail gracefully when given a different class model
#   expect_error(sptidy::tidy_kmeans(stats::lm(x ~ y, helper_kmeans_data())))
#   # Checking that we get an error when we don't supply the training data
#   expect_error(sptidy::tidy_kmeans(stats::kmeans(helper_kmeans_data(), centers = 2, tibble::tibble())))
# })

helper_lr_x <- function() {
  x <- data.frame(x = c(1,5,10))
  return(x)
}

helper_lr_y <- function() {
  y <- data.frame(y = c(1,5,10))
  return(y)
}

helper_lr_model <- function() {
  model <- lm(y ~ x, data = cbind(helper_lr_x(), helper_lr_y()))
  return(model)
}

test_that("augment_lr returns the correct dataframe type and shape", {
  # Number of rows across x, y and output should be the same
  expect_equal(nrow(helper_lr_x()), nrow(helper_lr_y()), nrow(augment_lr(helper_lr_model(), helper_lr_x(), helper_lr_y())))
  # Number of output columns should be x + y + 2
  expect_equal(ncol(helper_lr_x()) + ncol(helper_lr_y()) + 2 , ncol(augment_lr(helper_lr_model(), helper_lr_x(), helper_lr_y())))
  # Return object is a dataframe
  expect_true(is.data.frame(augment_lr(helper_lr_model(), helper_lr_x(), helper_lr_y())))

})

test_that("augment_lr returns the correct values", {
  # Predictions and residuals sum to y
  expect_true(sum(augment_lr(helper_lr_model(), helper_lr_x(), helper_lr_y())$predictions,augment_lr(helper_lr_model(), helper_lr_x(), helper_lr_y())$residuals) == sum(helper_lr_y()))
  # Check linear regression prediction by hand
  expect_true(near(augment_lr(helper_lr_model(), helper_lr_x(), helper_lr_y())$predictions[1], 1))
  # Check linear regression residual by hand
  expect_true(near(augment_lr(helper_lr_model(), helper_lr_x(), helper_lr_y())$residuals[1], 0))

})