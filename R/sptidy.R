# test fcn

#' Tidy Output for Linear Regression
#'
#' Create a tidy output for lm() object. The output
#' would have n+1 rows, where n is number of features and
#' 4 columns describing coefficient estimates, standard
#' error, t-statistics and p-values
#'
#' @param model lm_description
#'
#' @return output data.frame
#' @export
#'
#' @examples
#'
#'
#' data("longley")
#' my_lr <- lm(Employed~., data = longley)
#' tidy_lr(my_lr)
#'
tidy_lr <- function(model) {
  if (!(class(model)=='lm')) {
    stop("Input model should be class of 'lm'")
  }
  coef <- model$coefficients
  std_err <- sqrt(diag(vcov(model)))
  t_stats <- coef/std_err
  p_val <- summary(model)$coefficients[,4]
  output <- data.frame(coef,std_err,t_stats,p_val)
  output[] <- lapply(output, function(x) if(is.numeric(x)) round(x, 4) else x)
  output
}

#' Tidy Output for KMeans Clustering
#'
#' Creates a tidy dataframe containing information at the cluster level for a
#' kmeans clustering algorithm
#'
#' @param Model A `kmeans` object created by [stats::kmeans()].
#' @param X data.frame of the original data set.
#' @return tibble of infomration associated with each cluster
#' @export
#'
#' @examples
#' library(dplyr)
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
#' @param my_lr the linear model to augment
#' @param x the data frame containing the explanatory variables
#' @param y the data frame containing the target variable
#'
#'
#' @return output data.frame
#' @export
#'
#' @examples
#' # Import libraries
#' library(dplyr)
#' # Load data


augment_lr <- function(my_lr, x, y) {
  # Must be linear regression model
  if (class(my_lr)[1] != "lm") {
    stop("Model must be a linear regression model")
  }
  # x and y must be dataframes
  if (class(x)[1] != "data.frame" |  class(y)[1] != "data.frame") {
    stop("x and y must both be dataframes")
  }
  # x and y must have more than 0 rows
  if (nrow(x) == 0 |  nrow(y) == 0) {
    stop("x and y must both contain more than one row")
  }
  pred <- data.frame(predictions = stats::predict(my_lr, x))
  resid <- data.frame(residuals = y$y - pred$pred)
  output <- cbind(x, y, pred, resid)
  return(output)
}

#' Cluster Assignments of the Original Data Set
#'
#' @param Model A `kmeans` object created by [stats::kmeans()].
#' @param X data.frame of the original data set.
#' @return data.frame of the original data and their cluster assignment.
#' @export
#'
#' @examples
#' library(dplyr)
#' library(stats)
#' data(iris)
#' data <- iris %>% select(-Species)
#' kclust <- kmeans(data, centers = 3)
#' augment_kmeans(kclust, data)
augment_kmeans <- function(Model, X) {
  if (class(Model) != "kmeans") {
    stop("Model must be of class 'kmeans'")
  }

  if (class(X)[1] != "data.frame") {
    stop("X must be a dataframe")
  }

  # X must not be empty
  if (nrow(X) == 0) {
    stop("X must contain more than one row")
  }

  X$cluster <- Model$cluster
  return(X)
}
