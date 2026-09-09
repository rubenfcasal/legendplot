# Image plot with a color scale

`simage` (generic function) draws an image (a grid of colored
rectangles) and (optionally) adds a legend strip with the color scale
(calls
[`splot`](https://rubenfcasal.github.io/legendplot/reference/splot.md)
and [`image`](https://rdrr.io/r/graphics/image.html)).

## Usage

``` r
simage(x, ...)

# Default S3 method
simage(
  x = seq(0, 1, len = nrow(s)),
  y = seq(0, 1, len = ncol(s)),
  s,
  slim = range(s, finite = TRUE),
  col = jet.colors(128),
  breaks = NULL,
  legend = TRUE,
  horizontal = FALSE,
  legend.shrink = 0.8,
  legend.width = 1.2,
  legend.mar = ifelse(horizontal, 3.1, 5.1),
  legend.lab = NULL,
  bigplot = NULL,
  smallplot = NULL,
  lab.breaks = NULL,
  axis.args = NULL,
  legend.args = NULL,
  reset = TRUE,
  xlab = NULL,
  ylab = NULL,
  asp = NA,
  ...
)
```

## Arguments

- x:

  grid values for `x` coordinate. If `x` is a list, its components `x$x`
  and `x$y` are used for `x` and `y`, respectively. For compatibility
  with [`image`](https://rdrr.io/r/graphics/image.html), if the list has
  component `z` this is used for `s`.

- ...:

  additional graphical parameters (to be passed to
  [`image`](https://rdrr.io/r/graphics/image.html) or `simage.default`;
  e.g. `xlim, ylim,` ...). NOTE: graphical arguments passed here will
  only have impact on the main plot. To change the graphical defaults
  for the legend use the [`par`](https://rdrr.io/r/graphics/par.html)
  function beforehand (e.g. `par(cex.lab = 2)` to increase colorbar
  labels).

- y:

  grid values for `y` coordinate.

- s:

  matrix containing the values to be used for coloring the rectangles
  (NAs are allowed). Note that `x` can be used instead of `s` for
  convenience.

- slim:

  limits used to set up the color scale.

- col:

  color table used to set up the color scale (see
  [`image`](https://rdrr.io/r/graphics/image.html) for details).

- breaks:

  (optional) numeric vector with the breakpoints for the color scale:
  must have one more breakpoint than `col` and be in increasing order.

- legend:

  logical; if `TRUE` (default), the plotting region is splitted into two
  parts, drawing the image plot in one and the legend with the color
  scale in the other. If `FALSE` only the image plot is drawn and the
  arguments related to the legend are ignored
  ([`splot`](https://rubenfcasal.github.io/legendplot/reference/splot.md)
  is not called).

- horizontal:

  logical; if `FALSE` (default) legend will appear on the right side. If
  `TRUE` the legend will be along the bottom.

- legend.shrink:

  amount to shrink the size of legend relative to the full height or
  width of the plot.

- legend.width:

  width in characters of the legend strip. Default is 1.2, a little
  bigger that the width of a character.

- legend.mar:

  width in characters of legend margin that has the axis. Default is 5.1
  for a vertical legend and 3.1 for a horizontal legend.

- legend.lab:

  label for the axis of the color legend. Default is no label as this is
  usual evident from the plot title.

- bigplot:

  plot coordinates for main plot. If not passed these will be determined
  within the function.

- smallplot:

  plot coordinates for legend strip. If not passed these will be
  determined within the function.

- lab.breaks:

  if breaks are supplied these are text string labels to put at each
  break value. This is intended to label axis on a transformed scale
  such as logs.

- axis.args:

  additional arguments for the axis function used to create the legend
  axis (see
  [`image.plot`](https://rdrr.io/pkg/fields/man/image.plot.html) for
  details).

- legend.args:

  arguments for a complete specification of the legend label. This is in
  the form of list and is just passed to the
  [`mtext`](https://rdrr.io/r/graphics/mtext.html) function. Usually
  this will not be needed (see
  [`image.plot`](https://rdrr.io/pkg/fields/man/image.plot.html) for
  details).

- reset:

  logical; if `FALSE` the plotting region (`par("plt")`) will not be
  reset to make it possible to add more features to the plot (e.g. using
  functions such as points or lines). If `TRUE` (default) the plot
  parameters will be reset to the values before entering the function.

- xlab:

  label for the x axis, defaults to a description of `x`.

- ylab:

  label for the y axis, defaults to a description of `y`.

- asp:

  the y/x aspect ratio, see
  [`plot.window()`](https://rdrr.io/r/graphics/plot.window.html).

## Value

Invisibly returns a list with the following 3 components:

- bigplot:

  plot coordinates of the main plot. These values may be useful for
  drawing a plot without the legend that is the same size as the plots
  with legends.

- smallplot:

  plot coordinates of the secondary plot (legend strip).

- old.par:

  previous graphical parameters (`par(old.par)` will reset plot
  parameters to the values before entering the function).

## Side Effects

If `reset = TRUE`, the plotting region (`[par]("plt")`) may be changed
after exiting, to make it possible to add more features to the plot
(setting `reset = FALSE` prevents this).

## See also

[`splot`](https://rubenfcasal.github.io/legendplot/reference/splot.md),
[`spoints`](https://rubenfcasal.github.io/legendplot/reference/spoints.md),
[`spersp`](https://rubenfcasal.github.io/legendplot/reference/spersp.md),
[`image`](https://rdrr.io/r/graphics/image.html),
[`image.plot`](https://rdrr.io/pkg/fields/man/image.plot.html).

## Author

Based on [`image.plot`](https://rdrr.io/pkg/fields/man/image.plot.html)
function from package fields: fields, Tools for spatial data. Copyright
2004-2013, Institute for Mathematics Applied Geosciences. University
Corporation for Atmospheric Research.

Modified by Ruben Fernandez-Casal <rubenfcasal@gmail.com>.

## Examples

``` r
# Regularly spaced 2D data
nx <- c(40, 40) # ndata =  prod(nx)
x1 <- seq(-1, 1, length.out = nx[1])
x2 <- seq(-1, 1, length.out = nx[2])
trend <- outer(x1, x2, function(x,y) x^2 - y^2)
simage( x1, x2, trend, main = 'Trend')
```
