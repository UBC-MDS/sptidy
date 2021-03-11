test_that("multiplication works", {
  expect_equal(2 * 2, 4)
})

kmeans_helper <- function(){
  kmeans_test_tib <- tibble('x' = c(1,1,1,1,3,3,3,3),
                            'y' = c(1,3,7,9,1,3,7,9))
  return(kmeans_test_tib)
}
