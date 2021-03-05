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
tidy_lr <- function() {
}

#' Title
#'
#' @return
#' @export
#'
#' @examples
tidy_kmeans <- function() {
}

#' Augmented Output for Tidymodel's Linear Regression
#'
#' Adds two columns to the original data of the scikit learn's linear regression model. This includes predictions and residuals.
#'
#' @params model _lm
#' @params X data.frame
#' @params y data.frame
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
#' augment_lr(my_lr,X,y)
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
augment_kmeans <- function(kclust, data) {

}
