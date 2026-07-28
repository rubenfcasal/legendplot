#····································································
#   fplot3d.R (legendplot package)
#····································································
#   fplot3d
#
#   (c) Ruben Fernandez-Casal
#   Created: Jul 2026, Modified:
#
#   NOTE: Press Ctrl + Shift + O to show document outline in RStudio
#····································································

# ··············································································
# fplot3d ----
# ··············································································

#' Add a categorical legend to an 'rgl' plot
#'
#' Splits the active rgl device into two subscenes (the main plot and a
#' legend) and draws, in the legend subscene, in the legend subscene, a
#' colored categorical legend together with its corresponding labels.
#'
# For instance, `fxxxx3d()` functions (e.g. [fpoints3d()], [fshade3d()]
# and [fsurface3d()]) draw the corresponding high-level plot (`xxxx3d()`),
# after calling `fplot3d()`, to include a categorical legend.
#'
#' @inheritParams splot3d
#' @param labels vector with the legend labels (one level per category).
#'   Defaults to `seq_along(col)`.
#' @param col vector of colors associated with each label (defaults to
#'   `hcld.colors(length(labels))`).
#' @param legend.zoom zoom factor applied to the legend subscene/panel
#' @param legend.width relative size of the legend spheres, as a fraction of
#'   the corresponding dimension of the legend subscene.
#' @param lab.dist distance between the spheres and their text labels.
#' @param lab.rev logical; if `TRUE` the order of the levels in the legend
#'   is reversed (by default they are shown from top to bottom).
#'
#' @return
#' Invisibly returns the identifiers of the created subscenes (see
#' [rgl::layout3d()]).
#'
#' @seealso [fshade3d()], [axis3()], [splot3d()]
#'
#' @examples
#' library(rgl)
#' open3d()
#' # Plot equivalent to fpoints():
#' f <- as.factor(mtcars$cyl)
#' fplot3d(levels(f), legend.lab = "cyl")
#' with( mtcars, plot3d(hp, qsec, mpg, type = "s", col = fcolor(f)))
#'
#' @export
# ··············································································
fplot3d <- function(labels, col = hcld.colors(length(labels)),
                    legend.zoom = 0.6, legend.width = 0.1, legend.mar = 0.2,
                    legend.lab = NULL, lab.dist = 2.5, lab.rev = FALSE, ...) {
  # ··············································································
  # labels = letters[1:5]; col = seq_along(labels); legend.zoom = 0.6;
  # legend.width = 0.1; legend.mar = 0.25; lab.dist = 2.5
  # TODO:
  #   - legend.radius = NULL (binwidth)
  #   - Add legend position
  #   - Add legend.shrink
  # ············································································
  if (missing(labels)) labels <- seq_along(col)
  # Suspend drawing update
  rgl::par3d(skipRedraw = TRUE)
  # Split into subscenes
  subscene <- rgl::layout3d(matrix(c(2, 1), nrow = 1),
                            widths = c(1 - legend.mar, legend.mar))
  rgl::next3d() # move to the scene corresponding to the legend
  # Legend values
  slim <- c(0, 1)
  nbins <- length(labels)
  binwidth <- (slim[2] - slim[1]) / nbins
  radius <- binwidth * legend.width
  iz <- seq(slim[2] - binwidth/2, slim[1] + binwidth/2, len = nbins) # midpoints
  # iz <- seq(slim[1] + binwidth/2, slim[2] - binwidth/2, by = binwidth) # midpoints
  if (lab.rev) iz <- rev(iz) # sort(iz)
  # Draw legend
  rgl::spheres3d(x = 0, y = 0, z = iz, radius = radius, color = col)
  # Add legend axis
  lab.dist <- lab.dist + radius
  # ticksize = binwidth?
  axis3('z+-', at = iz, tick = FALSE, line = FALSE, ticksize = 0.5,
        labeldist = lab.dist, labels = labels, ...)
  if (!is.null(legend.lab))
    rgl::text3d(-1 * legend.width, 0, 0.5, legend.lab, adj = c(1, 0.5))
  # Set viewpoint
  rgl::view3d(phi = -90, fov = 0, zoom = legend.zoom)
  # Enable drawing update and move to the main plot scene
  rgl::par3d(skipRedraw = FALSE)
  rgl::next3d()
  # Return subscene id values
  return(invisible(subscene))
} # fplot3d
