# Creating test data for kmeans functions
helper_kmeans_data <- function(){
  kmeans_test_tib <- tibble::tibble('x' = c(1,1,1,1,3,3,3,3),
                            'y' = c(1,3,7,9,1,3,7,9))
  return(kmeans_test_tib)
}

# Creating our desired output for kmeans tidy
helper_kmeans_tidy_out <- function(){
  center_0 = tibble::tibble('x' = 2, 'y' = 2)
  center_1 = tibble::tibble('x' = 2, 'y' = 8)
  kmeans_tidy_result_tib <- tibble::tibble("cluster_number" = c(1,2),
                                   "cluster_center" = list(center_0, center_1),
                                   "n_points" = c(4,4))
  return(kmeans_tidy_result_tib)
}
