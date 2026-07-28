#····································································
#   new3d.R (legendplot package)
#····································································
#   new3d
#   setmousemode
#   pan3d
#
#   (c) Ruben Fernandez-Casal
#   Created: Jul 2026, Modified:
#
#   NOTE: Press Ctrl + Shift + O to show document outline in RStudio
#····································································

# ··············································································
# new3d ----
# ··············································································

#' New 'rgl' plot
#'
#' Clear the current rgl device or open a new one (if there are no devices or
#' if `open = TRUE`).
#' Additionally assign the middle button to zoom (via [setmousemode()]) and
#' the right button to panning (via [pan3d()]).
#'
#' @param open if `TRUE` a new rgl device is opened.
#' @param clear rgl stack(s) to remove, see argument `type` in [rgl::clear3d()]
#'  (used only if there is an active device and `open = FALSE`).
#'  Defaults to `"all"`, with a new light source added to the scene.
#' @param ... additional arguments, passed to [rgl::open3d()] or [rgl::clear3d()].
#' @return
#'  Called for its side effect (opens or clears the rgl device, and configures
#'  the mouse mode); invisibly returns the current device.
#' @seealso
#'  [rgl::open3d()], [rgl::clear3d()]
#'
#' @examples
#' library(rgl)
#' # New rgl device
#' new3d()
#' shade3d(volcanom, col = "lightgreen")
#' # Use the right mouse button to panning and the middle button to zoom
#' # ...
#' # Clear the current device
#' new3d()
#' sshade3d(volcanom, s = volcanom$vb[3, ], meshColor = "facesvertices",
#'          col = terrain.colors(128))
#' @export
new3d <- function(open = FALSE, clear = "all", ...) {
  open <- open | !length(rgl::rgl.dev.list())
  if (open) {
    rgl::open3d(...)
  } else {
    rgl::clear3d(..., type = clear)
    if (clear == "all") rgl::light3d()
  }
  setmousemode(middle = "zoom")
  pan3d(2)
  invisible(rgl::cur3d())
}

# ··············································································
# internals ----
# ··············································································

#' @name mouse-actions
#' @aliases setmousemode
#' @title Utilities for setting the 'rgl' mouse actions
#' @description
#'  Functions to set the mouse button mode for current and new rgl devices,
#'  and enable panning of the active subscene;
#'  see *Details* for additional information.
#' @details
#'  `setmousemode()` sets the mouse button mode for current and new rgl devices
#'  (via [rgl::par3d()]).
#' @param none,left,right,middle,wheel actions for the corresponding mouse button;
#'  see parameter `mouseMode` of [rgl::par3d()].
#' @return
#'  `setmousemode()` invisibly returns the resulting `mouseMode` vector.
#' @seealso [rgl::par3d()]
#'
#' @examples
#' library(rgl)
#' open3d()
#' setmousemode(middle = "zoom")
#' pan3d(2)
#' shade3d(volcanom, col = "lightgreen")
#'
# @keywords internal
#' @export
# ··············································································
setmousemode <- function(none = "none", left = "trackball", right = "zoom",
                         middle = "fov", wheel = "pull") {
  mouseMode <- c(none = none, left = left, right = right, middle = middle, wheel = wheel)
  # if (exists("r3dDefaults", envir = globalenv(), inherits = FALSE)) {
  #   # Users may create their own variable named r3dDefaults in the
  #   # global environment and it will override the installed one
  #   assign("r3dDefaults$mouseMode", mouseMode, envir = globalenv())
  # } else
    rgl::par3d(mouseMode = mouseMode)
  invisible(mouseMode)
}


# Enable panning with a mouse button in rgl
# The help of rgl.setMouseCallbacks() shows how to modify a button to enable panning
# Run pan3d(2) after open3d()
# ··············································································
#' @rdname mouse-actions
#' @details `pan3d()` configures the callback functions of a mouse button so
#'  that dragging it pans the active subscene of an (opened) rgl device.
#'
#' @param button mouse button on which panning is configured.
#'  Use 1 for left, 2 for right, 3 for middle, 4 for wheel, and 0 to set this
#'  action when no button is pressed.
#' @param dev rgl device on which the callback is configured. Defaults to
#'  the active device (see [rgl::cur3d()]).
#' @param subscene subscene on which the callback is configured. Defaults
#'  to the device's active subscene.
#' @param message whether to print a message confirming the configured button,
#'  device and subscene.
#' @return
#'  `pan3d()` is called for its side effect (registers the mouse callbacks); it
#'  optionally prints a message confirming the configured button, device and
#'  subscene.
#' @seealso [rgl::rgl.setMouseCallbacks()]
# @keywords internal
#' @export
# ··············································································
pan3d <- function(button, dev = cur3d(), subscene = currentSubscene3d(dev),
                  message = FALSE) {
  start <- list()

  begin <- function(x, y) {
    activeSubscene <- par3d("activeSubscene", dev = dev)
    start$listeners <<- par3d("listeners", dev = dev, subscene = activeSubscene)
    for (sub in start$listeners) {
      init <- par3d(c("userProjection","viewport"), dev = dev, subscene = sub)
      init$pos <- c(x/init$viewport[3], 1 - y/init$viewport[4], 0.5)
      start[[as.character(sub)]] <<- init
    }
  }

  update <- function(x, y) {
    for (sub in start$listeners) {
      init <- start[[as.character(sub)]]
      xlat <- 2*(c(x/init$viewport[3], 1 - y/init$viewport[4], 0.5) - init$pos)
      mouseMatrix <- translationMatrix(xlat[1], xlat[2], xlat[3])
      par3d(userProjection = mouseMatrix %*% init$userProjection, dev = dev, subscene = sub )
    }
  }
  rgl.setMouseCallbacks(button, begin, update, dev = dev, subscene = subscene)
  if (message)
    message("Callbacks set on button ", button, " of RGL device ", dev,
            " in subscene ", subscene)
}

