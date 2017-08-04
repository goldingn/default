### defaults

#### Change the default arguments in R functions.

Tired of always typing out the same old arguments to functions? Use `defaults()` to set these as the defaults.

##### boring old defaults

``` r
hist(iris$Sepal.Width)
```

![](README_files/figure-markdown_github/unnamed-chunk-1-1.png)

##### exciting new defaults

``` r
library (defaults)
defaults(hist.default) <- list(col = "deeppink", border = "white", breaks = 20, ylab = "", main = "")

hist(iris$Sepal.Width)
```

![](README_files/figure-markdown_github/unnamed-chunk-2-1.png)

##### you can still specify the arguments later

``` r
hist(iris$Sepal.Width, col = grey(0.6))
```

![](README_files/figure-markdown_github/unnamed-chunk-3-1.png)

##### and reset the defaults to their original values

``` r
hist.default <- reset_defaults(hist.default)
hist(iris$Sepal.Width)
```

![](README_files/figure-markdown_github/unnamed-chunk-4-1.png)

##### install defaults from github

``` r
devtools::install_github("goldingn/defaults")
```

    ## Downloading GitHub repo goldingn/defaults@master
    ## from URL https://api.github.com/repos/goldingn/defaults/zipball/master

    ## Installation failed: Not Found (404)
