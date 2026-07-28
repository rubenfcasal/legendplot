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
#' factor `f`, automatically adding a categorical legend (via
#' [fplot3d()]).
#'
# @inheritParams sshade3d
#' @inheritParams fplot3d
#' @param x triangular mesh (`mesh3d` object, see [rgl::mesh3d()]).
#' @param f factor used to color the mesh. How its values are
#'   interpreted depends on `meshColor`.
#' @param meshColor determines how color is applied to the mesh: `"faces"` or
#'   `"vertices"` (see [rgl::shade3d()]).
#' @param labels legend labels (defaults to `levels(f)`).
#' @param col vector of colors associated with each level of `f` (by
#'   default generated with `col.pal`).
#' @param add logical; if `TRUE` the legend is not redrawn (useful for
#'   adding several meshes to an already existing legend).
#' @param ... additional arguments passed on to [rgl::shade3d()].
#'
#' @return
#' Called for its side effect (draws the mesh and, unless `add = TRUE`,
#' the legend on the active rgl device); invisibly returns the object identifiers.
#'
#' @seealso [fplot3d()], [sshade3d()], [hcld.colors()]
#'
#' @examples
#' library(rgl)
#' open3d()
#' z_tri <- vb2tri(volcanom, volcanom$vb[3, ])
#' fz_tri <- cut(z_tri, 5)
#' fshade3d(volcanom, fz_tri, legend.mar = 0.3, lab.dist = 15, lab.rev = TRUE)
#'
#' @export
# ··············································································
fshade3d <- function(x, f, meshColor = c("faces", "vertices"),
                     labels = levels(f), col = hcld.colors(length(labels)),
                     legend.zoom = 1, legend.width = 0.1, legend.mar = 0.15,
                     legend.lab = NULL, lab.dist = 3, lab.rev = FALSE, add = FALSE, ...) {
  # ············································································
  meshColor <- match.arg(meshColor)
  if (!add) fplot3d(labels = labels, col = col, legend.zoom = legend.zoom,
                    legend.width = legend.width, legend.mar = legend.mar,
                    legend.lab = legend.lab, lab.dist = lab.dist, lab.rev = lab.rev)
  rgl::shade3d(x, override = TRUE, meshColor = meshColor, col = col[f], ...)
}
