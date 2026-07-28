#····································································
#   viewpoint.R (legendplot package)
#····································································
#   .viewpoints
#   add.viewpoint
#   set.viewpoint
#   ls.viewpoints
#   rm.viewpoints
#   get.viewpoints
#   getview3d
#   setview3d
#
#   (c) Ruben Fernandez-Casal
#   Created: Jul 2026, Modified:
#
#   NOTE: Press Ctrl + Shift + O to show document outline in RStudio
#····································································

# ··············································································
# Viewpoints ----
# ··············································································

# Private environment used to store named viewpoints; not exported and not
# meant to be accessed directly by the user.
.viewpoints <- new.env(parent = emptyenv())


#' @name viewpoints
#' @title Work with 'rgl' viewpoints
#' @description
#'  Functions to retrieve, save, restore, list and remove rgl viewpoints; see
#'  *Details* for additional information.
#' @details
#'  `add.viewpoint()` stores `view` under `name`,
#'  silently overwriting any viewpoint previously stored under the same name.
#'  By default `view` is the current viewpoint, as returned by `getview3d()`.
#' @param name character string giving the name under which a viewpoint is
#'  stored (`add.viewpoint()`) or looked up (`set.viewpoint()`).
#' @param view a list with the viewpoint parameters, typically the value
#'  returned by `getview3d()`.
#' @return
#'  `add.viewpoint()` is called for its side effect of storing `view` under
#'  `name`; it invisibly returns `view`.
#' @seealso [rgl::par3d()]
#'
#' @examples
#' library(rgl)
#' new3d()
#' shade3d(volcanom, col = "lightgreen")
#'
#' # Save the current viewpoint under the name "default"
#' add.viewpoint("default")
#'
#' # ... rotate, zoom or pan the scene interactively ...
#'
#' # Restore the saved viewpoint
#' set.viewpoint("default")
#'
#' # Names of the stored viewpoints
#' ls.viewpoints()
#'
#' # All stored viewpoints, as a named list
#' get.viewpoints()
#'
#' # Remove all stored viewpoints
#' rm.viewpoints()
#' ls.viewpoints()
#' @export
# ··············································································
add.viewpoint <- function(name, view = getview3d()) {
  assign(name, view, envir = .viewpoints)
  invisible(view)
}


#' @rdname viewpoints
#' @details
#'  `set.viewpoint()` looks up the viewpoint stored under `name` and applies
#'  it to the active rgl device via `setview3d()`.
#' @return
#'  `set.viewpoint()` is called for its side effect of restoring a stored
#'  viewpoint; it invisibly returns the corresponding `view`.
#' @export
# ··············································································
set.viewpoint <- function(name) {
  # if (!exists(name, envir = .viewpoints))
  #     stop("`name` viewpoint was not found.")
  view <- get(name, envir = .viewpoints)
  setview3d(view)
  invisible(view)
}


#' @rdname viewpoints
#' @details
#'  `ls.viewpoints()` returns the names of all the viewpoints currently
#'  stored.
#' @param ... additional arguments to be passed to [ls()] or [rm()].
#' @return
#'  `ls.viewpoints()` returns a character vector with the names of the
#'  stored viewpoints.
#' @export
# ··············································································
ls.viewpoints <- function(...) {
  ls(..., envir = .viewpoints)
}


#' @rdname viewpoints
#' @details
#'  `rm.viewpoints()` removes one or more stored viewpoints by name; called
#'  with no arguments, it removes *all* of them.
#' @return
#'  `rm.viewpoints()` is called for its side effect of removing one or more
#'  stored viewpoints.
#' @export
# ··············································································
rm.viewpoints <- function(...) {
  if (length(list(...))) rm(..., envir = .viewpoints) else
    rm(list = ls.viewpoints(), envir = .viewpoints)
}


#' @rdname viewpoints
#' @details
#'  `get.viewpoints()` returns a named list with all the viewpoints
#'  currently stored, one entry per name.
#' @return
#'  `get.viewpoints()` returns a named list with all the stored viewpoints.
#' @export
# ··············································································
get.viewpoints <- function() {
  as.list(.viewpoints)
}


# ··············································································
# view3d ----
# ··············································································

#' @rdname viewpoints
#' @details
#'  `getview3d()` retrieves the parameters that define the current viewpoint
#'  of the active rgl device (zoom, user matrix and user projection), so
#'  that they can be saved and restored later with `setview3d()`.
#' @return
#'  `getview3d()` returns a list with the components `zoom`, `userMatrix`
#'  and `userProjection` (see [rgl::par3d()]).
#' @export
# ··············································································
getview3d <- function() {
  par3d()[c("zoom", "userMatrix", "userProjection")]
}


#' @rdname viewpoints
#' @details
#'  `setview3d()` applies to the active rgl device a viewpoint previously
#'  obtained with `getview3d()` (this is also what `set.viewpoint()` uses
#'  internally to restore a stored viewpoint).
#' @return
#'  `setview3d()` is called mainly for its side effect of setting the
#'  viewpoint of the active rgl device (see [rgl::par3d()]); it returns the
#'  value returned by `par3d()`.
#' @export
# ··············································································
setview3d <- function(view) {
  do.call(par3d, view)
}
