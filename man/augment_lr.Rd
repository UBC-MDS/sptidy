% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/sptidy.R
\name{augment_lr}
\alias{augment_lr}
\title{Augmented Output for Tidymodel's Linear Regression}
\usage{
augment_lr()
}
\value{
output data.frame
}
\description{
Adds two columns to the original data of the scikit learn's linear regression model. This includes predictions and residuals.
}
\examples{
# Import libraries
library(tidyverse)
library(tidymodels)
# Load data
data("longley")
# Fit linear regression
my_lr <- linear_reg() \%>\%
set_engine("lm") \%>\%
fit(Employed~., data = longley)
# Return augmented dataframe
augment_lr(my_lr,longley)
}