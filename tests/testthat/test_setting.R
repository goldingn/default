context('changing defaults')

test_that('defaults<- modifies a local function', {

  foo <- function (a = 1) a
  defaults(foo) <- list(a = 2)
  expect_equal(foo(), 2)

})

test_that('defaults<- modifies a package function', {

  defaults(mean.default) <- list(na.rm = TRUE)
  expect_equal(mean(c(1, NA, 2)), 1.5)

})

test_that('local functions are reset', {

  foo <- function (a = 1) a
  defaults(foo) <- list(a = 2)
  foo <- reset_defaults(foo)
  expect_equal(foo(), 1)

})

test_that('package functions are reset', {

  defaults(mean.default) <- list(na.rm = TRUE)
  mean.default <- reset_defaults(mean.default)
  expect_equal(mean(c(1, NA, 2)),
               as.numeric(NA))

})
