#····································································
#   fshade3d.R (legendplot package)
#····································································
#   fshade3d
#
#   (c) Ruben Fernandez-Casal
#   Created: Jul 2026, Modified:
#
#   NOTE: Press Ctrl + Shift + O to show document outline in RStudio
#····································································

# ··············································································
# fshade3d ----
# ··············································································

#' Draw 3D mesh objects adding a categorical legend
#'
#' Draws a triangular mesh (`mesh3d`) colored according to the levels of a
#' factor `f`, and (optionally) adds a categorical legend (via
#' [fplot3d()]).
#'
# @inheritParams sshade3d
#' @inheritParams fplot3d
#' @param x triangular mesh (`mesh3d` object, see [rgl::mesh3d()]).
#' @param f factor used to color the mesh. How its values are
#'   interpreted depends on `meshColor`.
#' @param meshColor determines how color is applied to the mesh: `"faces"` or
#'   `"vertices"` (see [rgl::shade3d()]).
#' @param col vector of colors associated with each level of `f` (defaults to
#'   `hcld.colors(nlevels(f))`).
#' @param legend.type character; symbol/object used to represent each
#'   level in the legend (see `type` in [fplot3d()]): `"s"` for spheres
#'   (default), `"c"` for cubes, `"p"` for points, or `"l"` for
#'   (horizontal) line segments.
#' @param legend logical; if `TRUE` (default), the active rgl device is splitted
#'   into two subscenes, drawing the 3D mesh object in one and the categorical
#'   legend in the other (see [fplot3d()]).
#'   if `FALSE` only the (coloured) mesh is drawn and the arguments related to
#'   the legend are ignored ([fplot3d()] is not called).
#' @param legend.lab label for the axis of the color legend, defaults to a
#'   description of `f`.
#' @param ... additional arguments passed on to [rgl::shade3d()].
#'
#' @return
#' Called for its side effect (draws the mesh and, unless `legend = FALSE`,
#' the legend on the active rgl device); invisibly returns the object identifiers.
#'
#' @seealso [fplot3d()], [sshade3d()], [hcld.colors()].
#'
#' @examples
#' library(rgl)
#' open3d() # Alternatively, use `new3d()` to clear the current device or open a new one
#' z_tri <- vb2tri3d(volcanom, volcanom$vb[3, ])
#' fz_tri <- cut(z_tri, 5)
#' fshade3d(volcanom, fz_tri, legend.dim = 0.3, lab.rev = TRUE)
#'
#' @export
# ··············································································
fshade3d <- function(x, f, meshColor = c("faces", "vertices"),
                     col = hcld.colors(nlevels(f)), legend = TRUE,
                     legend.type = c("s", "c", "p", "l"), legend.zoom = 0.6,
                     legend.width = 0.2, legend.size = 4, legend.dim = 0.2,
                     legend.lab = NULL, lab.dist = 2.5, lab.rev = FALSE, ...) {
  # ············································································
  if (missing(f))
    stop("argument 'f' (grouping factor) must be provided")
  if (is.null(legend.lab)) legend.lab <- deparse(substitute(f))
  f <- as.factor(f)
  legend.type <- match.arg(legend.type)
  labels <- levels(f)
  meshColor <- match.arg(meshColor)
  if (legend){
    fplot3d(labels = labels, col = col, type = legend.type, legend.zoom = legend.zoom,
            legend.width = legend.width, legend.size = legend.size,
            legend.dim = legend.dim, legend.lab = legend.lab,
            lab.dist = lab.dist, lab.rev = lab.rev)
  }
  rgl::shade3d(x, override = TRUE, meshColor = meshColor, col = col[f], ...)
}
