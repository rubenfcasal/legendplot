# ··············································································
#   spoints3d.R (legendplot package)
# ··············································································
#   spoints3d
#
#   (c) Ruben Fernandez-Casal
#   Created: Aug 2026, Modified:
#
#   NOTE: Press Ctrl + Shift + O to show document outline in RStudio
# ··············································································

# ··············································································
# spoints3d ----
# ··············································································

#' 3D scatter plot with a continuous color scale
#'
#' A generic function that, by default, draws a 3D scatter plot ([rgl::plot3d()])
#' with points colored according to a continuous scale associated with a vector
#' of values `s`, and (optionally) adds a color-bar legend (via [splot3d()]).
#'
#' @export
# ··············································································
spoints3d <- function(x, ...) UseMethod("spoints3d")
# S3 generic function spoints3d
# ··············································································

# ··············································································
# spoints3d S3 methods ----
# ··············································································

#' @rdname spoints3d
#' @method spoints3d default
#' @inheritParams splot3d
#' @inheritParams fpoints3d
#' @param s vector used to color the points.
#' @param ... additional arguments passed to [rgl::plot3d()] for the main
#'   scatter plot (e.g. `size`).
#'
#' @return
#' Called for its side effect (draws the 3D scatter plot and, unless
#' `legend = FALSE`, the legend on the active rgl device).
#'
#' @seealso [fpoints3d()], [splot3d()], [scolor()], [sshade3d()], [rgl::plot3d()].
#'
#' @examples
#' library(rgl)
#' open3d() # Alternatively, use `new3d()` to clear the current device or open a new one
#' with(mtcars, spoints3d(hp, qsec, wt, s = mpg, type = "s"))
#'
#' @export
# ··············································································
spoints3d.default <- function(x, y = NULL, z = NULL, s, slim = range(s, finite = TRUE),
                      col = jet.colors(128), xlab = NULL, ylab = NULL, zlab = NULL,
                      type = "p", legend = TRUE, legend.zoom = 0.4, legend.width = 0.1,
                      legend.dim = 0.2, legend.lab = NULL, box = TRUE,
                      lab.breaks = NULL, lab.ticksize = 0.5, lab.dist = 3,
                      add = FALSE, ...) {
  # ············································································
  if (!requireNamespace("rgl", quietly = TRUE))
    stop("package 'rgl' is required")
  if (missing(s))
    stop("argument 's' (coloring values) must be provided")
  if (is.null(legend.lab)) legend.lab <- deparse(substitute(s))
  xlabel <- if (!missing(x)) deparse(substitute(x))
  ylabel <- if (!missing(y)) deparse(substitute(y))
  zlabel <- if (!missing(z)) deparse(substitute(z))
  xyz <- xyz.coords(x,y,z, xlab=xlabel, ylab=ylabel, zlab=zlabel, recycle=TRUE)
  x <- xyz$x
  y <- xyz$y
  z <- xyz$z
  if (is.null(xlab)) xlab <- xyz$xlab
  if (is.null(ylab)) ylab <- xyz$ylab
  if (is.null(zlab)) zlab <- xyz$zlab
  # set up (or add to) the continuous legend
  if (legend) {
    splot3d(slim = slim, col = col, legend.zoom = legend.zoom, legend.width = legend.width,
            legend.dim = legend.dim, legend.lab = legend.lab, box = box,
            lab.breaks = lab.breaks, lab.ticksize = lab.ticksize, lab.dist = lab.dist)
  }
  scol <- scolor(s, col = col, slim = slim)
  rgl::plot3d(xyz, xlab = xlab, ylab = ylab, zlab = zlab, type = type,
              col = scol, add = add, ...)
} # spoints3d
