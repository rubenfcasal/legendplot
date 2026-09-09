#····································································
#   splot3d.R (legendplot package)
#····································································
#   splot3d
#   axis3
#
#   (c) Ruben Fernandez-Casal
#   Created: Jul 2026, Modified:
#
#   NOTE: Press Ctrl + Shift + O to show document outline in RStudio
#····································································

# ··············································································
# splot3d ----
# ··············································································

#' Add a continuous color scale legend to an 'rgl' plot
#'
#' Splits the active rgl device into two subscenes (the main plot and a
#' color-bar legend) and draws, in the legend subscene, a continuous color
#' scale together with its corresponding values.
#'
# For instance, `sxxxx3d()` functions (e.g. [spoints3d()], [sshade3d()]
# and [ssurface3d()]) draw the corresponding high-level plot (`xxxx3d()`),
# after calling `splot3d()`, to include a legend strip for the color scale.
#'
#' @param slim limits (vector of length 2 with the minimum and maximum) used
#'   to set up the color scale.
#' @param col color table used to set up the color scale. Defaults to
#'   `jet.colors(128)`.
#' @param legend.zoom zoom factor applied to the legend subscene (see
#'   [rgl::view3d()]).
#' @param legend.width relative width of the color bar, as a fraction of
#'   the corresponding dimension of the legend subscene/panel.
#' @param legend.dim relative dimension of the legend panel, as a fraction of
#'   the full width (or height) of the device.
#' @param legend.lab legend title.
#' @param box logical; if `TRUE` (the default) a rectangle is drawn around
#'   the color bar.
#' @param lab.breaks labels for the legend axis breaks; if `NULL` they are
#'   generated automatically (see [axis3()]).
#' @param lab.ticksize length of the legend axis tick marks, as a fraction
#'   of the distance to the center of the legend panel.
#' @param lab.dist distance between the tick marks and the labels of the
#'   legend axis, as a multiple of `lab.ticksize`.
#' @param ... additional arguments passed to [axis3()].
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
#' @seealso [spoints3d()], [spersp3d()], [sshade3d()], [axis3()], [fplot3d()]
#'
#' @examples
#' library(rgl)
#' open3d() # Alternatively, use `new3d()` to clear the current device or open a new one
#' scale.range <- range(mtcars$mpg)
#' splot3d(slim = scale.range, legend.lab = "mpg")
#' with( mtcars, plot3d(hp, qsec, wt, type = "s",
#'                      col = scolor(mpg, slim = scale.range)))
#'
#' @export
# ··············································································
splot3d <- function(slim = c(0, 1), col = jet.colors(128), legend.zoom = 0.4,
                    legend.width = 0.1, legend.dim = 0.2, legend.lab = NULL,
                    box = TRUE, lab.breaks = NULL, lab.ticksize = 0.5,
                    lab.dist = 3, ...) {
  # ··············································································
  # slim = c(0, 1); col = jet.colors(128); legend.zoom = 0.6;
  # legend.width = 0.1; legend.dim = 0.25; legend.lab = NULL;
  # lab.breaks = NULL; lab.ticksize = 0.5; lab.dist = 2.5; box = TRUE
  # TODO:
  #   - Add legend.shrink
  #   - Add breaks
  #   - Add legend position
  # ············································································
  if (!requireNamespace("rgl", quietly = TRUE))
    stop("package 'rgl' is required")
  # Suspend drawing update
  rgl::par3d(skipRedraw = TRUE)
  # Split into subscenes (mouseMode = "replace" so that each subscene gets
  # its own independent copy of the mouse controls)
  subscene <- rgl::layout3d(matrix(c(2, 1), nrow = 1),
                            widths = c(1 - legend.dim, legend.dim),
                            mouseMode = "replace")
  rgl::next3d() # move to the scene corresponding to the legend
  # Legend values
  legend.width = (slim[2] - slim[1]) * legend.width
  if(is.null(lab.breaks)) lab.breaks = TRUE
  # Legend breaks
  nbins <- length(col)
  binwidth <- (slim[2] - slim[1]) / nbins
  iz <- seq(slim[1] + binwidth/2, slim[2] - binwidth/2, by = binwidth) # midpoints
  # Draw legend
  cube <- rgl::cube3d(trans = rgl::scaleMatrix(legend.width/2, legend.width/2, binwidth),
                      meshColor = "faces", lit = FALSE, smooth = FALSE)
  rgl::shapelist3d(cube, x = 0, y = 0, z = iz, color = col)
  # Add legend axis
  axis3('z+-', line = FALSE, ticksize = lab.ticksize, tickangle = 0,
        labeldist = lab.dist, labels = lab.breaks, ...)
  # Draw a box around the legend?
  if (box) {
    xlim <- legend.width * c(-0.5, 0.5)
    zlim <- c(slim[1] - binwidth/2, slim[2] + binwidth/2)
    x <- c(rep(xlim[1], 8), rep(xlim, 4), rep(xlim[2], 8))
    y <- c(rep(xlim, 2), rep(xlim, c(2, 2)), rep(xlim, c(4, 4)), rep(xlim, 2),
           rep(xlim, c(2, 2)))
    z <- c(rep(zlim, c(2, 2)), rep(zlim, 2), rep(rep(zlim, c(2, 2)), 2),
           rep(zlim, c(2, 2)), rep(zlim, 2))
    rgl::segments3d(x, y, z)
  }
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
}


#' 3D axis with control over tick length, tick angle and label position
#'
#' Modification of [rgl::axis3d()] that adds three extra parameters,
#' `ticksize`, `labeldist` and `tickangle`, to independently control the
#' length of the axis tick marks, the distance between those tick marks and
#' their labels, and the direction (within the plane orthogonal to the axis)
#' in which both the tick marks and the labels are offset (see *Details*).
#' Based on the solution proposed on Stack Overflow (see *References*).
#'
#' By default (`tickangle = 45`), tick marks and labels are offset
#' simultaneously along both coordinates perpendicular to the axis, towards
#' the corresponding corner of the bounding box.
#' The original behavior of `axis3d()` can be reproduced by setting
#' `tickangle = 45` and `ticksize = 0.05 * sqrt(2)` (the actual relative
#' length of the tick marks).
#'
#' @param edge character string indicating the edge of the bounding box on
#'   which the axis is drawn (same format as in [rgl::axis3d()], e.g.
#'   `"z+-"`).
#' @param at positions at which the tick marks are drawn; if `NULL` they
#'   are computed automatically with [pretty()].
#' @param labels tick labels: logical, indicating whether to automatically
#'   label the axes or be omitted, or a vector of labels.
#' @param tick logical; if `TRUE` the axis tick marks are drawn.
#' @param line logical; if `TRUE` the axis line is drawn.
#' @param pos optional position of the axis (see [rgl::axis3d()]).
#' @param nticks approximate number of tick marks when `at = NULL`.
#' @param ticksize length of the tick marks, as a fraction of the distance
#'   to the center of the scene's range.
#' @param tickangle direction, in degrees, of the tick marks and labels
#'   within the plane orthogonal to the axis (e.g. `0` = along the first
#'   perpendicular coordinate, `90` = along the second one, `45`
#'   = towards the corner of the bounding box).
#' @param labeldist distance between the tick marks and the labels, as a
#'   multiple of `ticksize`.
#' @param ... additional arguments passed to [rgl::segments3d()] and
#'   [rgl::text3d()].
#'
#' @return
#' An `rglId` object (see [rgl::lowlevel()]) with the identifiers of the
#' \pkg{rgl} elements added (line, tick marks and labels).
#'
#' @references
#' Dominic Woolf (2013, Mar 23). R rgl distance between axis ticks and tick labels,
#' Stack Overflow, <https://stackoverflow.com/a/39299740/4303451>.
#'
#' @seealso [splot3d()], [fplot3d()], [rgl::axis3d()]
#'
#' @examples
#' library(rgl)
#' open3d() # Alternatively, use `new3d()` to clear the current device or open a new one
#' set.seed(1)
#' points3d(rnorm(100), rnorm(100), rnorm(100))
#' box3d()
#' # Draw several z axis at z+- and z--, with longer tick marks and
#' # labels closer to them than usual
#' axis3('z+-', ticksize = 0.5, labeldist = 1)
#' axis3('z+-', ticksize = 0.5, labeldist = 1, tickangle = 0)
#' axis3('z--', ticksize = 0.5, labeldist = 1, tickangle = 90)
#'
#' @export
# ··············································································
axis3 <- function (edge, at = NULL, labels = TRUE, tick = TRUE, line = TRUE,
                   pos = NULL, nticks = 5, ticksize = 0.05, tickangle = 45,
                   labeldist = 3, ...) {
  # ··············································································
  save <- rgl::par3d(skipRedraw = TRUE, ignoreExtent = TRUE)
  on.exit(rgl::par3d(save))
  ranges <- .getRanges()
  edge <- c(strsplit(edge, "")[[1]], "-", "-")[1:3]
  coord <- match(toupper(edge[1]), c("X", "Y", "Z"))
  if (coord == 2)
    edge[1] <- edge[2]
  else if (coord == 3)
    edge[1:2] <- edge[2:3]
  range <- ranges[[coord]]
  if (is.null(at)) {
    at <- pretty(range, nticks)
    at <- at[at >= range[1] & at <= range[2]]
  }
  if (is.logical(labels)) {
    if (labels)
      labels <- format(at)
    else labels <- NA
  }
  mpos <- matrix(NA, 3, length(at))
  if (edge[1] == "+")
    mpos[1, ] <- ranges$x[2]
  else mpos[1, ] <- ranges$x[1]
  if (edge[2] == "+")
    mpos[2, ] <- ranges$y[2]
  else mpos[2, ] <- ranges$y[1]
  if (edge[3] == "+")
    mpos[3, ] <- ranges$z[2]
  else mpos[3, ] <- ranges$z[1]
  ticksize <- ticksize * (mpos[, 1] - c(mean(ranges$x), mean(ranges$y),
                                        mean(ranges$z)))
  other <- setdiff(1:3, coord)
  theta <- tickangle * pi / 180
  ticksize[other] <- ticksize[other] * c(cos(theta), sin(theta))
  ticksize[coord] <- 0
  if (!is.null(pos))
    mpos <- matrix(pos, 3, length(at))
  mpos[coord, ] <- at
  result <- c()
  if (line) {
    x <- c(mpos[1, 1], mpos[1, length(at)])
    y <- c(mpos[2, 1], mpos[2, length(at)])
    z <- c(mpos[3, 1], mpos[3, length(at)])
    result <- c(line = rgl::segments3d(x, y, z, ...))
  }
  if (tick) {
    x <- as.double(rbind(mpos[1, ], mpos[1, ] + ticksize[1]))
    y <- as.double(rbind(mpos[2, ], mpos[2, ] + ticksize[2]))
    z <- as.double(rbind(mpos[3, ], mpos[3, ] + ticksize[3]))
    result <- c(result, ticks = rgl::segments3d(x, y, z, ...))
  }
  if (!all(is.na(labels)))
    result <- c(result, labels = rgl::text3d(mpos[1, ] + labeldist * ticksize[1],
                                             mpos[2, ] + labeldist * ticksize[2],
                                             mpos[3, ] + labeldist * ticksize[3],
                                             labels, ...))
  rgl::lowlevel(result)
}

# rgl:::.getRanges()
#' @keywords internal
.getRanges <- function (expand = 1.03, ranges = rgl::par3d("bbox")) {
  ranges <- list(xlim = ranges[1:2], ylim = ranges[3:4], zlim = ranges[5:6])
  strut <- FALSE
  ranges <- lapply(ranges, function(r) {
    d <- diff(r)
    if (d > 0)
      return(r)
    strut <<- TRUE
    if (d < 0)
      return(c(0, 1))
    else if (r[1] == 0)
      return(c(-1, 1))
    else return(r[1] + 0.4 * abs(r[1]) * c(-1, 1))
  })
  ranges$strut <- strut
  ranges$x <- (ranges$xlim - mean(ranges$xlim)) * expand +
    mean(ranges$xlim)
  ranges$y <- (ranges$ylim - mean(ranges$ylim)) * expand +
    mean(ranges$ylim)
  ranges$z <- (ranges$zlim - mean(ranges$zlim)) * expand +
    mean(ranges$zlim)
  ranges
}


