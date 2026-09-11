#····································································
#   par.R (legendplot package)
#····································································
#   .par.reset.env
#   .par.reset.save
#   par.reset
#
#   (c) Ruben Fernandez-Casal
#   Created: Sep 2026, Modified:
#
#   NOTE: Press Ctrl + Shift + O to show document outline in RStudio
#····································································


# Private environment storing saved graphical parameters:
#   last    -> saved automatically on each call to splot()/fplot()
#   default -> saved by par.reset(set = TRUE); if never explicitly
#                  set, it is initialized the first time splot()/fplot()
#                  calls .par.reset.save() (i.e. with the parameters in
#                  effect before the first such call)
.par.reset.env <- new.env(parent = emptyenv())


#' @keywords internal
.par.reset.save <- function(pars = par(no.readonly = TRUE)) {
  if (!exists("default", envir = .par.reset.env, inherits = FALSE))
    assign("default", pars, envir = .par.reset.env)
  assign("last", pars, envir = .par.reset.env)
  invisible(pars)
}


#' Restore graphical parameters
#'
#' Restores the graphical parameters changed by [splot()]/[fplot()] (or by
#' `sxxx()`/`fxxx()` functions with `reset = FALSE`) or those previously set
#' as the default ones.
#'
#' @param default logical; if `FALSE` (default) restores the parameters saved
#'   automatically by the last call to [splot()] or [fplot()]. If `TRUE`,
#'   restores the *default* parameters (those in effect before the first call
#'   to [splot()]/[fplot()] or set with `par.reset(set = TRUE)`).
#' @param set logical; if `TRUE`, saves the *current* graphical parameters
#'   as the new defaults (the graphical parameters are not changed).
#'
#' @return
#' Invisibly returns the graphical parameters as they were before
#' restoring/saving (see [par()]).
#'
#' @seealso [splot()], [fplot()], [par()]
#'
#' @examples
#' scale.range <- range(mtcars$mpg)
#' splot(slim = scale.range, legend.lab = "mpg")
#' with(mtcars,
#'   plot(hp, qsec, col = scolor(mpg, slim = scale.range),
#'        pch = 16, cex = 1.5)
#' )
#' par.reset() # restores parameters from the last splot()/fplot() call
#'
#' # Set current parameters as the new default
#' par.reset(set = TRUE)
#' # ... later, after several splot()/fplot() calls ...
#' par.reset(default = TRUE) # restores those that were set as defaults
#'
#' @export
#····································································
par.reset <- function(default = FALSE, set = FALSE) {
#····································································
  if (set) {
    default <- par(no.readonly = TRUE)
    assign("default", default, envir = .par.reset.env)
    assign("last", default, envir = .par.reset.env)
    return(invisible(default))
  }

  if (!default) {
    if (!exists("last", envir = .par.reset.env, inherits = FALSE))
      stop("no saved graphical parameters found; ",
           "call splot()/fplot() first, or use 'set = TRUE'")
    old.par <- get("last", envir = .par.reset.env)
  } else {
    if (!exists("default", envir = .par.reset.env, inherits = FALSE))
      stop("no default graphical parameters found; ",
           "call splot()/fplot() first, or use 'set = TRUE'")
    old.par <- get("default", envir = .par.reset.env)
  }

  invisible(par(old.par))
}


