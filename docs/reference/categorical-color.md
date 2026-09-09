# Utilities for plotting with a categorical legend

`hcld.colors()` and
[`hot.colors()`](https://rubenfcasal.github.io/legendplot/reference/continuous-color.md)
create a color table useful for coding qualitative information and
`fcolor()` assigns colors to categorical (factor) values.

## Usage

``` r
fcolor(f, col = hcld.colors(length(labels)), labels = levels(as.factor(f)))

hcld.colors(n, palette = "Dark 3", ...)

cat.colors(n)
```

## Arguments

- f:

  (factor, or vector coercible to factor) values to be converted to
  colors.

- col:

  colors for each level. Defaults to `hcld.colors()`.

- labels:

  levels to use. Defaults to `levels(as.factor(f))`.

- n:

  number of colors (`>= 1`) to be in the palette, or vector coercible to
  factor, in which case `n = nlevels(as.factor(n))`

- palette:

  a valid palette name for
  [`hcl.colors()`](https://rdrr.io/r/grDevices/palettes.html) (one of
  [`hcl.pals()`](https://rdrr.io/r/grDevices/palettes.html)).

- ...:

  additional arguments passed to
  [`legend()`](https://rdrr.io/r/graphics/legend.html).

## Value

`fcolor()` returns vector of colors, one per element of `f`.
`hcld.colors()` and `cat.colors()` return a character vector of colors
(similar to [`hcl.colors()`](https://rdrr.io/r/grDevices/palettes.html)
or [`rainbow()`](https://rdrr.io/r/grDevices/palettes.html); see
[`rgb()`](https://rdrr.io/r/grDevices/rgb.html)).
