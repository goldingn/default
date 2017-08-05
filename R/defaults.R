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
defaults <- function (fun) {
  args <- formals(fun)
  render_defaults(args, fun)
  invisible(args)
}

#' @rdname defaults
#' @export
`defaults<-` <- function (fun, value) {

  check_defaults(fun, value)

  arguments <- update_defaults(formals(fun), value)

  new_fun <- do.call(`function`,
                     list(arguments,
                          body(fun)),
                     envir = environment(fun))

  original(new_fun) <- reset_defaults(fun)

  class(new_fun) <- c("defaults_function", class(new_fun))

  new_fun

}

#' @rdname defaults
#' @export
reset_defaults <- function (fun) {

  original_fun <- original(fun)

  if (is.null(original_fun))
    original_fun <- fun

  original_fun

}

original <- function (fun)
  attr(fun, "original_function")

`original<-` <- function (fun, value)
  `attr<-`(fun, "original_function", value)

# print the function without the original function as an attribute
#' @export
print.defaults_function <- function (x, ...) {

  original(x) <- NULL

  print.function(x, ...)

}


# print the current default arguments nicely
render_defaults <- function (args, fun) {

  each_default_text <- lapply(seq_along(args), render_default, args)

  # if it has overwritten defaults, mark them with an asterisk
  if (inherits(fun, "defaults_function")) {

    old_args <- formals(original(fun))

    updated <- !mapply(identical, args, old_args)

    each_default_text[updated] <- paste0(" * ", each_default_text[updated])

    each_default_text[!updated] <- paste0("   ", each_default_text[!updated])

    end_note <- "\n(* user defined default)\n"

  } else {
    each_default_text <- paste0("   ", each_default_text)
    end_note <- ""
  }

  defaults_text <- paste(each_default_text, collapse = "\n")
  print_string <- paste0("defaults:\n", defaults_text, "\n", end_note)
  cat(print_string)

}

#' @importFrom utils capture.output
render_default <- function (index, args) {
  name <- names(args[index])
  value <- args[[index]]

  # handle missing and NULL values
  if (missing(value)) {
    value <- ""
    sep <- ""
  } else {
    sep <- " = "
  }

  if (is.null(value))
    value <- "NULL"

  if (is.call(value))
    value <- capture.output(print(value))

  paste(name, value, sep = sep)

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
update_defaults <- function (list, defaults) {

  labels <- names(defaults)

  for (i in seq_along(defaults))
    list[[labels[i]]] <- defaults[[i]]

  list

}
