context('error handling')

test_that('defaults and defaults<- error for primitives', {

  expect_error(defaults(max),
               "is a primitive function")

  expect_error(defaults(max) <- list(na.rm = TRUE),
               "is a primitive function")

})

test_that('defaults and defaults<- error on non-functions', {

  expect_error(defaults(pi),
               "is not a function")

  expect_error(defaults(pi) <- list(na.rm = TRUE),
               "is not a function")

})

test_that('defaults<- errors on non-lists', {

  expect_error(defaults(hist.default) <- c(bananas = "yellow"),
               "is not a list")

})

test_that('defaults<- errors on bad names', {

  expect_error(defaults(hist.default) <- list(bananas = "yellow"),
               "'bananas' is not an argument of this function")

  expect_error(defaults(hist.default) <- list(bananas = "yellow", apples = "green"),
               "'bananas', 'apples' are not arguments of this function")

})

test_that('defaults<- errors on non-named lists', {

  expect_error(defaults(hist.default) <- list(col = "yellow", 2),
               "not all of the new defaults are named")

})

