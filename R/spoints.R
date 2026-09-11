#····································································
#   spoints.R (npsp package)
#····································································
#   spoints  S3 generic
#       spoints.default
#
#   Based on image.plot and drape.plot functions from package fields:
#   fields, Tools for spatial data
#   Copyright 2004-2013, Institute for Mathematics Applied Geosciences
#   University Corporation for Atmospheric Research
#   Licensed under the GPL -- www.gpl.org/licenses/gpl.html
#
#   (c) R. Fernandez-Casal
#   Created: Mar 2014, Modified: Jul 2026
#
#   NOTE: Press Ctrl + Shift + O to show document outline in RStudio
#····································································



#····································································
# spoints ----
#····································································
#' Scatter plot with a color scale
#'
#' A generic function that, by default, draws a scatter plot with points filled
#' with different colors and (optionally) adds a legend strip with the color scale
#' (`spoints.default()` calls [splot()] and [plot.default()], or [plot.xy()]
#' if `add = TRUE`).
#'
#' @return
#' Invisibly returns a list with the following 3 components:
#' \item{bigplot}{plot coordinates of the main plot. These values may be useful for
#' drawing a plot without the legend that is the same size as the plots with legends.}
#' \item{smallplot}{plot coordinates of the secondary plot (legend strip).}
#' \item{old.par}{previous graphical parameters (`par(old.par)`
#' will reset plot parameters to the values before entering the function).}
#'
#' @section Side Effects:
#' If `reset = FALSE`, the plotting region (`par("plt")`) may be changed after
#' exiting, to make it possible to add more features to the plot.
#  (`legend = TRUE`, `add = FALSE` and `is.null(bigplot) = FALSE`)
#' The graphical parameters can be restored using the `old.par` returned values
#' or by calling function [par.reset()].
#'
#' @seealso
#' [splot()], [simage()], [spersp()], [image()], [fields::image.plot()],
#' [plot.default()], [fpoints()].
#'
#' @author
#' Based on \code{\link[fields]{image.plot}} function from package \pkg{fields}:
#' fields, Tools for spatial data.
#' Copyright 2004-2013, Institute for Mathematics Applied Geosciences.
#' University Corporation for Atmospheric Research.
#'
#' Modified by Ruben Fernandez-Casal <rubenfcasal@@gmail.com>.
#' @keywords hplot
#' @export
#····································································
spoints <- function(x, ...) UseMethod("spoints")
# S3 generic function spoints
#····································································


#' @rdname spoints
#' @method spoints default
#' @param x object used to select a method. In the default method, it provides the `x`
#'   coordinates for the plot (and optionally the `y` coordinates;
#'   any reasonable way of defining the coordinates is acceptable,
#'   see the function [xy.coords()] for details).
#' @param y y coordinates. Alternatively, a single argument `x` can be provided.
#' @param s numerical vector containing the values used for coloring the points.
#' @param type character indicating the type of plotting; actually any of the
#'   types as in [plot.default()].
#' @param legend logical; if `TRUE` (default), the plotting region is splitted into two parts,
#'   drawing the main plot in one and the legend with the color scale in the other.
#'   If `FALSE` only the (coloured) main plot is drawn and the arguments related
#'   to the legend are ignored ([splot()] is not called).
#' @param legend.lab label for the axis of the color legend, defaults to a
#'   description of `s`.
#' @param bigplot plot coordinates for main plot. If not passed, and `legend`
#'   is TRUE, these will be determined within the function.
#' @param smallplot plot coordinates for legend strip. If not passed, and `legend`
#'   is TRUE, these will be determined within the function.
#' @param add logical; if `TRUE` the scatter plot is just added
#'   to the existing plot (including the legend if `legend = TRUE`, although the
#'   graphical parameters are not modified).
#' @param reset logical; if `FALSE` the plotting region
#'   (`par("plt")`) will not be reset to make it possible to add more features
#'   to the plot (e.g. using functions such as points or lines). If `TRUE` (default)
#'   the plot parameters will be reset to the values before entering the function.
#' @param pch vector of plotting characters or symbols: see [points()].
#' @param cex numerical vector giving the amount by which plotting characters
#'   and symbols should be scaled relative to the default. This works as a multiple
#'   of `par("cex")`.
#' @param xlab label for the x axis, defaults to a description of `x`.
#' @param ylab label for the y axis, defaults to a description of `y`.
#' @param asp the y/x aspect ratio, see [plot.window()].
#' @param ... additional graphical parameters (to be passed to the main plot function
#'   or to `spoints.default()`; e.g. `xlim, ylim,` ...). NOTE:
#'   graphical arguments passed here will only have impact on the main plot.
#'   To change the graphical defaults for the legend use the [par()]
#'   function beforehand (e.g. `par(cex.lab = 2)` to increase colorbar labels).
#' @inheritParams splot
#' @keywords hplot
#' @examples
#' with(mtcars,
#'     spoints(hp, qsec, mpg, main = "Motor Trend Car Road Tests")
#' )
#' @export
#····································································
spoints.default <- function(x, y = NULL, s, slim = range(s, finite = TRUE),
    col = jet.colors(128), breaks = NULL, type = "p",
    legend = TRUE, horizontal = FALSE, legend.shrink = 1.0,
    legend.width = 1.2, legend.mar = ifelse(horizontal, 3.1, 5.1), legend.lab = NULL,
    bigplot = NULL, smallplot = NULL, lab.breaks = NULL, axis.args = NULL,
    legend.args = NULL, add = FALSE, reset = TRUE,
    pch = 16, cex = 1.5, xlab = NULL, ylab = NULL, asp = NA, ...) {
#····································································
  xlabel <- if (!missing(x)) deparse(substitute(x))
  ylabel <- if (!missing(y)) deparse(substitute(y))
  xy <- xy.coords(x, y, xlabel, ylabel)
  if (is.null(xlab)) xlab <- xy$xlab
  if (is.null(ylab)) ylab <- xy$ylab
  if (legend){
      if (is.null(legend.lab)) legend.lab <- deparse(substitute(s))
      # image in splot checks breaks and other parameters...
      res <- splot(slim = slim, col = col, breaks = breaks, horizontal = horizontal,
          legend.shrink = legend.shrink, legend.width = legend.width,
          legend.mar = legend.mar, legend.lab = legend.lab,
          bigplot = bigplot, smallplot = smallplot, lab.breaks = lab.breaks,
          axis.args = axis.args, legend.args = legend.args, add = add)
  } else {
      if (is.null(bigplot)) {
        old.par <- list(plt = par("plt")) # par(no.readonly = TRUE)
        bigplot <- old.par$plt
      } else {
        old.par <- par(plt = bigplot)
        .par.reset.save(old.par)
      }
      # par(xpd = FALSE)
      res <- list(bigplot = bigplot, smallplot = NA, old.par = old.par)
  }
  if (add & !reset) {
      # Creo que realmente no haria falta...
      # !is.null(bigplot) equivaldría a incluir la leyenda con add = FALSE?
      warning("'reset' argument ignored when 'add = TRUE'")
      reset <- TRUE
  }
  if (reset) on.exit(par(res$old.par))
  if (is.null(breaks)) {
      # Compute breaks (in 'cut.default' style...)
      ds <- diff(slim)
      if (ds == 0) ds <- abs(slim[1L])
      breaks <- seq.int(slim[1L] - ds/1000, slim[2L] + ds/1000, length.out = length(col) + 1)
      # Only if !missing(slim) else breaks <- length(col) + 1?
  }
  icol <- cut(as.numeric(s), breaks, labels = FALSE, include.lowest = TRUE,
              right = FALSE) # Use .bincode instead of cut?
  if (!add) {
      plot(xy, type = type, pch = pch, cex = cex, col = col[icol], xlab = xlab,
           ylab = ylab, asp = asp, ...)
  } else
      plot.xy(xy, type = type, col = col[icol], pch = pch, cex = cex, ...)
  # if (reset) par(res$old.par)
  return(invisible(res))
#····································································
}   # spoints


#····································································
# spoints S3 methods ----
#····································································


