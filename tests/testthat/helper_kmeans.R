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