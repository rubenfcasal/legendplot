# ··············································································
#   spersp3d.R (legendplot package)
# ··············································································
#   spersp3d
#
#   (c) Ruben Fernandez-Casal
#   Created: Aug 2026, Modified:
#
#   NOTE: Press Ctrl + Shift + O to show document outline in RStudio
# ··············································································

# ··············································································
# spersp3d ----
# ··············································································

#' 3D surface plot with a continuous color scale
#'
#' A generic function that draws a 3D surface ([rgl::persp3d()])
#' colored according to a continuous scale associated with a vector
#' of values `s`, and (optionally) adds a color-bar legend (via [splot3d()]).
#'
#' @export
# ··············································································
spersp3d <- function(x, ...) UseMethod("spersp3d")
# S3 generic function spersp3d
# ··············································································

# ··············································································
# spersp3d S3 methods ----
# ··············································································

#' @rdname spersp3d
#' @method spersp3d default
#' @inheritParams splot3d
#' @inheritParams fpoints3d
#' @param x object used to select a method. In the default method, it typically
#'   provides the grid values for the `x` axis. The grid may be specified in
#'   several ways, see [rgl::surface3d()].
#' @param y grid values for the `y` axis.
#' @param z matrix with the surface height at each grid point (of dimension
#'   `length(x)` by `length(y)` if `x` and `y` are vectors).
#' @param s matrix with the values used for coloring the surface (one color per
#'   vertex). Defaults to `z`.
#' @param xlab,ylab,zlab titles for the axes (character strings; expressions are
#'   not accepted)
#' @param xlim,ylim,zlim x-, y- and z-limits.  If present, the plot is clipped
#'   to this region.
#' @param aspect either a logical indicating whether to adjust the aspect
#'   ratio, or a new ratio.
#' @param ... additional arguments passed to [rgl::persp3d()] for the main plot.
#'
#' @return
#' Called for its side effect (draws the 3D surface plot and, unless
#' `legend = FALSE`, the legend on the active rgl device).
#'
#' @seealso [splot3d()], [scolor()], [sshade3d()], [rgl::persp3d()].
#'
#' @examples
#' library(rgl)
#' open3d() # Alternatively, use `new3d()` to clear the current device or open a new one
#' x <- seq(0, 1, length.out = 30)
#' y <- seq(0, 1, length.out = 30)
#' z <- outer(x, y, function(x, y) sin(2*pi*x) + 4*(y-0.5)^2 - 0.5)
#' spersp3d(x, y, z)
#'
#' @export
# ··············································································
spersp3d.default <- function(x, y = NULL, z = NULL, s = z, slim = range(s, finite = TRUE),
                      col = jet.colors(128), xlab = NULL, ylab = NULL, zlab = NULL,
                      xlim = NULL, ylim = NULL, zlim = NULL, aspect = !add,
                      legend = TRUE, legend.zoom = 0.4, legend.width = 0.1,
                      legend.dim = 0.2, legend.lab = NULL, box = TRUE,
                      lab.breaks = NULL, lab.ticksize = 0.5, lab.dist = 3,
                      add = FALSE, ...) {
  # ············································································
  if (!requireNamespace("rgl", quietly = TRUE))
    stop("package 'rgl' is required")
  if (is.null(legend.lab)) legend.lab <- deparse(substitute(s))
  # set up (or add to) the continous legend
  if (legend) {
    splot3d(slim = slim, col = col, legend.zoom = legend.zoom, legend.width = legend.width,
            legend.dim = legend.dim, legend.lab = legend.lab, box = box,
            lab.breaks = lab.breaks, lab.ticksize = lab.ticksize, lab.dist = lab.dist)
  }
  scol <- scolor(s, col = col, slim = slim)
  rgl::persp3d(x, y, z, xlab = xlab, ylab = ylab, zlab = zlab, xlim = xlim,
               ylim = ylim, zlim = zlim, col = scol, add = add, aspect = aspect, ...)
} # spersp3d
