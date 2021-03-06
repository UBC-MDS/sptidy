# test fcn

#' Tidy Output for tidymodels Linear Regression
#'
#' Create a tidy output for tidymodels linear_reg() object. The output dataframe
#' would have n+1 rows, where n is number of features and 3 columns describing feature
#' names, coefficients/intercept and p-values
#'
#' @params model _lm
#' @params X data.frame
#'
#' @return output data.frame
#' @export
#'
#' @examples
#' library(tidyverse)
#' library(tidymodels)
#' data("longley")
#' my_lr <- linear_reg() %>%
#' set_engine("lm") %>%
#' fit(Employed~., data = longley)
#' tidy_lr(my_lr,X)
tidy_lr <- function(model, X) {
}

#' Tidy Output for KMeans Clustering
#'
#' Creates a tidy dataframe containing information at the cluster level for a
#' kmeans clustering algorithm
#'
#' @param model A `kmeans` object created by [stats::kmeans()].
#' @param X data.frame of the original data set.
#'@return data.frame of infomration associated with each cluster
#' @export
#'
#' @examples
#' library(tidyverse)
#' library(tidymodels)
#' library(stats)
#' data(iris)
#' data <- iris %>% select(-Species)
#' kclust <- kmeans(data, centers = 3)
#' tidy_kmeans(kclust, data)
tidy_kmeans <- function(X, Model) {

}

#' Title
#'
#' @return
#' @export
#'
#' @examples
augment_lr <- function() {
}

#' Cluster Assignments of the Original Data Set
#'
#' @param model A `kmeans` object created by [stats::kmeans()].
#' @param X data.frame of the original data set.
#' @return data.frame of the original data and their cluster assignment.
#' @export
#'
#' @examples
#' library(tidyverse)
#' library(tidymodels)
#' library(broom)
#' library(stats)
#' data(iris)
#' data <- iris %>% select(-Species)
#' kclust <- kmeans(data, centers = 3)
#' augment_kmeans(kclust, data)
augment_kmeans <- function(Model, X) {

}
