#····································································
#   fpoints3d.R (legendplot package)
#····································································
#   fpoints3d
#
#   (c) Ruben Fernandez-Casal
#   Created: Aug 2026, Modified:
#
#   NOTE: Press Ctrl + Shift + O to show document outline in RStudio
#····································································

# ··············································································
# fpoints3d ----
# ··············································································

#' 3D scatter plot with a categorical legend
#'
#' A generic function that, by default, draws a 3D scatter plot ([rgl::plot3d()])
#' with points colored according to the levels of a factor `f`, and (optionally)
#' adds a categorical legend (via [fplot3d()]).
#'
#' @export
# ··············································································
fpoints3d <- function(x, ...) UseMethod("fpoints3d")
# S3 generic function fpoints3d
# ··············································································

# ··············································································
# fpoints3d S3 methods ----
# ··············································································
#' @rdname fpoints3d
#' @method fpoints3d default
#' @inheritParams fplot3d
#' @param x object used to select a method. In the default method, it provides the `x`
#'   coordinates for the plot (and optionally the `y` and `z` coordinates;
#'   any reasonable way of defining the coordinates is acceptable,
#'   see the function [xyz.coords()] for details).
#' @param y,z `y` and `z` point coordinates. Alternatively, a single argument `x`
#'   can be provided.
#' @param f (factor, or vector coercible to factor), used to color the points.
#' @param col vector of colors associated with each level of `f` (defaults to
#'   `hcld.colors(nlevels(f))`).
#' @param xlab,ylab,zlab 	labels for the coordinates.
#' @param type character indicating the type of item to plot (see
#'   [rgl::plot3d()]: `"p"` for points, `"s"` for spheres, `"l"` for lines,
#'   `"h"` for line segments from z = 0, and `"n"` for nothing).
#' @param legend logical; if `TRUE` (default), the active rgl device is splitted
#'   into two subscenes, drawing the main plot in one and the categorical
#'   legend in the other (see [fplot3d()]).
#'   if `FALSE` only the (coloured) main plot is drawn and the arguments related to
#'   the legend are ignored ([fplot3d()] is not called).
#' @param legend.type character; symbol/object used to represent each
#'   level in the legend (see `type` in [fplot3d()]): `"s"` for spheres
#'   (default), `"c"` for cubes, `"p"` for points, or `"l"` for
#'   (horizontal) line segments.
#' @param legend.lab label for the axis of the color legend, defaults to a
#'   description of `f`.
#' @param add logical; if `TRUE` the scatter plot is just added to the existing
#'   plot (including the legend if `legend = TRUE`).
#' @param ... additional arguments passed to [rgl::plot3d()] for the main
#'   scatter plot (e.g. `size`).
#'
#' @return
#' Called for its side effect (draws the 3D scatter plot and, unless
#' `legend = FALSE`, the legend on the active rgl device).
#'
#' @seealso [spoints3d()], [fplot3d()], [fcolor()], [fshade3d()], [rgl::plot3d()].
#'
#' @examples
#' library(rgl)
#' open3d() # Alternatively, use `new3d()` to clear the current device or open a new one
#' with(mtcars, fpoints3d(hp, qsec, mpg, f = cyl, type = "s"))
#'
#' @export
# ··············································································
fpoints3d.default <- function(x, y = NULL, z = NULL, f, col = hcld.colors(nlevels(f)),
                      xlab = NULL, ylab = NULL, zlab = NULL, type = "p",
                      legend = TRUE, legend.type = c("s", "c", "p", "l"),
                      legend.zoom = 0.6, legend.width = 0.2, legend.size = 4,
                      legend.dim = 0.2, legend.lab = NULL, lab.dist = 2.5,
                      lab.rev = FALSE, add = FALSE, ...) {
  # ············································································
  if (!requireNamespace("rgl", quietly = TRUE))
    stop("package 'rgl' is required")
  if (missing(f))
    stop("argument 'f' (grouping factor) must be provided")
  if (is.null(legend.lab)) legend.lab <- deparse(substitute(f))
  f <- as.factor(f)
  labels <- levels(f)
  legend.type <- match.arg(legend.type)
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
  # set up (or add to) the categorical legend
  if (legend) {
    fplot3d(labels = labels, col = col, type = legend.type, legend.zoom = legend.zoom,
            legend.width = legend.width, legend.size = legend.size,
            legend.dim = legend.dim, legend.lab = legend.lab,
            lab.dist = lab.dist, lab.rev = lab.rev)
  }
  # fcol <- fcolor(f, col = col, labels = labels)
  rgl::plot3d(xyz, xlab = xlab, ylab = ylab, zlab = zlab, type = type,
              col = col[f], add = add, ...)
} # fpoints3d
