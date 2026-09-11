# legendplot 0.4-1 (2026-09-11)

- Added `par.reset()`, to restore graphical parameters (changed by 
`splot()`/`fplot()` or by `sxxx()`/`fxxx()` functions with `reset = FALSE`).

- Fixed bug in `hcld.colors()` and `cat.colors()`, when argument `f` was 
a numeric vector.

- Updated the `legendplot` vignette.


# legendplot 0.4-0 (2026-09-08)

- Added `spersp3d()` S3 generic function (and default method), drawing a 
3D surface (`rgl::persp3d()`) with a color-bar legend (calling `splot3d()`).

- Renamed `legend.mar` to `legend.dim` in `splot3d()`, `fplot3d()`,
`spoints3d()`, `spersp3d()`, `fpoints3d()`, `sshade3d()` and `fshade3d()`
(relative dimension of the legend subscene/panel).

- Updated the `legendplot` vignette.


# legendplot 0.3-1 (2026-08-08)

- Fixed bug in `fplot()`: the estimated legend width (or height, if
`horizontal = TRUE`) is now capped to half of the available plotting
region, avoiding invalid (non-increasing) `bigplot` values.

- Fixed bug causing `splot()`/`fplot()` to reset R's internal multi-panel
figure counter (e.g. breaking `par(mfrow = ...)` layouts).

- Fixed bug in `fpoints.default()`, so the default `legend.lab` captures 
the original expression of the actual `f` argument.

- Updated the `legendplot` vignette.


# legendplot 0.3-0 (2026-08-04)

- Added a `type` argument to `fplot3d()`, and a matching `legend.type`
argument to `fpoints3d()` and `fshade3d()`, to choose the symbol used to
represent each level in the legend.

- Argument `add` in `sshade3d()` and `fshade3d()` renamed as `legend`, 
for consistency.

- Renamed `vb2tri()` to `vb2tri3d()`, for consistency with the naming of
other `rgl`-specific functions.

- `setmousemode()` renamed `setmouse3d()`, and added `dev` and `subscene`
arguments, to target a specific device/subscene.

- Viewpoint utilities (e.g. `setviewpoint()`) renamed in the form `xxx3d()`.
`getview3d()`/`setview3d()` now also save/restore the field of view (`FOV`). 

- `new3d()` now also calls `dbltrack3d(1)`, so the left button rotates
as usual and double-clicking resets the view, in addition to the
previously configured zoom (middle button/wheel) and panning (right
button). It also automatically stores a `"default"` viewpoint.

- Legend titles (`legend.lab`) in `splot3d()`/`fplot3d()` are now placed
with `rgl::mtext3d()` instead of manually positioned with `rgl::text3d()`.

- `hcld.colors()` and `cat.colors()` now also accept, as `n`, a vector
coercible to a factor (in which case `nlevels(as.factor(n))` colors are
returned), in addition to a plain integer.


# legendplot 0.2.1 (2026-07-31)

- Added `dbltrack3d()`, which reimplements standard trackball rotation on a
given mouse button of an `rgl` (sub)scene, extended so that double-clicking 
resets the viewpoint to default values.

- `new3d()` now also calls `dbltrack3d(1)`, so the left button rotates
as usual and double-clicking resets the view, in addition to the
previously configured zoom (middle button/wheel) and panning (right
button).

- Changes in `splot3d()` and `fplot3d()`. The main and legend subscenes 
now get their own independent copy of the mouse controls (so they no longer 
affect each other). Mouse rotation is disabled in the legend subscene.
In the main plot subscene, since `rgl::layout3d(..., mouseMode = "replace")` 
does not copy the user's mouse handlers (which are therefore disabled), 
the first one (if any) is set up for trackball with double click to reset 
view (via `dbltrack3d()`), and the second one for panning (via `pan3d()`).

- Roxygen2 documentation converted from Rd/LaTeX macros (`\code{}`,
`\link{}`, `\item{}{}`, ...) to markdown (`` `code` ``, `[fn()]`, bullet
lists, ...) in older functions.

- Updated the `legendplot` vignette.


# legendplot 0.2.0 (2026-07-30)

- Added `fpoints()` S3 generic function (and default method): categorical
counterpart of `spoints()`, drawing a scatter plot with points colored
according to a factor and a categorical legend (calls `fplot()`).

- Added `spoints3d()` and `fpoints3d()` S3 generic functions (and default
methods), drawing a 3D scatter plot (`rgl::plot3d()`) together with a continuous or
categorical legend, respectively (calls `splot3d()`/`fplot3d()`).

- Added `tickangle` parameter to `axis3()`, to control the direction (in
degrees) in which tick marks and labels are offset from the axis line.

- Added the `legendplot` vignette.


# legendplot 0.1.1 (2026-07-28)

- Added new tools for categorical legends in standard plots:

  * Added `fplot()`, the categorical counterpart of `splot()`: adds a
  classic factor-level legend (boxes, points or line segments) to an
  existing or a new plot.

  * Added `fcolor()`, `hcld.colors()` and `cat.colors()`, for mapping a
  factor (or a vector coercible to one) to a categorical color palette.

- Added new tools for `rgl` (3D) plots with legends:

  * Added `splot3d()` and `fplot3d()`, splitting the active `rgl` device
  into a main subscene and a legend subscene with, respectively, a
  continuous color scale or a categorical legend.

  * Added `axis3()`, a modification of `rgl::axis3d()` with independent
  control over tick mark length and label position.

  * Added `sshade3d()` and `fshade3d()`, drawing a `mesh3d` object colored
  by a continuous or a categorical variable, together with the
  corresponding legend.
  
  * Added `vb2tri()`, which computes values per triangle from values given 
  at vertices of a mesh (used by `sshade3d()` when `meshColor = "facesvertices"`).

  * Added `new3d()`, which may be used as a replacement for the `open3d()` 
  and `clear3d()` functions.
  
  * Added `setmousemode()` and `pan3d()` utilities for setting 'rgl' 
  mouse actions.
  
  * Added functions to retrieve, save, restore, list and remove 'rgl' 
  viewpoints: `set.viewpoint()`, `get.viewpoints()`, `add.viewpoint()`, 
  `ls.viewpoints()`, `rm.viewpoints()`, `getview3d()` and `setview3d()`.

- Added `volcanom` dataset (a `mesh3d` version of R's `volcano` data,
Auckland's Maunga Whau volcano), used in `sshade3d()`/`fshade3d()`
examples.

- Added the package website (with `pkgdown`).


# legendplot 0.1.0 (2026-07-01)

- Initial version, adapting the color-scale legend utilities of package 
`npsp` (Fernandez-Casal, 2018, <https://rubenfcasal.github.io/npsp/>) 
into a standalone package:

  * Added `splot()`, for adding a continuous color-scale legend (based on
  `fields::image.plot()`) to an existing or a new plot.

  * Added `spoints()`, `simage()` and `spersp()` S3 generic functions (and
  default methods), drawing, respectively, a scatter plot, an image and a
  perspective plot together with a color-scale legend.

  * Added `scolor()`, `jet.colors()` and `hot.colors()`, for mapping a
  numeric vector to a continuous color palette.

