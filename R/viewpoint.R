#····································································
#   viewpoint.R (legendplot package)
#····································································
#   .viewpoints3d
#   addviewpoint3d
#   setviewpoint3d
#   lsviewpoints3d
#   rmviewpoints3d
#   getviewpoints3d
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

# Private environment used to store named 'rgl' viewpoints; not exported
# and not meant to be accessed directly by the user.
.viewpoints3d <- new.env(parent = emptyenv())

# Default viewpoint
# dput(rgl::par3d(.namesview3d))
.defaultview3d <- list(
  zoom = 1,
  FOV = 30,
  userMatrix = matrix(
    c(1, 0, 0, 0,
      0, 0.342020143325668, -0.939692620785909, 0,
      0, 0.939692620785909,  0.342020143325668, 0,
      0, 0, 0, 1),
    ncol = 4),
  userProjection = diag(4)
)
# Add default viewpoint
assign("default", .defaultview3d, envir = .viewpoints3d)

# Names of par3d() viewpoint parameters
# c("zoom", "FOV", "userMatrix", "userProjection")
.namesview3d <- names(.defaultview3d)


#' @name viewpoints
#' @title Work with 'rgl' viewpoints
#' @description
#'  Functions to retrieve, save, restore, list and remove rgl viewpoints; see
#'  *Details* for additional information.
#' @details
#'  `addviewpoint3d()` stores `view` under `name`,
#'  silently overwriting any viewpoint previously stored under the same name.
#'  By default `view` is the current viewpoint, as returned by `getview3d()`.
#' @param name character string giving the name under which a viewpoint is
#'  stored (`addviewpoint3d()`) or looked up (`setviewpoint3d()`).
#' @param view a list with the viewpoint parameters, typically the value
#'  returned by `getview3d()`.
#' @return
#'  `addviewpoint3d()` is called for its side effect of storing `view` under
#'  `name`; it invisibly returns `view`.
#' @seealso [rgl::par3d()]
#'
#' @examples
#' library(rgl)
#' open3d()
#' # Alternatively, use `new3d()` to clear the current device or open a new one.
#' # It also saves the default viewpoint under the name "default"
#' shade3d(volcanom, col = "lightgreen")
#'
#' # ... rotate, zoom or pan the scene interactively ...
#' # Save the current viewpoint under the name "myview"
#' addviewpoint3d("myview")
#'
#' # ... rotate, zoom or pan the scene interactively ...
#' # Restore the default viewpoint
#' setviewpoint3d()
#' # Restore the saved viewpoint
#' setviewpoint3d("myview")
#'
#' # Names of the stored viewpoints
#' lsviewpoints3d()
#' # All stored viewpoints, as a named list
#' views <- getviewpoints3d()
#' # Remove all stored viewpoints
#' rmviewpoints3d()
#' lsviewpoints3d()
#' @export
# ··············································································
addviewpoint3d <- function(name, view = getview3d()) {
  assign(name, view, envir = .viewpoints3d)
  invisible(view)
}


#' @rdname viewpoints
#' @details
#'  `setviewpoint3d()` looks up the viewpoint stored under `name` and applies
#'  it to the current rgl subscene via `setview3d()`.
#' @return
#'  `setviewpoint3d()` is called for its side effect of restoring a stored
#'  viewpoint to the current rgl subscene; it invisibly returns the corresponding `view`.
#' @export
# ··············································································
setviewpoint3d <- function(name = "default") {
  # if (!exists(name, envir = .viewpoints3d))
  #     stop("`name` viewpoint was not found.")
  view <- get(name, envir = .viewpoints3d)
  setview3d(view)
  invisible(view)
}


#' @rdname viewpoints
#' @details
#'  `lsviewpoints3d()` returns the names of all the viewpoints currently
#'  stored.
#' @param ... additional arguments to be passed to [ls()] or [rm()].
#' @return
#'  `lsviewpoints3d()` returns a character vector with the names of the
#'  stored viewpoints.
#' @export
# ··············································································
lsviewpoints3d <- function(...) {
  ls(..., envir = .viewpoints3d)
}


#' @rdname viewpoints
#' @details
#' `rmviewpoints3d()` Deletes one or more saved viewpoints by name.
#' If called without arguments, it deletes all of them, always retaining
#' the `"default"` viewpoint.
#' @return
#' `rmviewpoints3d()` is called for its side effect of removing one or more
#' stored viewpoints.
#' @export
# ··············································································
rmviewpoints3d <- function(...) {
  if (length(list(...))) rm(..., envir = .viewpoints3d) else
    rm(list = lsviewpoints3d(), envir = .viewpoints3d)
  # Add default viewpoint if it was removed
  if (!exists("default", envir = .viewpoints3d))
    assign("default", .defaultview3d, envir = .viewpoints3d)

}


#' @rdname viewpoints
#' @details
#'  `getviewpoints3d()` returns a named list with all the viewpoints
#'  currently stored, one entry per name.
#' @return
#'  `getviewpoints3d()` returns a named list with all the stored viewpoints.
#' @export
# ··············································································
getviewpoints3d <- function() {
  as.list(.viewpoints3d)
}


# ··············································································
# view3d ----
# ··············································································

#' @rdname viewpoints
#' @details
#'  `getview3d()` retrieves the parameters that define the current viewpoint
#'  of the current rgl subscene (zoom, user matrix and user projection), so
#'  that they can be saved and restored later with `setview3d()`.
#' @return
#'  `getview3d()` returns a list with the components `zoom`, `userMatrix`
#'  and `userProjection` (see [rgl::par3d()]).
#' @export
# ··············································································
getview3d <- function() {
  rgl::par3d(.namesview3d)
}


#' @rdname viewpoints
#' @details
#'  `setview3d()` applies to the current rgl subscene a viewpoint previously
#'  obtained with `getview3d()` (this is also what `setviewpoint3d()` uses
#'  internally to restore a stored viewpoint).
#' @return
#'  `setview3d()` is called mainly for its side effect of setting the
#'  viewpoint of the current rgl subscene (see [rgl::par3d()]); it returns the
#'  value returned by `par3d()`.
#' @export
# ··············································································
setview3d <- function(view) {
  do.call(rgl::par3d, view)
}
