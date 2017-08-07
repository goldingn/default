[![build status](https://travis-ci.org/goldingn/default.svg?branch=master)](https://travis-ci.org/goldingn/default) [![codecov.io](https://codecov.io/github/goldingn/default/coverage.svg?branch=master)](https://codecov.io/github/goldingn/default?branch=master) [![cran version](http://www.r-pkg.org/badges/version/default)](https://cran.rstudio.com/web/packages/default) [![cran downloads](http://cranlogs.r-pkg.org/badges/default)](http://cran.rstudio.com/web/packages/default/index.html)

default
=======

### change the default arguments in R functions.

Tired of always typing out the same old arguments to functions? Use `default()` to set your favourite arguments as the defaults.

### Example:

``` r
install.packages("default")
library(default)
```

##### boring old defaults

``` r
hist(iris$Sepal.Width)
```

![](README_files/figure-markdown_github/boring-1.png)

##### exciting new defaults

``` r
default(hist.default) <- list(col = "deeppink", border = "white", ylab = "", main = "")
```

``` r
hist(iris$Sepal.Width)
```

![](README_files/figure-markdown_github/exciting_plot-1.png)

##### you can still change the arguments

``` r
hist(iris$Sepal.Width, col = "limegreen")
```

![](README_files/figure-markdown_github/change-1.png)

##### and restore the original defaults

``` r
hist.default <- reset_default(hist.default)
hist(iris$Sepal.Width)
```

![](README_files/figure-markdown_github/restore-1.png)
