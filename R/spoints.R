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
#   Created: Mar 2014, Modified: Apr 2023
#
#   NOTE: Press Ctrl + Shift + O to show document outline in RStudio
#····································································



#····································································
# spoints ----
#····································································
#' Scatter plot with a color scale
#'
#' \code{spoints} (generic function) draws a scatter plot with points filled with different colors
#' and (optionally) adds a legend strip with the color scale
#' (calls \code{\link{splot}} and \code{\link{plot.default}}).
#'
#' @return Invisibly returns a list with the following 3 components:
#' \item{bigplot}{plot coordinates of the main plot. These values may be useful for
#' drawing a plot without the legend that is the same size as the plots with legends.}
#' \item{smallplot}{plot coordinates of the secondary plot (legend strip).}
#' \item{old.par}{previous graphical parameters (\code{par(old.par)}
#' will reset plot parameters to the values before entering the function).}
#'
#' @section Side Effects: If `reset = TRUE`, the plotting region (`[par]("plt")`)
#' may be changed after exiting, to make it possible to add more features to the
#' plot (setting `reset = FALSE` prevents this).
#'
#' @seealso \code{\link{splot}}, \code{\link{simage}}, \code{\link{spersp}},
#' \code{\link{image}}, \code{\link[fields]{image.plot}},
#' \code{\link{plot.default}}.
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
#' @param x object used to select a method. In the default method, it provides the \code{x}
#' coordinates for the plot (and optionally the \code{y} coordinates;
#' any reasonable way of defining the coordinates is acceptable,
#' see the function \code{\link{xy.coords}} for details).
#' @param y y coordinates. Alternatively, a single argument \code{x} can be provided.
#' @param s numerical vector containing the values used for coloring the points.
#' @param legend logical; if \code{TRUE} (default), the plotting region is splitted into two parts,
#' drawing the main plot in one and the legend with the color scale in the other.
#' If \code{FALSE} only the (coloured) main plot is drawn and the arguments related
#' to the legend are ignored (\code{\link{splot}} is not called).
#' @param bigplot plot coordinates for main plot. If not passed, and \code{legend}
#' is TRUE, these will be determined within the function.
#' @param smallplot plot coordinates for legend strip. If not passed, and \code{legend}
#' is TRUE, these will be determined within the function.
#' @param add logical; if \code{TRUE} the scatter plot is just added
#' to the existing plot.
#' @param reset logical; if \code{FALSE} the plotting region
#' (\code{\link{par}("plt")}) will not be reset to make it possible to add more features
#' to the plot (e.g. using functions such as points or lines). If \code{TRUE} (default)
#' the plot parameters will be reset to the values before entering the function.
#' @param pch vector of plotting characters or symbols: see \code{\link{points}}.
#' @param cex numerical vector giving the amount by which plotting characters
#' and symbols should be scaled relative to the default. This works as a multiple
#' of \code{\link{par}("cex")}.
#' @param xlab label for the x axis.
#' @param ylab label for the y axis.
#' @param asp the y/x aspect ratio, see \code{\link{plot.window}}.
#' @param ... additional graphical parameters (to be passed to the main plot function
#' or to \code{sxxxx.default}; e.g. \code{xlim, ylim,} ...). NOTE:
#' graphical arguments passed here will only have impact on the main plot.
#' To change the graphical defaults for the legend use the \code{\link{par}}
#' function beforehand (e.g. \code{par(cex.lab = 2)} to increase colorbar labels).
#' @inheritParams splot
#' @keywords hplot
#' @examples
#' with( mtcars, spoints(hp, qsec, mpg, main = "Motor Trend Car Road Tests",
#'       xlab = "hp", ylab = "qsec", legend.lab = "mpg"))
#' @export
#····································································
# Pendiente:
# @param xlab label for the x axis, defaults to a description of \code{x}.
# @param ylab label for the y axis, defaults to a description of \code{y}.
#····································································
spoints.default <- function(x, y = NULL, s, slim = range(s, finite = TRUE), col = jet.colors(128),
    breaks = NULL, legend = TRUE, horizontal = FALSE, legend.shrink = 1.0,
    legend.width = 1.2, legend.mar = ifelse(horizontal, 3.1, 5.1), legend.lab = NULL,
    bigplot = NULL, smallplot = NULL, lab.breaks = NULL, axis.args = NULL,
    legend.args = NULL, add = FALSE, reset = TRUE,
    pch = 16, cex = 1.5, xlab = NULL, ylab = NULL, asp = NA, ...) {
#····································································
    if (legend)
        # image in splot checks breaks and other parameters...
        res <- splot(slim = slim, col = col, breaks = breaks, horizontal = horizontal,
            legend.shrink = legend.shrink, legend.width = legend.width,
            legend.mar = legend.mar, legend.lab = legend.lab,
            bigplot = bigplot, smallplot = smallplot, lab.breaks = lab.breaks,
            axis.args = axis.args, legend.args = legend.args, add = add)
    else {
        if (missing(bigplot)) {
          old.par <- par(no.readonly = TRUE)
          bigplot <- old.par$plt
        } else
          old.par <- par(plt = bigplot)
          # old.par <- par(plt = bigplot, no.readonly = TRUE)
        # par(xpd = FALSE)
        res <- list(bigplot = bigplot, smallplot = NA, old.par = old.par)
    }
    if (add & !reset) {
        # Creo que realmente no haria falta...
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
    icol <- cut(as.numeric(s), breaks, labels = FALSE, include.lowest = TRUE, right = FALSE) # Use .bincode instead of cut?
    if (!add) {
        # x <- as.matrix(x) # No nec. matriz o data frame
        # ns <- colnames(x)
        # if (is.null(xlab) & !is.null(ns)) xlab <- ns[1]
        # if (is.null(ylab) & !is.null(ns)) ylab <- ns[2]
        plot(x, y, type = "p", pch = pch, cex = cex, col = col[icol], xlab = xlab, ylab = ylab, asp = asp, ...)
    } else
        points(x, y, pch = pch, cex = cex, col = col[icol], ...)
    # if (reset) par(res$old.par)
    return(invisible(res))
#····································································
}   # spoints


#····································································
# spoints S3 methods ----
#····································································


