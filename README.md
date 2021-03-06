
<!-- README.md is generated from README.Rmd. Please edit that file -->

# sptidy

<!-- badges: start -->
<!-- badges: end -->

An R package that produces a tidy output for tidymodels model
evaluation!

## Introduction

Sptidy implements a `tidy` and `augment` function for Tidymodel’s linear
regression and kmeans clustering to ease model selection and assessment
tasks. This package is a simplified reimplementation of the existing
`tidy` and `augment` functions in the Broom package. Sptidy’s family of
tidy functions returns a dataframe that summarizes important model
information, while the augment function expands the original dataframe
to include additional model specific information by observation. This
package is meant to complement
[Sktidy](https://github.com/UBC-MDS/sktidy), a Python package that was
created to tidy up the scikit-learn package.

## Features

The functions that this package currently support include:

-   `tidy_kmeans()`: Returns inertia, cluster location, and number of
    associated points at the level of clusters in a tidy format.

-   `tidy_lr()`: Returns coefficients and corresponding feature names in
    a tidy format.

-   `augment_lr()` : Returns predictions and residuals for each point in
    the training data set in a tidy format.

-   `augment_kmeans()` : Returns assigned cluster and distance from
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
for the linear regression model from the `parsnip` package which is
included in the `tidymodels` package using the function
[`linear_reg()`](https://www.rdocumentation.org/packages/parsnip/versions/0.0.0.9001/topics/linear_reg)
and the KMeans model from R `stats` package using the function
[`kmeans()`](https://www.rdocumentation.org/packages/stats/versions/3.6.2/topics/kmeans).

## Installation

You can install the released version of sptidy from
[CRAN](https://CRAN.R-project.org) with:

``` r
install.packages("sptidy")
```

And the development version from [GitHub](https://github.com/) with:

``` r
# install.packages("devtools")
devtools::install_github("JacobMcFarlane/sptidy")
```

## Example

This is a basic example which shows you how to solve a common problem:

``` r
#library(sptidy)
## basic example code
```

What is special about using `README.Rmd` instead of just `README.md`?
You can include R chunks like so:

``` r
summary(cars)
#>      speed           dist       
#>  Min.   : 4.0   Min.   :  2.00  
#>  1st Qu.:12.0   1st Qu.: 26.00  
#>  Median :15.0   Median : 36.00  
#>  Mean   :15.4   Mean   : 42.98  
#>  3rd Qu.:19.0   3rd Qu.: 56.00  
#>  Max.   :25.0   Max.   :120.00
```

You’ll still need to render `README.Rmd` regularly, to keep `README.md`
up-to-date. `devtools::build_readme()` is handy for this. You could also
use GitHub Actions to re-render `README.Rmd` every time you push. An
example workflow can be found here:
<https://github.com/r-lib/actions/tree/master/examples>.

You can also embed plots, for example:

<img src="man/figures/README-pressure-1.png" width="100%" />

In that case, don’t forget to commit and push the resulting figure
files, so they display on GitHub and CRAN.
