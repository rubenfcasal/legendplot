# Utilities for plotting with a continuous color scale

`jet.colors` and `hot.colors` create a color table useful for contiguous
color scales and `scolor` assigns colors to a numerical vector.

## Usage

``` r
scolor(s, col = jet.colors(128), slim = range(s, finite = TRUE))

jet.colors(n)

hot.colors(n, rev = TRUE)
```

## Arguments

- s:

  values to be converted to the color scale.

- col:

  color table used to set up the color scale (see
  [`image`](https://rdrr.io/r/graphics/image.html) for details).

- slim:

  limits used to set up the color scale.

- n:

  number of colors (`>= 1`) to be in the palette.

- rev:

  logical; if `TRUE`, the palette is reversed (decreasing overall
  luminosity).

## Value

`scolor`, `jet.colors` and `hot.colors` return a character vector of
colors.

## Details

`scolor` converts a real valued vector to a color scale. The range
`slim` is divided into `length(col) + 1` pieces of equal length. Values
which fall outside the range of the scale are coded as `NA`.

`jet.colors` generates a rainbow style color table similar to the MATLAB
(TM) jet color scheme. It may be appropriate to distinguish between
values above and below a central value (e.g. between positive and
negative values).

`hot.colors` generates a color table similar to the MATLAB (TM) hot
color scheme (reversed by default). It may be appropriate to represent
values ranging from 0 to some maximum level (e.g. density estimation).
The default value `rev = TRUE` may be adequate to grayscale conversion.

## See also

[`heat.colors`](https://rdrr.io/r/grDevices/palettes.html),
[`terrain.colors`](https://rdrr.io/r/grDevices/palettes.html),
[`rgb`](https://rdrr.io/r/grDevices/rgb.html).
