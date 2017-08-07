context('printing defaults')

test_that('default prints functions with no arguments', {

  text <- capture.output(default(Sys.Date))
  expect_equal(text, "function has no arguments")

})

test_that('default prints arguments without defaults', {

  text <- capture.output(default(print))
  expect_equal(text, c("  - x = [none]",
                       "  - ... = [none] "))

})

test_that('default prints arguments with defaults', {

  text <- capture.output(default(citation))
  expect_equal(text, c("  - package = \"base\"",
                       "  - lib.loc = NULL",
                       "  - auto = NULL "))

})

test_that('default handles with calls as defaults', {

  text <- capture.output(default(hist.default))
  expect_equal(text[4], "  - probability = !freq")

})

test_that('default flags user-defined defaults', {

  default(citation) <- list(package = "default")
  text <- capture.output(default(citation))
  expect_equal(text, c("* - package = \"default\"",
                       "  - lib.loc = NULL",
                       "  - auto = NULL "))

})

test_that('default_functions are printed without displaying the original', {

  default(hist.default) <- list(col = "red")
  text_new <- capture.output(print(hist.default))
  expect_true(!"attr(,\"original_function\")" %in% text_new)

})
