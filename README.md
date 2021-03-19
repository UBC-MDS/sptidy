
<!-- README.md is generated from README.Rmd. Please edit that file -->

# sptidy

<!-- badges: start -->

[![R-CMD-check](https://github.com/UBC-MDS/sptidy/workflows/R-CMD-check/badge.svg)](https://github.com/UBC-MDS/sptidy/actions)
<!-- badges: end -->

An R package that produces a tidy output for tidymodels model
evaluation\!

## Introduction

Sptidy implements a `tidy` and `augment` function for base R’s linear
regression and Tidymodel’s kmeans clustering to ease model selection and
assessment tasks. This package is a simplified reimplementation of the
existing `tidy` and `augment` functions in the Broom package. Sptidy’s
family of tidy functions returns a dataframe that summarizes important
model information, while the augment function expands the original
dataframe to include additional model specific information by
observation. This package is meant to complement
[Sktidy](https://github.com/UBC-MDS/sktidy), a Python package that was
created to tidy up the scikit-learn package.

## Features

The functions that this package currently support include:

  - `tidy_kmeans()`: Returns inertia, cluster location, and number of
    associated points at the level of clusters in a tidy format.

  - `tidy_lr()`: Returns coefficients and corresponding feature names in
    a tidy format.

  - `augment_lr()` : Returns predictions and residuals for each point in
    the training data set in a tidy format.

  - `augment_kmeans()` : Returns assigned cluster and distance from
    cluster center for the data the kmeans algorithm was fitted with in
    a tidy format.

## How sptidy fits into the R ecosystem

[Tidymodels](https://github.com/tidymodels) is a “meta-package” for
modeling and statistical analysis that share the underlying design
philosophy, grammar, and data structures of the tidyverse. One of the
packages it includes is [broom](https://broom.tidymodels.org/) which
takes the messy output of built-in functions in R, such as lm, nls, or
t.test, and turns them into tidy data frames. The tidy data refers to
outputting the results in a `data.frame` where each variable has its own
column, each observation has its own row, and each value has its own
cell. In `sptidy`, we implement the functions `tidy()` and `augment()`
for the linear regression model from base R using the function
[`lm()`](https://www.rdocumentation.org/packages/stats/versions/3.6.2/topics/lm)
and the KMeans model from R `stats` package using the function
[`kmeans()`](https://www.rdocumentation.org/packages/stats/versions/3.6.2/topics/kmeans).

## Installation

This package is not yet available on CRAN, but you can install the
development version from [GitHub](https://github.com/) with:

``` r
devtools::install_github("UBC-MDS/sptidy")
```

## Example

This is a basic example which shows you how to solve a common problem:

``` r
#library(sptidy)
## basic example code
```
