context('changing defaults')

test_that('default<- modifies a local function', {

  foo <- function (a = 1) a
  default(foo) <- list(a = 2)
  expect_equal(foo(), 2)

})

test_that('default<- modifies a package function', {

  default(mean.default) <- list(na.rm = TRUE)
  expect_equal(mean(c(1, NA, 2)), 1.5)

})

test_that('local functions are reset', {

  foo <- function (a = 1) a
  default(foo) <- list(a = 2)
  foo <- reset_default(foo)
  expect_equal(foo(), 1)

})

test_that('package functions are reset', {

  default(mean.default) <- list(na.rm = TRUE)
  mean.default <- reset_default(mean.default)
  expect_equal(mean(c(1, NA, 2)),
               as.numeric(NA))

})
