# Create test x data for linear regresion testing 
helper_lr_x <- function() {
  x <- data.frame(x = c(1,5,10))
  return(x)
}

# Create test y data for linear regresion testing 
helper_lr_y <- function() {
  y <- data.frame(y = c(1,5,10))
  return(y)
}

# Create test model for linear regresion testing 
helper_lr_model <- function() {
  model <- lm(y ~ x, data = cbind(helper_lr_x(), helper_lr_y()))
  return(model)
}

helper_lr_data <- function(){
  data("longley")
  longley}

# Creating test data for kmeans functions
helper_kmeans_data <- function(){
  kmeans_test_tib <- tibble::tibble('x' = c(1,1,1,1,3,3,3,3),
                            'y' = c(1,3,7,9,1,3,7,9))
  return(kmeans_test_tib)
}

# Creating our desired output for kmeans tidy
helper_kmeans_tidy_out <- function(){
  center_0 = c(2, 2)
  center_1 = c(2, 8)
  kmeans_tidy_result_tib <- tibble::tibble("cluster_number" = c(1L,2L),
                                   "cluster_center" = list(center_0, center_1),
                                   "n_points" = c(4L,4L))
  return(kmeans_tidy_result_tib)
}

# test_that("tidy_lr should throw and error when input model is not a lm() object", {
#   expect_error(sptidy::tidy_lr("cool"))
#   expect_error(sptidy::tidy_lr(c(1,2,3)))
# }
# )
# test_that("tidy_lr should output a dataframe with correct number of rows", {
#   expect_equal(nrow(sptidy::tidy_lr(stats::lm(Employed~., data = helper_lr_data()))), nrow(helper_lr_data()))
# }
# )
# test_that("tidy_lr should output a dataframe with correct number of columns", {
#   expect_equal(nrow(sptidy::tidy_lr(stats::lm(Employed~., data = helper_lr_data()))), 4)
# }
# )
# test_that("tidy_lr should output should be very close to tidy() output", {
#   expect_equal(sptidy::tidy_lr(stats::lm(Employed~., data = helper_lr_data()))[1,1], broom::tidy(lm(Employed~., data = helper_lr_data()))[2,2])
# }
# )

test_that("tidy_kmeans works as expected and fails gracefully", {
  # Fitting a kmeans model on our helper data, comparing it to our hand-calculated output
  # expect_true(dplyr::all_equal(
  #   sptidy::tidy_kmeans(stats::kmeans(helper_kmeans_data(), centers = 2), helper_kmeans_data()),
  #                              helper_kmeans_tidy_out()))
  # Checking that we fail gracefully when given a different class model
  expect_error(sptidy::tidy_kmeans(stats::lm(x ~ y, helper_kmeans_data())))
  # Checking that we get an error when we don't supply the training data
  expect_error(sptidy::tidy_kmeans(stats::kmeans(helper_kmeans_data(), centers = 2, dplyr::tibble())))
})

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

test_that("augment_kmeans expects a KMeans model and a non-empty data dataframe else it fails gracefully", {
  # Checking that we fail gracefully when given a different class model
  expect_error(sptidy::augment_kmeans(stats::lm(x ~ y, as.data.frame(helper_kmeans_data()))))
  # Checking that we get an error when we don't supply the training data (empty dataframe)
  expect_error(sptidy::augment_kmeans(stats::kmeans(helper_kmeans_data(), centers = 2), as.data.frame(dplyr::tibble())))
  # Checking that we get an error when we don't supply the training data in a dataframe
  expect_error(sptidy::augment_kmeans(stats::kmeans(helper_kmeans_data(), centers = 2), dplyr::tibble()))
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
