# Scatter plot with a color scale

A generic function that, by default, draws a scatter plot with points
filled with different colors and (optionally) adds a legend strip with
the color scale (`spoints.default()` calls
[`splot()`](https://rubenfcasal.github.io/legendplot/reference/splot.md)
and [`plot.default()`](https://rdrr.io/r/graphics/plot.default.html), or
[`plot.xy()`](https://rdrr.io/r/graphics/plot.xy.html) if `add = TRUE`).

## Usage

``` r
spoints(x, ...)

# Default S3 method
spoints(
  x,
  y = NULL,
  s,
  slim = range(s, finite = TRUE),
  col = jet.colors(128),
  breaks = NULL,
  type = "p",
  legend = TRUE,
  horizontal = FALSE,
  legend.shrink = 1,
  legend.width = 1.2,
  legend.mar = ifelse(horizontal, 3.1, 5.1),
  legend.lab = NULL,
  bigplot = NULL,
  smallplot = NULL,
  lab.breaks = NULL,
  axis.args = NULL,
  legend.args = NULL,
  add = FALSE,
  reset = TRUE,
  pch = 16,
  cex = 1.5,
  xlab = NULL,
  ylab = NULL,
  asp = NA,
  ...
)
```

## Arguments

- x:

  object used to select a method. In the default method, it provides the
  `x` coordinates for the plot (and optionally the `y` coordinates; any
  reasonable way of defining the coordinates is acceptable, see the
  function [`xy.coords()`](https://rdrr.io/r/grDevices/xy.coords.html)
  for details).

- ...:

  additional graphical parameters (to be passed to the main plot
  function or to `spoints.default()`; e.g. `xlim, ylim,` ...). NOTE:
  graphical arguments passed here will only have impact on the main
  plot. To change the graphical defaults for the legend use the
  [`par()`](https://rdrr.io/r/graphics/par.html) function beforehand
  (e.g. `par(cex.lab = 2)` to increase colorbar labels).

- y:

  y coordinates. Alternatively, a single argument `x` can be provided.

- s:

  numerical vector containing the values used for coloring the points.

- slim:

  limits used to set up the color scale.

- col:

  color table used to set up the color scale (see
  [`image`](https://rdrr.io/r/graphics/image.html) for details).

- breaks:

  (optional) numeric vector with the breakpoints for the color scale:
  must have one more breakpoint than `col` and be in increasing order.

- type:

  character indicating the type of plotting; actually any of the types
  as in
  [`plot.default()`](https://rdrr.io/r/graphics/plot.default.html).

- legend:

  logical; if `TRUE` (default), the plotting region is splitted into two
  parts, drawing the main plot in one and the legend with the color
  scale in the other. If `FALSE` only the (coloured) main plot is drawn
  and the arguments related to the legend are ignored
  ([`splot()`](https://rubenfcasal.github.io/legendplot/reference/splot.md)
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

  label for the axis of the color legend, defaults to a description of
  `s`.

- bigplot:

  plot coordinates for main plot. If not passed, and `legend` is TRUE,
  these will be determined within the function.

- smallplot:

  plot coordinates for legend strip. If not passed, and `legend` is
  TRUE, these will be determined within the function.

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

- add:

  logical; if `TRUE` the scatter plot is just added to the existing plot
  (including the legend if `legend = TRUE`, although the graphical
  parameters are not modified).

- reset:

  logical; if `FALSE` the plotting region (`par("plt")`) will not be
  reset to make it possible to add more features to the plot (e.g. using
  functions such as points or lines). If `TRUE` (default) the plot
  parameters will be reset to the values before entering the function.

- pch:

  vector of plotting characters or symbols: see
  [`points()`](https://rdrr.io/r/graphics/points.html).

- cex:

  numerical vector giving the amount by which plotting characters and
  symbols should be scaled relative to the default. This works as a
  multiple of `par("cex")`.

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

If `reset = FALSE`, the plotting region (`par("plt")`) may be changed
after exiting, to make it possible to add more features to the plot. The
graphical parameters can be restored using the `old.par` returned values
or by calling function
[`par.reset()`](https://rubenfcasal.github.io/legendplot/reference/par.reset.md).

## See also

[`splot()`](https://rubenfcasal.github.io/legendplot/reference/splot.md),
[`simage()`](https://rubenfcasal.github.io/legendplot/reference/simage.md),
[`spersp()`](https://rubenfcasal.github.io/legendplot/reference/spersp.md),
[`image()`](https://rdrr.io/r/graphics/image.html),
[`fields::image.plot()`](https://rdrr.io/pkg/fields/man/image.plot.html),
[`plot.default()`](https://rdrr.io/r/graphics/plot.default.html),
[`fpoints()`](https://rubenfcasal.github.io/legendplot/reference/fpoints.md).

## Author

Based on [`image.plot`](https://rdrr.io/pkg/fields/man/image.plot.html)
function from package fields: fields, Tools for spatial data. Copyright
2004-2013, Institute for Mathematics Applied Geosciences. University
Corporation for Atmospheric Research.

Modified by Ruben Fernandez-Casal <rubenfcasal@gmail.com>.

## Examples

``` r
with(mtcars,
    spoints(hp, qsec, mpg, main = "Motor Trend Car Road Tests")
)
```
