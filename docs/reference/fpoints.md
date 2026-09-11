# Scatter plot with a categorical legend

A generic function that, by default, draws a scatter plot with points
colored according to a factor `f` and (optionally) adds a categorical
legend (`fpoints.default()` calls
[`fplot()`](https://rubenfcasal.github.io/legendplot/reference/fplot.md)
and [`plot.default()`](https://rdrr.io/r/graphics/plot.default.html), or
[`plot.xy()`](https://rdrr.io/r/graphics/plot.xy.html) if `add = TRUE`).

## Usage

``` r
fpoints(x, ...)

# Default S3 method
fpoints(
  x,
  y = NULL,
  f,
  col = hcld.colors(f),
  type = "p",
  cex = 1.5,
  pch = 16,
  legend = TRUE,
  legend.type = c("point", "box", "line"),
  legend.pch = pch,
  legend.cex = 1,
  legend.lty = 1,
  legend.lwd = 2,
  border = col,
  pt.cex = cex,
  seg.len = 1.5,
  horizontal = FALSE,
  legend.shrink = 1,
  legend.width = NULL,
  legend.mar = NULL,
  legend.lab = NULL,
  legend.x = "center",
  bigplot = NULL,
  smallplot = NULL,
  add = FALSE,
  reset = TRUE,
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
  function or to `fpoints.default()`; e.g. `xlim, ylim,` ...). NOTE:
  graphical arguments passed here will only have impact on the main
  plot. To change the graphical defaults for the legend use the
  [`par()`](https://rdrr.io/r/graphics/par.html) function beforehand.

- y:

  y coordinates. Alternatively, a single argument `x` can be provided.

- f:

  (factor, or vector coercible to factor), with length equal to the
  number of points, giving the group of each point.

- col:

  colors associated with each level of `f` Defaults to
  [`hcld.colors()`](https://rubenfcasal.github.io/legendplot/reference/categorical-color.md).

- type:

  character indicating the type of plotting; actually any of the types
  as in
  [`plot.default()`](https://rdrr.io/r/graphics/plot.default.html).

- cex:

  numerical vector giving the amount by which plotting characters and
  symbols should be scaled relative to the default. This works as a
  multiple of `par("cex")`.

- pch:

  vector of plotting characters or symbols: see
  [`points()`](https://rdrr.io/r/graphics/points.html).

- legend:

  logical; if `TRUE` (default), the plotting region is splitted into two
  parts, drawing the scatter plot in one and the categorical legend in
  the other. If `FALSE` only the (coloured) scatter plot is drawn and
  the legend-related arguments are ignored
  ([`fplot()`](https://rubenfcasal.github.io/legendplot/reference/fplot.md)
  is not called).

- legend.type:

  type of symbols shown in the legend: `"box"` for filled color boxes
  (as in a classic factor-level legend), `"point"` for points, or
  `"line"` for line segments (see
  [`fplot()`](https://rubenfcasal.github.io/legendplot/reference/fplot.md)).

- legend.pch, legend.cex:

  plotting character and size used in the legend when
  `legend.type = "point"`.

- legend.lty, legend.lwd:

  line type and width used in the legend when `legend.type = "line"`.

- border, pt.cex, seg.len:

  additional [`legend()`](https://rdrr.io/r/graphics/legend.html)
  parameters, also used to estimate the required legend width/height.
  The default values are: `border = col`, `pt.cex = cex * 1.5` and
  `seg.len = 1.5`.

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
  `f`.

- legend.x:

  legend location relative to the legend panel (argument `x` of
  [`legend()`](https://rdrr.io/r/graphics/legend.html)). Possible values
  are: `"center"` (default), `"bottomright"`, `"bottom"`,
  `"bottomleft"`, `"left"`, `"topleft"`, `"top"`, `"topright"` or
  `"right"`.

- bigplot:

  plot coordinates for main plot. If not passed, and `legend` is TRUE,
  these will be determined within the function.

- smallplot:

  plot coordinates for legend strip. If not passed, and `legend` is
  TRUE, these will be determined within the function.

- add:

  logical; if `TRUE` the scatter plot is just added to the existing plot
  (including the legend if `legend = TRUE`, although the graphical
  parameters are not modified).

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

[`fplot()`](https://rubenfcasal.github.io/legendplot/reference/fplot.md)
invisibly returns a list with components: `bigplot`, `smallplot`,
`old.par`, `col` and `labels` (`par(old.par)` will reset plot parameters
to the values before entering the function).

## Side Effects

If `reset = FALSE`, the plotting region (`par("plt")`) may be changed
after exiting, to make it possible to add more features to the plot.
They can be restored using the `old.par` returned values or by calling
function
[`par.reset()`](https://rubenfcasal.github.io/legendplot/reference/par.reset.md).

## See also

[`fplot()`](https://rubenfcasal.github.io/legendplot/reference/fplot.md),
[`fcolor()`](https://rubenfcasal.github.io/legendplot/reference/categorical-color.md),
[`hcld.colors()`](https://rubenfcasal.github.io/legendplot/reference/categorical-color.md),
[`plot.default()`](https://rdrr.io/r/graphics/plot.default.html),
[`spoints()`](https://rubenfcasal.github.io/legendplot/reference/spoints.md).

## Examples

``` r
with(mtcars,
    fpoints(hp, qsec, f = cyl, main = "Motor Trend Car Road Tests")
)

```
