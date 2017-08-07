context('error handling')

test_that('default and default<- error for primitives', {

  expect_error(default(max),
               "is a primitive function")

  expect_error(default(max) <- list(na.rm = TRUE),
               "is a primitive function")

})

test_that('default and default<- error on non-functions', {

  expect_error(default(pi),
               "is not a function")

  expect_error(default(pi) <- list(na.rm = TRUE),
               "is not a function")

})

test_that('default<- errors on non-lists', {

  expect_error(default(hist.default) <- c(bananas = "yellow"),
               "is not a list")

})

test_that('default<- errors on bad names', {

  expect_error(default(hist.default) <- list(bananas = "yellow"),
               "'bananas' is not an argument of this function")

  expect_error(default(hist.default) <- list(bananas = "yellow", apples = "green"),
               "'bananas', 'apples' are not arguments of this function")

})

test_that('default<- errors on non-named lists', {

  expect_error(default(hist.default) <- list(col = "yellow", 2),
               "not all of the new default arguments are named")

})

