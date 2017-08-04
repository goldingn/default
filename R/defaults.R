#' change a function's default arguments
#' @name defaults
#' @export
#'
#' @description \code{defaults()} lets you check, and change, a function's
#'   default arguments, \code{reset_defaults()} returns the arguments to their
#'   original defaults.
#'
#' @param fun a function
#' @param value a named list of new default arguments for that function
#'
#' @details If \code{fun} is in a package, a function of the same name will be
#'   defined in the calling environment (probably your workspace). If \code{fun}
#'   is defined locally, it will be overwritten by the version with the new
#'   defaults.
#'
#'   \code{reset_defaults} returns the reset function, rather than modifying it
#'   in place, so you'll need to reassign it as in the example.
#'
#' @examples
#' # to do
defaults <- function (fun)
  formals(fun)

# (make this print nicely in the future, possibly with asterisks to denote the changed values)

#' @rdname defaults
#' @export
`defaults<-` <- function (fun, value) {

  # check fun & value are what they are supposed to be
  check_defaults(fun, value)

  # update arguments
  args <- set_args(formals(fun), value)

  # rebuild the function
  new_fun <- do.call(`function`,
                     list(args,
                          body(fun)),
                     envir = environment(fun))

  # add the original function as an attribute
  original_fun <- attr(fun, "original_function")
  if (is.null(original_fun))
    original_fun <- fun
  attr(new_fun, "original_function") <- original_fun

  class(new_fun) <- c("defaults_function", class(new_fun))

  new_fun

}

#' @rdname defaults
#' @export
reset_defaults <- function (fun) {
  original_fun <- attr(fun, "original_function")
  if (is.null(original_fun))
    original_fun <- fun
  original_fun
}

# print the function without the original function as an attribute
#' @export
print.defaults_function <- function (x, ...) {
  attr(x, "original_function") <- NULL
  print.function(x, ...)
}

check_defaults <- function (fun, value) {

  if (!is.function(fun))
    stop ("fun is not a function",
          call. = FALSE)

  if (is.primitive(fun))
    stop ("fun is a primitive function; its default arguments cannot be altered",
          call. = FALSE)

  if (!is.list(value))
    stop ("value is not a list",
          call. = FALSE)

  if (length(names(value)) != length(value))
    stop ("value is a list, but the arguments are not all named",
          call. = FALSE)

  old_args <- names(formals(fun))
  new_args <- names(value)
  bad_args <- new_args[!new_args %in% old_args]

  if (length(bad_args) > 0) {

    if (length(bad_args) == 1) {
      msg <- paste("value contains the element:",
                   bad_args,
                   "which is not an argument of fun")
    } else {
      msg <- paste("value contains the elements:",
                   paste(bad_args, collapse = ","),
                   "which are not arguments of fun")
    }

    stop (msg, call. = FALSE)

  }

}

# put defaults into the arguments list
set_args <- function (list, defaults) {

  labels <- names(defaults)

  for (i in seq_along(defaults))
    list[[labels[i]]] <- defaults[[i]]

  list

}



