[![build status](https://travis-ci.org/goldingn/defaults.svg?branch=master)](https://travis-ci.org/goldingn/defaults) [![codecov.io](https://codecov.io/github/goldingn/defaults/coverage.svg?branch=master)](https://codecov.io/github/goldingn/defaults?branch=master) [![cran version](http://www.r-pkg.org/badges/version/defaults)](https://cran.rstudio.com/web/packages/defaults)

defaults
========

### change the default arguments in R functions.

Tired of always typing out the same old arguments to functions? Use `defaults()` to set your favourite arguments as the defaults.

##### boring old defaults

``` r
hist(iris$Sepal.Width)
```

![](README_files/figure-markdown_github/boring-1.png)

##### exciting new defaults

``` r
library (defaults)
defaults(hist.default) <- list(col = "deeppink", border = "white", ylab = "", main = "")

hist(iris$Sepal.Width)
```

![](README_files/figure-markdown_github/exciting-1.png)

##### you can still change the arguments

``` r
hist(iris$Sepal.Width, col = "limegreen")
```

![](README_files/figure-markdown_github/change-1.png)

##### and restore the original defaults

``` r
hist.default <- reset_defaults(hist.default)
hist(iris$Sepal.Width)
```

![](README_files/figure-markdown_github/restore-1.png)

##### you can install defaults from github

``` r
devtools::install_github("goldingn/defaults")
```
