#····································································
#   sshade3d.R (legendplot package)
#····································································
#   sshade3d
#   vb2tri3d
#
#   (c) Ruben Fernandez-Casal
#   Created: Jul 2026, Modified:
#
#   NOTE: Press Ctrl + Shift + O to show document outline in RStudio
#····································································

# ··············································································
# sshade3d ----
# ··············································································

#' Draw 3D mesh objects adding a continuous color scale
#'
#' Draws a triangular mesh (`mesh3d`) colored according to a continuous
#' scale associated with a vector of values `s` (via [rgl::shade3d()]),
#' and (optionally) adds a color-bar legend (via [splot3d()]).
#'
#' @inheritParams splot3d
#' @param x triangular mesh (`mesh3d` object, see [rgl::mesh3d()]).
#' @param s values used to color the mesh. How they are interpreted depends on
#'   `meshColor`.
#' @param meshColor determines how material colours (and textures) are interpreted:
#'   `"faces"` applies the color per face;
#'   `"facesvertices"` assumes that `s` contains one value per vertex,
#'   calculates the average per face (via [vb2tri3d()]), and applies the
#'   resulting color to each face;
#'   `"vertices"` applies the color per vertex. See [rgl::shade3d()].
#' @param legend logical; if `TRUE` (default), the active rgl device is splitted
#'   into two subscenes, drawing the 3D mesh object in one and the legend with
#'   the color scale in the other (see [splot3d()]).
#'   if `FALSE` only the (coloured) mesh is drawn and the arguments related to
#'   the legend are ignored ([splot3d()] is not called).
#' @param ... additional arguments passed to [rgl::shade3d()].
#'
#' @return
#' Called for its side effect (draws the mesh and, unless `add = TRUE`,
#' the legend on the active rgl device); invisibly returns the object identifiers.
#'
#' @seealso [splot3d()], [scolor()], [vb2tri3d()], [fshade3d()], [rgl::shade3d()].
#'
#' @examples
#' library(rgl)
#' open3d() # Alternatively, use `new3d()` to clear the current device or open a new one
#' sshade3d(volcanom, s = volcanom$vb[3, ], meshColor = "facesvertices")
#'
#' @export
# ··············································································
sshade3d <- function(x, s, meshColor = c("faces", "facesvertices", "vertices"),
                     slim = range(s, finite = TRUE),  col = jet.colors(128),
                     legend = TRUE, legend.zoom = 0.4, legend.width = 0.1,
                     legend.dim = 0.2, legend.lab = NULL, box = TRUE,
                     lab.breaks = NULL, lab.ticksize = 0.5, lab.dist = 3, ...) {
  # ············································································
  # TODO:
  #   - meshColor = "edges"
  #   - Add legend position
  # ············································································
  if (!requireNamespace("rgl", quietly = TRUE))
    stop("package 'rgl' is required")
  meshColor <- match.arg(meshColor)
  if (meshColor == "facesvertices") {
    meshColor <- "faces"
    s <- vb2tri3d(x, s) # Value per triangle (average of vertices)
  }
  # Legend
  if (legend)
    splot3d(slim = slim, col = col, legend.zoom = legend.zoom, legend.width = legend.width,
            legend.dim = legend.dim, legend.lab = legend.lab, box = box,
            lab.breaks = lab.breaks, lab.ticksize = lab.ticksize, lab.dist = lab.dist)

  # shade3d
  scol <- scolor(s, col = col, slim = slim)
  rgl::shade3d(x, override = TRUE, meshColor = meshColor, col = scol, ...)
}



#' Value per triangle from values at vertices
#'
#' For each triangle of a mesh, computes the average of the values
#' associated with its three vertices. This is useful for going from a
#' per-vertex value to a per-face value (for example, to use
#' `meshColor = "faces"` in [rgl::shade3d()] starting from a quantity
#' defined at the vertices).
#'
#' @param x triangular mesh (`mesh3d` object with an `it` component, see
#'   [rgl::mesh3d()]).
#' @param s vector of values associated with the vertices of `x` (same
#'   length as the number of columns of `x$vb`).
#'
#' @return
#' Numeric vector with one value per triangle (column of `x$it`), equal to
#' the average of the values of `s` at its vertices.
#'
#' @seealso [sshade3d()]
#'
#' @examples
#' library(rgl)
#' open3d() # Alternatively, use `new3d()` to clear the current device or open a new one
#' z_tri <- vb2tri3d(volcanom, volcanom$vb[3, ])
#' shade3d(volcanom, col = scolor(z_tri, col = terrain.colors(128)))
#'
#' @export
# ··············································································
vb2tri3d <- function(x, s) {
  if (!length(x$it)) stop("Argument 'x' must be a triangular mesh")
  return(apply(x$it, 2, function(tri) mean(s[tri])))
}
