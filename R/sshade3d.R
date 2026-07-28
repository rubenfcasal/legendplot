#····································································
#   sshade3d.R (legendplot package)
#····································································
#   sshade3d
#   axis3
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
#' automatically adding a color-bar legend (via [splot3d()]).
#'
#' @inheritParams splot3d
#' @param x triangular mesh (`mesh3d` object, see [rgl::mesh3d()]).
#' @param s values used to color the mesh. How they are
#'   interpreted depends on `meshColor`.
#' @param meshColor determines how material colours (and textures) are interpreted:
#'   `"faces"` applies the color per face;
#'   `"facesvertices"` assumes that `s` contains one value per vertex,
#'   calculates the average per face (via [vb2tri()]), and applies the
#'   resulting color to each face;
#'   `"vertices"` applies the color per vertex. See [rgl::shade3d()].
#' @param add logical; if `TRUE` the legend is not redrawn (useful for
#'   adding several meshes to an already existing legend).
#' @param ... additional arguments passed to [rgl::shade3d()].
#'
#' @return
#' Called for its side effect (draws the mesh and, unless `add = TRUE`,
#' the legend on the active rgl device); invisibly returns the object identifiers.
#'
#' @seealso [splot3d()], [scolor()], [vb2tri()], [fshade3d()]
#'
#' @examples
#' library(rgl)
#' open3d()
#' sshade3d(volcanom, s = volcanom$vb[3, ], meshColor = "facesvertices")
#'
#' @export
# ··············································································
sshade3d <- function(x, s, meshColor = c("faces", "facesvertices", "vertices"),
                     slim = range(s, finite = TRUE),  col = jet.colors(128),
                     legend.zoom = 0.4, legend.width = 0.1, legend.mar = 0.15,
                     legend.lab = NULL, box = TRUE, lab.breaks = NULL,
                     lab.ticksize = 0.5, lab.dist = 3, add = FALSE, ...) {
  # ············································································
  # TODO:
  #   - meshColor = "edges"
  #   - Add legend position
  # ············································································
  meshColor <- match.arg(meshColor)
  if (meshColor == "facesvertices") {
    meshColor <- "faces"
    s <- vb2tri(x, s) # Value per triangle (average of vertices)
  }
  # Legend
  if (!add)
    splot3d(slim = slim, col = col, legend.zoom = legend.zoom, legend.width = legend.width,
            legend.mar = legend.mar, legend.lab = legend.lab, box = box,
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
#' open3d()
#' z_tri <- vb2tri(volcanom, volcanom$vb[3, ])
#' shade3d(volcanom, col = scolor(z_tri, col = terrain.colors(128)))
#'
#' @export
# ··············································································
vb2tri <- function(x, s) {
  if (!length(x$it)) stop("Argument 'x' must be a triangular mesh")
  return(apply(x$it, 2, function(tri) mean(s[tri])))
}
