library(tidyverse)
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

#' Augmented Output for Base R's Linear Regression
#'
#' Adds two columns to the original data of base R's linear regression model. \
#' This includes predictions and residuals.
#'
#' @params model _lm
#' @params x data.frame
#' @params y data.frame
#'
#' @return output data.frame
#' @export
#'
#' @examples
#' # Import libraries
#' library(tidyverse)
#' data("longley")
#' my_lr <- lm(Employed~., data = longley)
#' X <- longley %>%
#'  select(-Employed)
#' y <- longley %>%
#'  select(Employed)
#' augment_lr(my_lr,longley)
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
  if (length(x)[1] == 0 |  length(y)[1]== 0) {
    stop("x and y must both contain more than one row")
  }

  pred <- data.frame(predictions = predict(my_lr, x))

  resid <- data.frame(y - pred) %>%
    rename(residuals = Employed)

  output <- cbind(x, y, pred, resid)

  return(output)
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
