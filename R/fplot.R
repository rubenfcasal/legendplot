#····································································
#   fplot.R (legendplot package)
#····································································
#   fplot
#   fcolor
#   hcld.colors
#   cat.colors
#
#   (c) Ruben Fernandez-Casal
#   Created: Jul 2026, Modified:
#
#   NOTE: Press Ctrl + Shift + O to show document outline in RStudio
#····································································

#' Add a categorical legend to an standard R plot
#'
#' `fplot()` is designed to combine a standard R plot with a categorical (factor) legend.
#' Analogous to [splot()], splits the plotting region into a main panel and a
#' legend panel, and uses [legend()] to draw the labels with their colors and symbols.
#'
# For instance, `fxxxx()` functions ([spoints()], [fmatplot()]
# and [fbarplot()]) draw the corresponding high-level plot (`xxxx()`),
# after calling `fplot()`, to include a categorical legend.
#
#' @inheritParams splot
#' @param labels vector with the category labels.
#' @param col colors associated with each level (same order as `labels`).
#'   Defaults to `hcld.colors()`.
#' @param type type of symbols shown in the legend: `"box"` for filled
#'   color boxes (as in a classic factor-level legend), `"point"` for points, or
#'   `"line"` for line segments.
#' @param pch plotting ‘character’ (symbol) used when `type = "point"`.
#' @param lty,lwd line types and widths for lines appearing in the legend,
#'   when `type = "line"`.
#' @param legend.width,legend.mar control the size and margin of the legend
#'   panel, as in [splot()]. If left as `NULL` (default), they are computed
#'   automatically following the same character-size logic that [legend()]
#'   itself uses internally.
#' @param legend.lab legend title.
#' @param legend.x legend location relative to the legend panel (argument `x`
#'   of [legend()]). Possible values are: `"center"` (default), `"bottomright"`,
#'   `"bottom"`, `"bottomleft"`, `"left"`, `"topleft"`, `"top"`, `"topright"` or `"right"`.
#' @param cex text/symbol size in the legend.
#' @param border,pt.cex,seg.len additional [legend()] parameters,
#'   also used to estimate the required legend width/height.
#'   The default values are: `border = col`, `pt.cex = cex * 1.5` and `seg.len = 1.5`.
#' @param bigplot,smallplot plot coordinates for main and legend panels.
#'   If not passed these will be determined within the function.
#' @param ... additional arguments passed to [legend()].
#' @section Side Effects:
#' The plotting region (`par("plt")`) may be changed
#' after exiting, to make it possible to add more features to the plot.
#' They can be restored using the `old.par` returned values or by calling
#' function [par.reset()].
#' @return
#' `fplot()` invisibly returns a list with components: `bigplot`,
#' `smallplot`, `old.par`, `col` and `labels` (`par(old.par)` will reset plot
#' parameters to the values before entering the function).
#' @seealso
#' [legend()], [fcolor()], [hcld.colors()], [cat.colors()], [fpoints()].
#' @examples
#' # Plot equivalent to fpoints():
#' f <- as.factor(mtcars$cyl)
#' res <- fplot(levels(f), col = cat.colors(f), type = "point",
#'              legend.lab = "cyl")
#' with(mtcars,
#'     plot(hp, qsec, col = fcolor(f, col = res$col),
#'          pch = 16, cex = 1.5, main = "Motor Trend Car Road Tests")
#' )
#' par(res$old.par) # restore graphical parameters
#'
#' @export
#····································································
fplot <- function(labels, col = hcld.colors(length(labels)),
     type = c("box", "point", "line"), pch = 16, lty = 1, lwd = 2, cex = 1,
     border = col, pt.cex = cex * 1.5, seg.len = 1.5,
     horizontal = FALSE, legend.shrink = 1, legend.width = NULL, legend.mar = NULL,
     legend.lab = NULL,  legend.x = "center",
     bigplot = NULL, smallplot = NULL, add = FALSE, ...) {
#····································································
  type <- match.arg(type)
  labels <- as.character(labels)
  nlev <- length(labels)
  if (length(col) < nlev)
      stop("'col' must have at least length(labels) colors")
  col <- col[seq_len(nlev)]

  # save current graphical settings
  old.par <- par(c("plt", "new", "pty", "err", "xpd")) # par(no.readonly = TRUE)
  .par.reset.save(old.par)
  if (add) bigplot <- old.par$plt

  # default swatch arguments depending on type; border/pt.cex/seg.len/
  # fill let the user override them without using '...'
  type.args <- switch(type,
    box   = list(fill = col, border = border),
    point = list(pch = pch, col = col, pt.cex = pt.cex),
    line  = list(lty = lty, lwd = lwd, col = col, seg.len = seg.len)
  )
  base.args <- list(x = legend.x, legend = labels, bty = "n", cex = cex,
                    title = legend.lab, horiz = horizontal, xpd = TRUE)

  # combine base + type-specific arguments, then apply '...', which
  # takes priority and can override any of them.
  # Note that the estimated legend size depends on these values (cex, title, pt.cex...).
  legend.args <- utils::modifyList(utils::modifyList(base.args, type.args),
                                   list(...))
  # legend.args <- utils::modifyList(base.args, type.args)

  # estimate the size (in inches) the legend will occupy, using
  # the same character-size logic legend() uses internally: cin/cex
  # for character size, ~1.2 line spacing, a "swatch" width depending
  # on the type (box/point/line), a spacing gap, and the widest text/title
  eff.cex   <- if (!is.null(legend.args$cex)) legend.args$cex else cex
  eff.title <- legend.args$title
  eff.ptcex <- if (!is.null(legend.args$pt.cex)) legend.args$pt.cex else eff.cex * 1.5
  eff.segln <- if (!is.null(legend.args$seg.len)) legend.args$seg.len else 1.5

  cin <- par("cin"); din <- par("din")  # character and device size, in inches
  xc  <- cin[1] * eff.cex               # character width at the effective cex
  yc  <- cin[2] * eff.cex * 1.2         # line height at the effective cex (~1.2 factor, as legend())

  text.w  <- max(strwidth(labels, units = "inches", cex = eff.cex))
  title.w <- if (!is.null(eff.title))
      strwidth(eff.title, units = "inches", cex = eff.cex) else 0

  swatch.w <- switch(type,
    box   = 2 * xc,
    point = 1.2 * xc * (eff.ptcex / eff.cex),
    line  = eff.segln * xc
  )
  gap.w <- xc               # gap between the swatch and the text
  pad.w <- 0.5 * xc         # left/right inner padding

  width.in  <- swatch.w + gap.w + max(text.w, title.w) + pad.w
  height.in <- (if (!is.null(eff.title)) yc else 0) + 0.5 * yc
  if (!horizontal) height.in <- height.in + nlev * yc

  # cap the crosswise size of the legend (width for a vertical legend,
  # height for a horizontal one) to a fraction of the space currently
  # available, so that the estimated size can never produce an invalid
  # (non-increasing) 'bigplot' region on small devices
  avail.in <- if (horizontal)
      (old.par$plt[4] - old.par$plt[3]) * din[2]
  else
      (old.par$plt[2] - old.par$plt[1]) * din[1]
  if (horizontal)
      height.in <- min(height.in, 0.5 * avail.in)
  else
      width.in <- min(width.in, 0.5 * avail.in)

  if (is.null(legend.width))
      legend.width <- (if (horizontal) height.in else width.in) / cin[1] * 1.1
  if (is.null(legend.mar))
      legend.mar <- 1

  # split the plotting region into main panel and legend strip
  temp <- plt.plot(horizontal = horizontal, legend.shrink = legend.shrink,
                   legend.width = legend.width, legend.mar = legend.mar,
                   bigplot = bigplot, smallplot = smallplot, stick = TRUE)
  smallplot <- temp$smallplot
  bigplot   <- temp$bigplot

  if (!add) {
    par(plt = bigplot)
    plot.new() # box()
    big.par <- par(c("plt", "new", "pty", "err", "xpd")) # par(no.readonly = TRUE)
  }

  # check dimensions of smallplot
  if ((smallplot[2] < smallplot[1]) || (smallplot[4] < smallplot[3])) {
    par(old.par)
    stop("plot region too small to add legend\n")
  }

  # activate the legend strip as the current drawing region
  par(new = TRUE, pty = "m", plt = smallplot, err = -1)
  plot.new() # box()
  do.call(legend, legend.args)

  # clean up graphics device settings
  # reset to larger plot region with right user coordinates.
  if (add) {
    par(old.par)
    par(new = FALSE)
  } else {
    par(big.par)
    par(plt = big.par$plt, xpd = FALSE)
    par(pty = "m", new = TRUE, err = -1)
  }

  return(invisible(list(bigplot = bigplot, smallplot = smallplot, old.par = old.par,
                  col = col, labels = labels)))
#····································································
} # fplot


#····································································
# categorical-color ----
#····································································

#' @name categorical-color
#' @title
#' Utilities for plotting with a categorical legend
#' @description
#' `hcld.colors()` and `hot.colors()` create a color table useful for
#' coding qualitative information and `fcolor()` assigns colors to categorical
#' (factor) values.
#'
#' @inheritParams fplot
#' @param f (factor, or vector coercible to factor) values to be converted to colors.
#' @param col colors for each level. Defaults to `hcld.colors()`.
#' @param labels levels to use. Defaults to `levels(as.factor(f))`.
#'
#' @return
#' `fcolor()` returns vector of colors, one per element of `f`.
#' `hcld.colors()` and `cat.colors()` return a character vector of colors (similar to
#' `hcl.colors()` or `rainbow()`; see `rgb()`).
#' @export
# f <- group; levels = levels(f); col = NULL
#····································································
fcolor <- function(f, col = hcld.colors(length(labels)), labels = levels(as.factor(f))) {
#····································································
  f <- if(!missing(labels)) factor(f, levels = labels) else as.factor(f)
  if (length(col) < length(labels))
      stop("'col' must have at least nlevels(f) colors")
  col[as.integer(f)]
}


#' @keywords internal
.nfcolors <- function(x) {
  if (length(x) == 1L && is.numeric(x) && is.finite(x) &&
      x >= 1) x else nlevels(as.factor(x))
}


#' @rdname categorical-color
#' @param n number of colors (`>= 1`) to be in the palette, or vector
#' coercible to factor, in which case `n = nlevels(as.factor(n))`
#' @param palette a valid palette name for `hcl.colors()` (one of `hcl.pals()`).
#' @export
#····································································
hcld.colors <- function(n, palette = "Dark 3", ...) {
  n <- .nfcolors(n)
  grDevices::hcl.colors(n, palette = palette, ...)
}


#' @rdname categorical-color
#' @export
#····································································
cat.colors <- function(n) {
  n <- .nfcolors(n)
  # https://colorbrewer2.org/#type=qualitative&scheme=Accent&n=12
  rep(c('#a6cee3','#1f78b4','#b2df8a','#33a02c','#fb9a99','#e31a1c',
        '#fdbf6f','#ff7f00','#cab2d6','#6a3d9a','#ffff99','#b15928'),
      length.out = n)
}


