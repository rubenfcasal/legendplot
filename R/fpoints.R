#····································································
#   fpoints.R (legendplot package)
#····································································
#   fpoints S3 generic
#     fpoints.default
#
#   Categorical counterpart of `spoints()`: draws a scatter plot with points
#   colored according to a factor and adds a categorical legend (calls
#   `fplot()` and `plot.default()` or `points()`).
#
#   (c) R. Fernandez-Casal
#   Created: Jul 2026
#
#   NOTE: Press Ctrl + Shift + O to show document outline in RStudio
#····································································

#····································································
# fpoints ----
#····································································
#' Scatter plot with a categorical legend
#'
#' A generic function that, by default, draws a scatter plot with
#' points colored according to a factor `f` and  (optionally) adds a categorical
#' legend (`fpoints.default()` calls [fplot()] and [plot.default()], or
#' [plot.xy()] if `add = TRUE`).
#'
#' @seealso
#' [fplot()], [fcolor()], [hcld.colors()], [plot.default()], [spoints()].
#'
#' @section Side Effects:
#' If `reset = FALSE`, the plotting region (`par("plt")`) may be changed
#' after exiting, to make it possible to add more features to the plot.
#' They can be restored using the `old.par` returned values or by calling
#' function [par.reset()].
#'
#' @keywords hplot
#' @export
#····································································
fpoints <- function(x, ...) UseMethod("fpoints")
# S3 generic function fpoints

#····································································
# fpoints S3 methods ----
#····································································

#' @rdname fpoints
#' @method fpoints default
#' @inheritParams spoints
#' @inheritParams fplot
#' @param f (factor, or vector coercible to factor), with length equal to the
#'   number of points, giving the group of each point.
#' @param col colors associated with each level of `f` Defaults to `hcld.colors()`.
#' @param type character indicating the type of plotting; actually any of the
#'   types as in [plot.default()].
#' @param legend.type type of symbols shown in the legend: `"box"` for filled
#'   color boxes (as in a classic factor-level legend), `"point"` for points, or
#'   `"line"` for line segments (see [fplot()]).
#' @param legend.pch,legend.cex plotting character and size used in the legend
#'   when `legend.type = "point"`.
#' @param legend.lty,legend.lwd line type and width used in the legend
#'   when `legend.type = "line"`.
#' @param legend logical; if `TRUE` (default), the plotting region is
#'   splitted into two parts, drawing the scatter plot in one and the
#'   categorical legend in the other. If `FALSE` only the (coloured)
#'   scatter plot is drawn and the legend-related arguments are ignored
#'   ([fplot()] is not called).
#' @param legend.lab label for the axis of the color legend, defaults to a
#'   description of `f`.
#' @param ... additional graphical parameters (to be passed to the main plot function
#'   or to `fpoints.default()`; e.g. `xlim, ylim,` ...). NOTE:
#'   graphical arguments passed here will only have impact on the main plot.
#'   To change the graphical defaults for the legend use the [par()]
#'   function beforehand.
#' @return
#' `fplot()` invisibly returns a list with components: `bigplot`, `smallplot`,
#' `old.par`, `col` and `labels` (`par(old.par)` will reset plot
#' parameters to the values before entering the function).
#' @examples
#' with(mtcars,
#'     fpoints(hp, qsec, f = cyl, main = "Motor Trend Car Road Tests")
#' )
#'
#' @export
#····································································
fpoints.default <- function(x, y = NULL, f, col = hcld.colors(f), type = "p",
    cex = 1.5, pch = 16, legend = TRUE, legend.type = c("point", "box", "line"),
    legend.pch = pch, legend.cex = 1, legend.lty = 1, legend.lwd = 2,
    border = col, pt.cex = cex, seg.len = 1.5, horizontal = FALSE,
    legend.shrink = 1, legend.width = NULL, legend.mar = NULL, legend.lab = NULL,
    legend.x = "center", bigplot = NULL, smallplot = NULL, add = FALSE,
    reset = TRUE, xlab = NULL, ylab = NULL, asp = NA, ...) {
#····································································
  if (missing(f))
    stop("argument 'f' (grouping factor) must be provided")
  if (is.null(legend.lab)) legend.lab <- deparse(substitute(f))
  f <- as.factor(f)
  legend.type <- match.arg(legend.type)
  xlabel <- if (!missing(x)) deparse(substitute(x))
  ylabel <- if (!missing(y)) deparse(substitute(y))
  xy <- xy.coords(x, y, xlabel, ylabel)
  if (is.null(xlab)) xlab <- xy$xlab
  if (is.null(ylab)) ylab <- xy$ylab
  # if (length(f) != length(xy$x))
  #   stop("length of 'f' must be equal to the number of points")
  labels <- levels(f)
  # set up (or add to) the categorical legend
  if (legend) {
    res <- fplot(labels, col = col, type = legend.type, pch = legend.pch,
                 lty = legend.lty, lwd = legend.lwd, cex = legend.cex,
                 border = border, pt.cex = pt.cex, seg.len = seg.len,
                 horizontal = horizontal, legend.shrink = legend.shrink,
                 legend.width = legend.width, legend.mar = legend.mar,
                 legend.lab = legend.lab, legend.x = legend.x,
                 bigplot = bigplot, smallplot = smallplot, add = FALSE)
  } else {
    if (is.null(bigplot)) {
      old.par <- list(plt = par("plt")) # par(no.readonly = TRUE)
      bigplot <- old.par$plt
    } else {
      old.par <- par(plt = bigplot)
      .par.reset.save(old.par)
    }
    res <- list(bigplot = bigplot, smallplot = NA, old.par = old.par,
                col = col, labels = labels)
  }
  if (reset) on.exit(par(res$old.par))
  # one color per point, following the group of each point
  colv <- fcolor(f, col = res$col)
  if (add) {
    plot.xy(xy, type = type, col = colv, pch = pch, cex = cex, ...)
  } else
    plot(xy, type = type, col = colv, pch = pch, cex = cex, xlab = xlab,
         ylab = ylab, asp = asp, ...)
  return(invisible(res))
#····································································
} # fpoints.default
