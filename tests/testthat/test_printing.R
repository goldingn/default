context('printing defaults')

test_that('defaults handles primitives', {

  text <- capture.output(defaults(max))
  expect_equal(text, "cannot modify defaults on primitive functions")

})

test_that('defaults handles functions with no arguments', {

  text <- capture.output(defaults(Sys.Date))
  expect_equal(text, "function has no arguments")

})

test_that('defaults handles arguments without defaults', {

  text <- capture.output(defaults(print))
  expect_equal(text, c("  - x = [none]",
                       "  - ... = [none] "))

})

test_that('defaults handles arguments with defaults', {

  text <- capture.output(defaults(citation))
  expect_equal(text, c("  - package = \"base\"",
                       "  - lib.loc = NULL",
                       "  - auto = NULL "))

})

test_that('defaults handles with calls as defaults', {

  text <- capture.output(defaults(hist.default))
  expect_equal(text[4], "  - probability = !freq")

})

test_that('defaults flags user-defined defaults', {

  defaults(citation) <- list(package = "defaults")
  on.exit({rm(citation)})
  text <- capture.output(defaults(citation))
  expect_equal(text, c("* - package = \"defaults\"",
                       "  - lib.loc = NULL",
                       "  - auto = NULL "))

})
