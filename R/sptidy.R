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
#' @return tibble of infomration associated with each cluster
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
tidy_kmeans <- function(Model, X) {

  if (class(Model) != "kmeans") {
    stop("Model must be of class 'kmeans'")
  }

  # Getting the centroid locations as a df
  centers <- list(Model$centers)
  centers <- as.data.frame(centers[[1]])

  # Getting each unique cluster label
  cluster_labels <- tibble::tibble(cluster_number = unique(Model$cluster))
  cluster_labels <- dplyr::arrange(cluster_labels, (cluster_number))

  # Getting list of centroid coords
  cluster_center <- c()
  for (cluster in cluster_labels) {
    cluster_center[cluster] = centers[cluster]
  }

  # Getting counts for each label center
  tester <- tibble::tibble('label' = Model$cluster)
  n_points <- dplyr::summarise(dplyr::group_by(tester, label), n_points = dplyr::n())
  n_points <- dplyr::select(n_points, n_points)

  # Putting everything together
  tidy_output <- tibble::tibble(cluster_labels,
                      cluster_center,
                      n_points)
  return(tidy_output)
}

#' Augmented Output for Tidymodel's Linear Regression
#'
#' Adds two columns to the original data of the scikit learn's linear regression model. This includes predictions and residuals.
#'
#' @params model _lm
#' @params X data.frame
#'
#'
#' @return output data.frame
#' @export
#'
#' @examples
#' # Import libraries
#' library(tidyverse)
#' library(tidymodels)
#' # Load data
#' data("longley")
#' # Fit linear regression
#' my_lr <- linear_reg() %>%
#' set_engine("lm") %>%
#' fit(Employed~., data = longley)
#' # Return augmented dataframe
#' augment_lr(my_lr,longley)
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
