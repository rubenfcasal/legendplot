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
#' legend) and draws, in the legend subscene, a
#' colored categorical legend together with its corresponding labels.
#'
# For instance, `fxxxx3d()` functions (e.g. [fpoints3d()], [fshade3d()]
# and [fsurface3d()]) draw the corresponding high-level plot (`xxxx3d()`),
# after calling `fplot3d()`, to include a categorical legend.
#'
#' @inheritParams splot3d
#' @param labels vector with the legend labels (levels/categories).
#'   Defaults to `seq_along(col)`.
#' @param col vector of colors associated with each label (defaults to
#'   `hcld.colors(length(labels))`).
#' @param type character; symbol/object used to represent each label in the
#'   legend: `"s"` for spheres (default), `"c"` for cubes, `"p"` for points,
#'   or `"l"` for (horizontal) line segments.
#' @param legend.zoom zoom factor applied to the legend subscene/panel.
#' @param legend.width relative size of the legend symbols (spheres, cubes or
#'   line segments), as a fraction of the corresponding dimension
#'   of the legend subscene.
#' @param lab.dist distance between the legend symbols and their text
#'   labels, as a multiple of the symbol size (`legend.width`).
#' @param lab.rev logical; if `TRUE` the order of the levels in the legend
#'   is reversed (by default they are shown from top to bottom).
#' @param legend.size point size, if `type = "p"`, or line width, if `type = "l"`
#'   (in pixels; see `size` and `lwd` graphical parameters in [rgl::par3d()];
#'   ignored in all other cases).
#' @param ... material properties (see [material3d()]) used to draw the legend
#'   symbols.
#'
#' @details
#' Mouse rotation is disabled in the legend subscene.
#' Furthermore, since `rgl::layout3d(..., mouseMode = "replace")` does not
#' copy the user's mouse handlers (which are therefore disabled), the first one
#' is set up for trackball with double click to reset view (via [dbltrack3d()]),
#' and the second one (if any) for panning (via [pan3d()]).
#'
#' @return
#' Invisibly returns the identifiers of the created subscenes (see
#' [rgl::layout3d()]).
#'
#' @seealso [fpoints3d()], [fshade3d()], [splot3d()].
#'
#' @examples
#' library(rgl)
#' open3d()
#' # Plot equivalent to fpoints():
#' f <- as.factor(mtcars$cyl)
#' fplot3d(levels(f), legend.lab = "cyl")
#' with( mtcars, plot3d(hp, qsec, mpg, type = "s", col = fcolor(f)))
#'
#' # Using cubes instead of spheres in the legend
#' fplot3d(levels(f), legend.lab = "cyl", type = "c")
#' with( mtcars, plot3d(hp, qsec, mpg, type = "p", col = fcolor(f)))
#'
#' @export
# ··············································································
fplot3d <- function(labels, col = hcld.colors(length(labels)),
                    type = c("s", "c", "p", "l"), legend.zoom = 0.6,
                    legend.width = 0.2, legend.size = 4, legend.dim = 0.2,
                    legend.lab = NULL, lab.dist = 2.5, lab.rev = FALSE, ...) {
# ··············································································
  # labels = letters[1:5]; col = seq_along(labels); legend.zoom = 0.6;
  # legend.width = 0.1; legend.dim = 0.25; lab.dist = 2.5; type = "s"
  # TODO:
  #   - Add legend position
  #   - lit logical, specifying if lighting calculation should take place on geometry
  # ············································································
  if (!requireNamespace("rgl", quietly = TRUE))
    stop("package 'rgl' is required")
  type <- match.arg(type)
  if (missing(labels)) labels <- seq_along(col)
  # Suspend drawing update
  rgl::par3d(skipRedraw = TRUE)
  # Split into subscenes (mouseMode = "replace" so that each subscene gets
  # its own independent copy of the mouse controls)
  subscene <- rgl::layout3d(matrix(c(2, 1), nrow = 1),
                            widths = c(1 - legend.dim, legend.dim),
                            mouseMode = "replace")
  rgl::next3d() # move to the scene corresponding to the legend
  # Legend values
  slim <- c(0, 1)
  nbins <- length(labels)
  binwidth <- (slim[2] - slim[1]) / nbins
  radius <- legend.dim * legend.width
  iz <- seq(slim[2] - binwidth/2, slim[1] + binwidth/2, len = nbins) # midpoints
  # iz <- seq(slim[1] + binwidth/2, slim[2] - binwidth/2, by = binwidth) # midpoints
  if (lab.rev) iz <- rev(iz) # sort(iz)
  # Draw legend symbols
  switch(type,
    s = rgl::spheres3d(x = 0, y = 0, z = iz, radius = radius, color = col, lit = FALSE, ...),
    c = {
      cube <- rgl::cube3d(trans = rgl::scaleMatrix(radius, radius, radius),
                          meshColor = "faces", smooth = FALSE)
      rgl::shapelist3d(cube, x = 0, y = 0, z = iz, color = col, lit = FALSE, ...)
    },
    p = rgl::points3d(x = rep(0, nbins), y = rep(0, nbins), z = iz,
                    color = col, size = legend.size, ...),
    l = {
      # horizontal segment (along x) at each iz, one color per level
      x <- rep(c(-radius, radius), nbins)
      y <- rep(0, 2 * nbins)
      z <- rep(iz, each = 2)
      rgl::segments3d(x, y, z, color = rep(col, each = 2), lwd = legend.size, ...)
    }
  )
  # Add legend labels. Placed directly with rgl::text3d()
  rgl::text3d(rep(lab.dist * radius, nbins), rep(0, nbins), iz,
              labels, adj = c(0, 0.5))
  if (!is.null(legend.lab))
    rgl::mtext3d(legend.lab, 'z--', at = NA, line = 5, adj = c(1, 0.5))
    # rgl::text3d(-1.5 * legend.width, 0, mean(slim), legend.lab, adj = c(1, 0.5))
  # Set viewpoint
  rgl::view3d(phi = -90, fov = 0, zoom = legend.zoom)
  # Get mouse actions
  mmodes <- rgl::par3d("mouseMode")
  # Disable "trackball" in the legend subscene
  mmodes[mmodes == "trackball"] <- "none"
  rgl::par3d(mouseMode = mmodes)
  # Enable drawing update and move to the main plot scene
  rgl::par3d(skipRedraw = FALSE)
  rgl::next3d()
  # Get mouse actions
  mmodes <- rgl::par3d("mouseMode")
  # Determine mouse buttons with user handlers (set by rgl.setMouseCallbacks)
  mbuser <- which(mmodes == "user") - 1
  nuser <- length(mbuser)
  if (nuser > 0)
    dbltrack3d(mbuser[1]) # Replace user handler with trackball + double-click
  if (nuser > 1)
    pan3d(mbuser[2]) # Replace user handler with panning
  # Return subscene id values
  return(invisible(subscene))
} # fplot3d
