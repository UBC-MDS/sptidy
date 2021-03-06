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

#' Title
#'
#' @return
#' @export
#'
#' @examples
augment_kmeans <- function() {
}
