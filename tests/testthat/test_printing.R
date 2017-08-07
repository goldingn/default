context('printing defaults')

test_that('defaults prints functions with no arguments', {

  text <- capture.output(defaults(Sys.Date))
  expect_equal(text, "function has no arguments")

})

test_that('defaults prints arguments without defaults', {

  text <- capture.output(defaults(print))
  expect_equal(text, c("  - x = [none]",
                       "  - ... = [none] "))

})

test_that('defaults prints arguments with defaults', {

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
  text <- capture.output(defaults(citation))
  expect_equal(text, c("* - package = \"defaults\"",
                       "  - lib.loc = NULL",
                       "  - auto = NULL "))

})

test_that('default_functions are printed without displaying the original', {

  defaults(hist.default) <- list(col = "red")
  text_new <- capture.output(print(hist.default))
  expect_true(!"attr(,\"original_function\")" %in% text_new)

})
