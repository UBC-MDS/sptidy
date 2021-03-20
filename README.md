
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

When working with linear regression and kmeans clustering in R, it’s
nice to:

  - have a one-stop shop summary data frame on model statistics
  - have a data frame with prediction, residual or cluster assignment
    with respect to each observation

The sptidy package provides tools that make these tasks swift and easy.

## Overview

This vignette is the package-wide documentation for R package sptidy.
This helps those who want to use this package better understand what
sptidy does. A full usage demonstration of all functions in this package
is included in this vignette.

## Available functions

sptidy provides functions for model evaluation and analysis. These
functions work with 2 types of models: lm() and kmeans().

  - linear regression
      - `tidy_lr` outputs summary on lm()
      - `augment_lr` augments a data frame with predictions and
        residuals
  - kmeans clustering
      - `tidy_kmeans` outputs summary on kmeans()
      - `augment_kmeans` augments a data frame with cluster assignments

## Data

First, let us load sptidy and 2 data set: `longley`, `iris` for function
usage demonstration.

``` r
library(sptidy)
data(longley)
data(iris)
```

## Function Usage Demonstration

### tidy\_lr(): clean summary output for lm()

sptidy::tidy\_lr() provides a tidy data frame that summarizes a fitted
linear regression object lm(). The argument in the function needs to be
a fitted lm() object. The output data frame has 4 columns, describing
coefficient estimates, standard error, t-statistics and p-values.

``` r
my_lr <- lm(Employed~., data = longley)
sptidy::tidy_lr(my_lr)
#>                    coef  std_err t_stats  p_val
#> (Intercept)  -3482.2586 890.4204 -3.9108 0.0036
#> GNP.deflator     0.0151   0.0849  0.1774 0.8631
#> GNP             -0.0358   0.0335 -1.0695 0.3127
#> Unemployed      -0.0202   0.0049 -4.1364 0.0025
#> Armed.Forces    -0.0103   0.0021 -4.8220 0.0009
#> Population      -0.0511   0.2261 -0.2261 0.8262
#> Year             1.8292   0.4555  4.0159 0.0030
```

### augment\_lr(): augment data frame from lm()

sptidy::augment\_lr() augments the data frame with predictions and
residuals from a fitted linear regression object lm(). The first
argument is the fitted lm() object. The second and third argument refer
to the feature data frame and target data frame that are fitted to the
lm() object. The output data frame has additional 2 columns, describing
predictions and residuals with respect to each observation.

``` r
my_lr <- lm(Employed~., data = longley)
sptidy::augment_lr(my_lr, longley[1:6], as.data.frame(longley$Employed))
#>      GNP.deflator     GNP Unemployed Armed.Forces Population Year
#> 1947         83.0 234.289      235.6        159.0    107.608 1947
#> 1948         88.5 259.426      232.5        145.6    108.632 1948
#> 1949         88.2 258.054      368.2        161.6    109.773 1949
#> 1950         89.5 284.599      335.1        165.0    110.929 1950
#> 1951         96.2 328.975      209.9        309.9    112.075 1951
#> 1952         98.1 346.999      193.2        359.4    113.270 1952
#> 1953         99.0 365.385      187.0        354.7    115.094 1953
#> 1954        100.0 363.112      357.8        335.0    116.219 1954
#> 1955        101.2 397.469      290.4        304.8    117.388 1955
#> 1956        104.6 419.180      282.2        285.7    118.734 1956
#> 1957        108.4 442.769      293.6        279.8    120.445 1957
#> 1958        110.8 444.546      468.1        263.7    121.950 1958
#> 1959        112.6 482.704      381.3        255.2    123.366 1959
#> 1960        114.2 502.601      393.1        251.4    125.368 1960
#> 1961        115.7 518.173      480.6        257.2    127.852 1961
#> 1962        116.9 554.894      400.7        282.7    130.081 1962
#>      longley$Employed predictions   residuals
#> 1947           60.323    60.05566  0.26734003
#> 1948           61.122    61.21601 -0.09401394
#> 1949           60.171    60.12471  0.04628717
#> 1950           61.187    61.59711 -0.41011462
#> 1951           63.221    62.91129  0.30971459
#> 1952           63.639    63.88831 -0.24931122
#> 1953           64.989    65.15305 -0.16404896
#> 1954           63.761    63.77418 -0.01318036
#> 1955           66.019    66.00470  0.01430477
#> 1956           67.857    67.40161  0.45539409
#> 1957           68.169    68.18627 -0.01726893
#> 1958           66.513    66.55206 -0.03905504
#> 1959           68.655    68.81055 -0.15554997
#> 1960           69.564    69.64967 -0.08567131
#> 1961           69.331    68.98907  0.34193151
#> 1962           70.551    70.75776 -0.20675783
```

### tidy\_kmeans(): clean summary output for kmeans()

sptidy::tidy\_kmeans() provides a tidy data frame that summarizes a
fitted kmeans clustering object kmenas(). The first argument is the
fitted kmeans() object. The second argument refers to the data that was
fitted to the kmeans() object. The output data frame has 3 columns,
describing cluster number, cluster center and number of points within
each cluster.

``` r
data <- iris[,1:3]
kclust <- kmeans(data, centers = 3)
tidy_kmeans(kclust, data)
#> # A tibble: 3 x 3
#>   cluster_number cluster_center n_points
#>            <int> <list>            <int>
#> 1              1 <dbl [3]>            22
#> 2              2 <dbl [3]>            32
#> 3              3 <dbl [3]>            96
```

### augment\_kmeans(): augment data frame from kmeans()

sptidy::augment\_kmeans() augments the data frame with cluster
assignment from a fitted kmeans clustering object kmeans(). The first
argument is the fitted kmeans() object. The second argument refers to
the data that was fitted to the kmeans() object. The output data frame
has additional 1 column, describing cluster assignment with respect to
each observation.

``` r
data <- iris[,1:3]
kclust <- kmeans(data, centers = 3)
augment_kmeans(kclust, data)
#>     Sepal.Length Sepal.Width Petal.Length cluster
#> 1            5.1         3.5          1.4       3
#> 2            4.9         3.0          1.4       3
#> 3            4.7         3.2          1.3       3
#> 4            4.6         3.1          1.5       3
#> 5            5.0         3.6          1.4       3
#> 6            5.4         3.9          1.7       3
#> 7            4.6         3.4          1.4       3
#> 8            5.0         3.4          1.5       3
#> 9            4.4         2.9          1.4       3
#> 10           4.9         3.1          1.5       3
#> 11           5.4         3.7          1.5       3
#> 12           4.8         3.4          1.6       3
#> 13           4.8         3.0          1.4       3
#> 14           4.3         3.0          1.1       3
#> 15           5.8         4.0          1.2       3
#> 16           5.7         4.4          1.5       3
#> 17           5.4         3.9          1.3       3
#> 18           5.1         3.5          1.4       3
#> 19           5.7         3.8          1.7       3
#> 20           5.1         3.8          1.5       3
#> 21           5.4         3.4          1.7       3
#> 22           5.1         3.7          1.5       3
#> 23           4.6         3.6          1.0       3
#> 24           5.1         3.3          1.7       3
#> 25           4.8         3.4          1.9       3
#> 26           5.0         3.0          1.6       3
#> 27           5.0         3.4          1.6       3
#> 28           5.2         3.5          1.5       3
#> 29           5.2         3.4          1.4       3
#> 30           4.7         3.2          1.6       3
#> 31           4.8         3.1          1.6       3
#> 32           5.4         3.4          1.5       3
#> 33           5.2         4.1          1.5       3
#> 34           5.5         4.2          1.4       3
#> 35           4.9         3.1          1.5       3
#> 36           5.0         3.2          1.2       3
#> 37           5.5         3.5          1.3       3
#> 38           4.9         3.6          1.4       3
#> 39           4.4         3.0          1.3       3
#> 40           5.1         3.4          1.5       3
#> 41           5.0         3.5          1.3       3
#> 42           4.5         2.3          1.3       3
#> 43           4.4         3.2          1.3       3
#> 44           5.0         3.5          1.6       3
#> 45           5.1         3.8          1.9       3
#> 46           4.8         3.0          1.4       3
#> 47           5.1         3.8          1.6       3
#> 48           4.6         3.2          1.4       3
#> 49           5.3         3.7          1.5       3
#> 50           5.0         3.3          1.4       3
#> 51           7.0         3.2          4.7       1
#> 52           6.4         3.2          4.5       2
#> 53           6.9         3.1          4.9       1
#> 54           5.5         2.3          4.0       2
#> 55           6.5         2.8          4.6       2
#> 56           5.7         2.8          4.5       2
#> 57           6.3         3.3          4.7       2
#> 58           4.9         2.4          3.3       2
#> 59           6.6         2.9          4.6       2
#> 60           5.2         2.7          3.9       2
#> 61           5.0         2.0          3.5       2
#> 62           5.9         3.0          4.2       2
#> 63           6.0         2.2          4.0       2
#> 64           6.1         2.9          4.7       2
#> 65           5.6         2.9          3.6       2
#> 66           6.7         3.1          4.4       2
#> 67           5.6         3.0          4.5       2
#> 68           5.8         2.7          4.1       2
#> 69           6.2         2.2          4.5       2
#> 70           5.6         2.5          3.9       2
#> 71           5.9         3.2          4.8       2
#> 72           6.1         2.8          4.0       2
#> 73           6.3         2.5          4.9       2
#> 74           6.1         2.8          4.7       2
#> 75           6.4         2.9          4.3       2
#> 76           6.6         3.0          4.4       2
#> 77           6.8         2.8          4.8       1
#> 78           6.7         3.0          5.0       1
#> 79           6.0         2.9          4.5       2
#> 80           5.7         2.6          3.5       2
#> 81           5.5         2.4          3.8       2
#> 82           5.5         2.4          3.7       2
#> 83           5.8         2.7          3.9       2
#> 84           6.0         2.7          5.1       2
#> 85           5.4         3.0          4.5       2
#> 86           6.0         3.4          4.5       2
#> 87           6.7         3.1          4.7       1
#> 88           6.3         2.3          4.4       2
#> 89           5.6         3.0          4.1       2
#> 90           5.5         2.5          4.0       2
#> 91           5.5         2.6          4.4       2
#> 92           6.1         3.0          4.6       2
#> 93           5.8         2.6          4.0       2
#> 94           5.0         2.3          3.3       2
#> 95           5.6         2.7          4.2       2
#> 96           5.7         3.0          4.2       2
#> 97           5.7         2.9          4.2       2
#> 98           6.2         2.9          4.3       2
#> 99           5.1         2.5          3.0       2
#> 100          5.7         2.8          4.1       2
#> 101          6.3         3.3          6.0       1
#> 102          5.8         2.7          5.1       2
#> 103          7.1         3.0          5.9       1
#> 104          6.3         2.9          5.6       1
#> 105          6.5         3.0          5.8       1
#> 106          7.6         3.0          6.6       1
#> 107          4.9         2.5          4.5       2
#> 108          7.3         2.9          6.3       1
#> 109          6.7         2.5          5.8       1
#> 110          7.2         3.6          6.1       1
#> 111          6.5         3.2          5.1       1
#> 112          6.4         2.7          5.3       1
#> 113          6.8         3.0          5.5       1
#> 114          5.7         2.5          5.0       2
#> 115          5.8         2.8          5.1       2
#> 116          6.4         3.2          5.3       1
#> 117          6.5         3.0          5.5       1
#> 118          7.7         3.8          6.7       1
#> 119          7.7         2.6          6.9       1
#> 120          6.0         2.2          5.0       2
#> 121          6.9         3.2          5.7       1
#> 122          5.6         2.8          4.9       2
#> 123          7.7         2.8          6.7       1
#> 124          6.3         2.7          4.9       2
#> 125          6.7         3.3          5.7       1
#> 126          7.2         3.2          6.0       1
#> 127          6.2         2.8          4.8       2
#> 128          6.1         3.0          4.9       2
#> 129          6.4         2.8          5.6       1
#> 130          7.2         3.0          5.8       1
#> 131          7.4         2.8          6.1       1
#> 132          7.9         3.8          6.4       1
#> 133          6.4         2.8          5.6       1
#> 134          6.3         2.8          5.1       1
#> 135          6.1         2.6          5.6       1
#> 136          7.7         3.0          6.1       1
#> 137          6.3         3.4          5.6       1
#> 138          6.4         3.1          5.5       1
#> 139          6.0         3.0          4.8       2
#> 140          6.9         3.1          5.4       1
#> 141          6.7         3.1          5.6       1
#> 142          6.9         3.1          5.1       1
#> 143          5.8         2.7          5.1       2
#> 144          6.8         3.2          5.9       1
#> 145          6.7         3.3          5.7       1
#> 146          6.7         3.0          5.2       1
#> 147          6.3         2.5          5.0       2
#> 148          6.5         3.0          5.2       1
#> 149          6.2         3.4          5.4       1
#> 150          5.9         3.0          5.1       2
```
