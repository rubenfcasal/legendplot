# Changelog

## legendplot 0.4-1 (2026-09-11)

- Added
  [`par.reset()`](https://rubenfcasal.github.io/legendplot/reference/par.reset.md),
  to restore graphical parameters (changed by
  [`splot()`](https://rubenfcasal.github.io/legendplot/reference/splot.md)/[`fplot()`](https://rubenfcasal.github.io/legendplot/reference/fplot.md)
  or by `sxxx()`/`fxxx()` functions with `reset = FALSE`).

- Fixed bug in
  [`hcld.colors()`](https://rubenfcasal.github.io/legendplot/reference/categorical-color.md)
  and
  [`cat.colors()`](https://rubenfcasal.github.io/legendplot/reference/categorical-color.md),
  when argument `f` was a numeric vector.

- Updated the `legendplot` vignette.

## legendplot 0.4-0 (2026-09-08)

- Added
  [`spersp3d()`](https://rubenfcasal.github.io/legendplot/reference/spersp3d.md)
  S3 generic function (and default method), drawing a 3D surface
  ([`rgl::persp3d()`](https://dmurdoch.github.io/rgl/dev/reference/persp3d.html))
  with a color-bar legend (calling
  [`splot3d()`](https://rubenfcasal.github.io/legendplot/reference/splot3d.md)).

- Renamed `legend.mar` to `legend.dim` in
  [`splot3d()`](https://rubenfcasal.github.io/legendplot/reference/splot3d.md),
  [`fplot3d()`](https://rubenfcasal.github.io/legendplot/reference/fplot3d.md),
  [`spoints3d()`](https://rubenfcasal.github.io/legendplot/reference/spoints3d.md),
  [`spersp3d()`](https://rubenfcasal.github.io/legendplot/reference/spersp3d.md),
  [`fpoints3d()`](https://rubenfcasal.github.io/legendplot/reference/fpoints3d.md),
  [`sshade3d()`](https://rubenfcasal.github.io/legendplot/reference/sshade3d.md)
  and
  [`fshade3d()`](https://rubenfcasal.github.io/legendplot/reference/fshade3d.md)
  (relative dimension of the legend subscene/panel).

- Updated the `legendplot` vignette.

## legendplot 0.3-1 (2026-08-08)

- Fixed bug in
  [`fplot()`](https://rubenfcasal.github.io/legendplot/reference/fplot.md):
  the estimated legend width (or height, if `horizontal = TRUE`) is now
  capped to half of the available plotting region, avoiding invalid
  (non-increasing) `bigplot` values.

- Fixed bug causing
  [`splot()`](https://rubenfcasal.github.io/legendplot/reference/splot.md)/[`fplot()`](https://rubenfcasal.github.io/legendplot/reference/fplot.md)
  to reset R’s internal multi-panel figure counter (e.g. breaking
  `par(mfrow = ...)` layouts).

- Fixed bug in
  [`fpoints.default()`](https://rubenfcasal.github.io/legendplot/reference/fpoints.md),
  so the default `legend.lab` captures the original expression of the
  actual `f` argument.

- Updated the `legendplot` vignette.

## legendplot 0.3-0 (2026-08-04)

- Added a `type` argument to
  [`fplot3d()`](https://rubenfcasal.github.io/legendplot/reference/fplot3d.md),
  and a matching `legend.type` argument to
  [`fpoints3d()`](https://rubenfcasal.github.io/legendplot/reference/fpoints3d.md)
  and
  [`fshade3d()`](https://rubenfcasal.github.io/legendplot/reference/fshade3d.md),
  to choose the symbol used to represent each level in the legend.

- Argument `add` in
  [`sshade3d()`](https://rubenfcasal.github.io/legendplot/reference/sshade3d.md)
  and
  [`fshade3d()`](https://rubenfcasal.github.io/legendplot/reference/fshade3d.md)
  renamed as `legend`, for consistency.

- Renamed `vb2tri()` to
  [`vb2tri3d()`](https://rubenfcasal.github.io/legendplot/reference/vb2tri3d.md),
  for consistency with the naming of other `rgl`-specific functions.

- `setmousemode()` renamed
  [`setmouse3d()`](https://rubenfcasal.github.io/legendplot/reference/mouse-actions.md),
  and added `dev` and `subscene` arguments, to target a specific
  device/subscene.

- Viewpoint utilities (e.g. `setviewpoint()`) renamed in the form
  `xxx3d()`.
  [`getview3d()`](https://rubenfcasal.github.io/legendplot/reference/viewpoints.md)/[`setview3d()`](https://rubenfcasal.github.io/legendplot/reference/viewpoints.md)
  now also save/restore the field of view (`FOV`).

- [`new3d()`](https://rubenfcasal.github.io/legendplot/reference/new3d.md)
  now also calls `dbltrack3d(1)`, so the left button rotates as usual
  and double-clicking resets the view, in addition to the previously
  configured zoom (middle button/wheel) and panning (right button). It
  also automatically stores a `"default"` viewpoint.

- Legend titles (`legend.lab`) in
  [`splot3d()`](https://rubenfcasal.github.io/legendplot/reference/splot3d.md)/[`fplot3d()`](https://rubenfcasal.github.io/legendplot/reference/fplot3d.md)
  are now placed with
  [`rgl::mtext3d()`](https://dmurdoch.github.io/rgl/dev/reference/axes3d.html)
  instead of manually positioned with
  [`rgl::text3d()`](https://dmurdoch.github.io/rgl/dev/reference/texts.html).

- [`hcld.colors()`](https://rubenfcasal.github.io/legendplot/reference/categorical-color.md)
  and
  [`cat.colors()`](https://rubenfcasal.github.io/legendplot/reference/categorical-color.md)
  now also accept, as `n`, a vector coercible to a factor (in which case
  `nlevels(as.factor(n))` colors are returned), in addition to a plain
  integer.

## legendplot 0.2.1 (2026-07-31)

- Added
  [`dbltrack3d()`](https://rubenfcasal.github.io/legendplot/reference/mouse-actions.md),
  which reimplements standard trackball rotation on a given mouse button
  of an `rgl` (sub)scene, extended so that double-clicking resets the
  viewpoint to default values.

- [`new3d()`](https://rubenfcasal.github.io/legendplot/reference/new3d.md)
  now also calls `dbltrack3d(1)`, so the left button rotates as usual
  and double-clicking resets the view, in addition to the previously
  configured zoom (middle button/wheel) and panning (right button).

- Changes in
  [`splot3d()`](https://rubenfcasal.github.io/legendplot/reference/splot3d.md)
  and
  [`fplot3d()`](https://rubenfcasal.github.io/legendplot/reference/fplot3d.md).
  The main and legend subscenes now get their own independent copy of
  the mouse controls (so they no longer affect each other). Mouse
  rotation is disabled in the legend subscene. In the main plot
  subscene, since `rgl::layout3d(..., mouseMode = "replace")` does not
  copy the user’s mouse handlers (which are therefore disabled), the
  first one (if any) is set up for trackball with double click to reset
  view (via
  [`dbltrack3d()`](https://rubenfcasal.github.io/legendplot/reference/mouse-actions.md)),
  and the second one for panning (via
  [`pan3d()`](https://rubenfcasal.github.io/legendplot/reference/mouse-actions.md)).

- Roxygen2 documentation converted from Rd/LaTeX macros (`\code{}`,
  `\link{}`, `\item{}{}`, …) to markdown (`` `code` ``, `[fn()]`, bullet
  lists, …) in older functions.

- Updated the `legendplot` vignette.

## legendplot 0.2.0 (2026-07-30)

- Added
  [`fpoints()`](https://rubenfcasal.github.io/legendplot/reference/fpoints.md)
  S3 generic function (and default method): categorical counterpart of
  [`spoints()`](https://rubenfcasal.github.io/legendplot/reference/spoints.md),
  drawing a scatter plot with points colored according to a factor and a
  categorical legend (calls
  [`fplot()`](https://rubenfcasal.github.io/legendplot/reference/fplot.md)).

- Added
  [`spoints3d()`](https://rubenfcasal.github.io/legendplot/reference/spoints3d.md)
  and
  [`fpoints3d()`](https://rubenfcasal.github.io/legendplot/reference/fpoints3d.md)
  S3 generic functions (and default methods), drawing a 3D scatter plot
  ([`rgl::plot3d()`](https://dmurdoch.github.io/rgl/dev/reference/plot3d.html))
  together with a continuous or categorical legend, respectively (calls
  [`splot3d()`](https://rubenfcasal.github.io/legendplot/reference/splot3d.md)/[`fplot3d()`](https://rubenfcasal.github.io/legendplot/reference/fplot3d.md)).

- Added `tickangle` parameter to
  [`axis3()`](https://rubenfcasal.github.io/legendplot/reference/axis3.md),
  to control the direction (in degrees) in which tick marks and labels
  are offset from the axis line.

- Added the `legendplot` vignette.

## legendplot 0.1.1 (2026-07-28)

- Added new tools for categorical legends in standard plots:

  - Added
    [`fplot()`](https://rubenfcasal.github.io/legendplot/reference/fplot.md),
    the categorical counterpart of
    [`splot()`](https://rubenfcasal.github.io/legendplot/reference/splot.md):
    adds a classic factor-level legend (boxes, points or line segments)
    to an existing or a new plot.

  - Added
    [`fcolor()`](https://rubenfcasal.github.io/legendplot/reference/categorical-color.md),
    [`hcld.colors()`](https://rubenfcasal.github.io/legendplot/reference/categorical-color.md)
    and
    [`cat.colors()`](https://rubenfcasal.github.io/legendplot/reference/categorical-color.md),
    for mapping a factor (or a vector coercible to one) to a categorical
    color palette.

- Added new tools for `rgl` (3D) plots with legends:

  - Added
    [`splot3d()`](https://rubenfcasal.github.io/legendplot/reference/splot3d.md)
    and
    [`fplot3d()`](https://rubenfcasal.github.io/legendplot/reference/fplot3d.md),
    splitting the active `rgl` device into a main subscene and a legend
    subscene with, respectively, a continuous color scale or a
    categorical legend.

  - Added
    [`axis3()`](https://rubenfcasal.github.io/legendplot/reference/axis3.md),
    a modification of
    [`rgl::axis3d()`](https://dmurdoch.github.io/rgl/dev/reference/axes3d.html)
    with independent control over tick mark length and label position.

  - Added
    [`sshade3d()`](https://rubenfcasal.github.io/legendplot/reference/sshade3d.md)
    and
    [`fshade3d()`](https://rubenfcasal.github.io/legendplot/reference/fshade3d.md),
    drawing a `mesh3d` object colored by a continuous or a categorical
    variable, together with the corresponding legend.

  - Added `vb2tri()`, which computes values per triangle from values
    given at vertices of a mesh (used by
    [`sshade3d()`](https://rubenfcasal.github.io/legendplot/reference/sshade3d.md)
    when `meshColor = "facesvertices"`).

  - Added
    [`new3d()`](https://rubenfcasal.github.io/legendplot/reference/new3d.md),
    which may be used as a replacement for the
    [`open3d()`](https://dmurdoch.github.io/rgl/dev/reference/open3d.html)
    and
    [`clear3d()`](https://dmurdoch.github.io/rgl/dev/reference/scene.html)
    functions.

  - Added `setmousemode()` and
    [`pan3d()`](https://rubenfcasal.github.io/legendplot/reference/mouse-actions.md)
    utilities for setting ‘rgl’ mouse actions.

  - Added functions to retrieve, save, restore, list and remove ‘rgl’
    viewpoints: `set.viewpoint()`, `get.viewpoints()`,
    `add.viewpoint()`, `ls.viewpoints()`, `rm.viewpoints()`,
    [`getview3d()`](https://rubenfcasal.github.io/legendplot/reference/viewpoints.md)
    and
    [`setview3d()`](https://rubenfcasal.github.io/legendplot/reference/viewpoints.md).

- Added `volcanom` dataset (a `mesh3d` version of R’s `volcano` data,
  Auckland’s Maunga Whau volcano), used in
  [`sshade3d()`](https://rubenfcasal.github.io/legendplot/reference/sshade3d.md)/[`fshade3d()`](https://rubenfcasal.github.io/legendplot/reference/fshade3d.md)
  examples.

- Added the package website (with `pkgdown`).

## legendplot 0.1.0 (2026-07-01)

- Initial version, adapting the color-scale legend utilities of package
  `npsp` (Fernandez-Casal, 2018, <https://rubenfcasal.github.io/npsp/>)
  into a standalone package:

  - Added
    [`splot()`](https://rubenfcasal.github.io/legendplot/reference/splot.md),
    for adding a continuous color-scale legend (based on
    [`fields::image.plot()`](https://rdrr.io/pkg/fields/man/image.plot.html))
    to an existing or a new plot.

  - Added
    [`spoints()`](https://rubenfcasal.github.io/legendplot/reference/spoints.md),
    [`simage()`](https://rubenfcasal.github.io/legendplot/reference/simage.md)
    and
    [`spersp()`](https://rubenfcasal.github.io/legendplot/reference/spersp.md)
    S3 generic functions (and default methods), drawing, respectively, a
    scatter plot, an image and a perspective plot together with a
    color-scale legend.

  - Added
    [`scolor()`](https://rubenfcasal.github.io/legendplot/reference/continuous-color.md),
    [`jet.colors()`](https://rubenfcasal.github.io/legendplot/reference/continuous-color.md)
    and
    [`hot.colors()`](https://rubenfcasal.github.io/legendplot/reference/continuous-color.md),
    for mapping a numeric vector to a continuous color palette.
