library(testthat)
library(sptidy)
library(tidyverse)

test_check("sptidy")


kmeans_helper <- function(){
  kmeans_test_tib <- tibble('x' = c(1,1,1,1,3,3,3,3),
                         'y' = c(1,3,7,9,1,3,7,9))
  return(kmeans_test_tib)
}
