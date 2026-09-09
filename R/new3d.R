#····································································
#   new3d.R (legendplot package)
#····································································
#   new3d
#   setmouse3d
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
#'
#' In addition, `new3d()` changes several of the default mouse actions in \pkg{rgl},
#' assigning the middle button to zoom (via [setmouse3d()]), the right button
#' to pan (via [pan3d()]), and enabling a double-click with the left button to
#' restore the scene's default viewpoint (via [dbltrack3d()]; keeping the mouse
#' acting as a virtual trackball, rotating the scene, when this button is held down).
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
#'  [rgl::open3d()], [rgl::clear3d()], [setmouse3d()], [pan3d()], [dbltrack3d()].
#'
#' @examples
#' library(rgl)
#' # New rgl device
#' new3d()
#' shade3d(volcanom, col = "lightgreen")
#' # Use the right mouse button to panning,
#' # the middle button (or wheel) to zoom,
#' # rotate as usual with left button; double-click resets the view
#' # NOTE: these mouse actions currently **do not work with RMarkdown** documents.
#' # ...
# # Force the HTML widget to be displayed if knitr is executing the code
# if (!is.null(getOption('knitr.in.progress'))) rglwidget()
# # Normally, the previous line would not be included
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
  setmouse3d(middle = "zoom") # zoom with middle button (or wheel)
  pan3d(2) # pan the subscene with right button
  dbltrack3d(1) # rotate as usual with left button; double-click resets the view
  # Add default viewpoint
  assign("default", rgl::par3d(.namesview3d), envir = .viewpoints3d)
  return(invisible(rgl::cur3d()))
}


# ··············································································
# mouse actions ----
# ··············································································

#' @name mouse-actions
#' @aliases setmouse3d
#' @title Utilities for setting the 'rgl' mouse actions
#' @description
#' Functions to set the mouse button actions for an `rgl` subscene
#' (the current one on the active device by default).
#'
#' `setmouse3d()` sets the 'rgl' built-in mouse button modes (via [rgl::par3d()]).
#'
#' @param none,left,right,middle,wheel actions for the corresponding mouse button;
#'  see parameter `mouseMode` of [rgl::par3d()].
#' @param dev rgl device on which the mouse actions are configured. Defaults to
#'  the active device (see [rgl::cur3d()]).
#' @param subscene subscene on which the mouse actions are configured. Defaults
#'  to the device's active subscene (see [rgl::currentSubscene3d()]).
#' @return
#'  `setmouse3d()` invisibly returns the resulting `mouseMode` vector.
#' @seealso [new3d()], [rgl::par3d()], [rgl::rgl.setMouseCallbacks()].
#'
#' @examples
#' library(rgl)
#' open3d()
#' setmouse3d(middle = "zoom") # zoom with middle button or wheel
#' pan3d(2) # pan the subscene with right button
#' dbltrack3d(1) # rotate as usual with left button; double-click resets the view
#' shade3d(volcanom, col = "lightgreen")
#' @export
# ··············································································
setmouse3d <- function(none = "none", left = "trackball", right = "zoom",
                       middle = "fov", wheel = "pull",
                       dev = cur3d(), subscene = currentSubscene3d(dev)) {
  mouseMode <- c(none = none, left = left, right = right, middle = middle, wheel = wheel)
  # if (exists("r3dDefaults", envir = globalenv(), inherits = FALSE)) {
  #   # Users may create their own variable named r3dDefaults in the
  #   # global environment and it will override the installed one
  #   assign("r3dDefaults$mouseMode", mouseMode, envir = globalenv())
  # } else
  rgl::par3d(mouseMode = mouseMode, dev = dev, subscene = subscene)
  return(invisible(mouseMode))
}


# Enable panning with a mouse button in rgl
# The help of rgl.setMouseCallbacks() shows how to modify a button to enable panning
# Run pan3d(2) after open3d()
# ··············································································
#' @rdname mouse-actions
#' @description
#' `pan3d()` configures the callback functions of a mouse button so
#'  that dragging it pans the subscene of an (opened) rgl device.
#' @details
#' `pan3d()` is based on the function of the same name included as an example
#' in the documentation of [rgl::rgl.setMouseCallbacks()].
#'
#' @param button mouse button on which panning is configured.
#'  Use 1 for left, 2 for right, 3 for middle, 4 for wheel, and 0 to set this
#'  action when no button is pressed.
#' @param message whether to print a message confirming the configured button,
#'  device and subscene.
#' @return
#'  `pan3d()` is called for its side effect (registers the mouse callbacks); it
#'  optionally prints a message confirming the configured button, device and
#'  subscene.
#' @export
# ··············································································
pan3d <- function(button, dev = cur3d(), subscene = currentSubscene3d(dev),
                  message = FALSE) {
  start <- list()

  begin <- function(x, y) {
    activeSubscene <- rgl::par3d("activeSubscene", dev = dev)
    start$listeners <<- rgl::par3d("listeners", dev = dev, subscene = activeSubscene)
    for (sub in start$listeners) {
      init <- rgl::par3d(c("userProjection","viewport"), dev = dev, subscene = sub)
      init$pos <- c(x/init$viewport[3], 1 - y/init$viewport[4], 0.5)
      start[[as.character(sub)]] <<- init
    }
  }

  update <- function(x, y) {
    for (sub in start$listeners) {
      init <- start[[as.character(sub)]]
      xlat <- 2*(c(x/init$viewport[3], 1 - y/init$viewport[4], 0.5) - init$pos)
      mouseMatrix <- translationMatrix(xlat[1], xlat[2], xlat[3])
      rgl::par3d(userProjection = mouseMatrix %*% init$userProjection, dev = dev, subscene = sub )
    }
  }

  rgl::rgl.setMouseCallbacks(button, begin, update, dev = dev, subscene = subscene)
  if (message)
    message("Callbacks set on button ", button, " of RGL device ", dev,
            " in subscene ", subscene)
} # pan3d()


# dbltrack3d()
# rgl has no built-in double-click event (only begin/update/end for mouse
# drags, and a 'rotate' event for the wheel), so double-click detection is
# implemented from scratch here, on top of a reimplementation of the
# standard "trackball" rotation (following rgl's own demo(mouseCallbacks),
# since that reimplementation is not exported/reusable as-is).
#' @rdname mouse-actions
#' @description
#' `dbltrack3d()` installs, on the given mouse button of an `rgl` (sub)scene,
#' the standard "trackball" rotation behavior (as that of parameter `mouseMode`
#' of [rgl::par3d()]), extended so that double-clicking resets the
#' viewpoint to "default" values.
#' @details
#' `dbltrack3d()` reimplements the standard trackball rotation (following the
#' `mouseCallbacks` demo shipped with \pkg{rgl}, `demo(mouseCallbacks,
#' package = "rgl")`) so that it can measure the
#' time elapsed since the previous click; if this is below `max.interval`,
#' the click is treated as a double-click and the view is reset instead of
#' starting a new rotation.
#'
#' @param max.interval maximum time, in seconds, between two clicks for
#'  them to be treated as a double-click.
#' @param capture.now logical; if `FALSE` (default) the "default" viewpoint is
#'  restored on double-click (see [setviewpoint3d()]).
#'  If `TRUE` the "reset" viewpoint is set to the values in effect
#'  when `dbltrack3d()` is called.
#' @return
#' `dbltrack3d()` is called for its side effect (registers the mouse callbacks); it
#'  optionally prints a message confirming the configured button, device and
#'  subscene.
#' @export
# ··············································································
dbltrack3d <- function(button = 1, max.interval = 0.4, capture.now = FALSE,
                       message = FALSE, dev = cur3d(), subscene = currentSubscene3d(dev)) {
  # ··············································································
  # dev = rgl::cur3d(); subscene = rgl::currentSubscene3d(dev)
  if (capture.now) {
    # "home" viewpoint to restore on double-click, captured now
    homeview <- rgl::par3d(.namesview3d, dev = dev, subscene = subscene)
    resetview <- function()
      do.call(rgl::par3d, c(homeview, list(dev = dev, subscene = subscene)))
  } else
    resetview <- function() setviewpoint3d("default")

  width <- height <- rotBase <- userMatrix <- NULL
  last.click <- -Inf

  screenToVector <- function(x, y) {
    radius <- max(width, height) / 2
    centre <- c(width, height) / 2
    pt <- (c(x, y) - centre) / radius
    len <- vlen(pt)
    if (len > 1e-6) pt <- pt / len
    maxlen <- sqrt(2)
    ang <- (maxlen - len) / maxlen * pi / 2
    z <- sin(ang)
    len <- sqrt(1 - z^2)
    c(pt * len, z)
  }

  # mouse-down: either reset (double-click) or start a rotation (single click)
  begin <- function(x, y) {
    now <- as.numeric(Sys.time())
    if (now - last.click < max.interval) {
      # double-click: reset the viewpoint; don't start a rotation
      resetview()
      rotBase <<- NULL
      last.click <<- -Inf # avoid a 3rd close click being treated as another double-click
    } else {
      vp <- rgl::par3d("viewport", dev = dev, subscene = subscene)
      width <<- vp[3]
      height <<- vp[4]
      userMatrix <<- rgl::par3d("userMatrix", dev = dev, subscene = subscene)
      rotBase <<- screenToVector(x, height - y)
      last.click <<- now
    }
  }

  # mouse-move while held down: standard trackball rotation (skipped right
  # after a reset, since rotBase is NULL then)
  update <- function(x, y) {
    if (is.null(rotBase)) return(invisible(NULL))
    rotCurrent <- screenToVector(x, height - y)
    ang <- vangle(rotBase, rotCurrent)
    ax <- xprod(rotBase, rotCurrent)
    mouseMatrix <- rgl::rotationMatrix(ang, ax[1], ax[2], ax[3])
    rgl::par3d(userMatrix = mouseMatrix %*% userMatrix, dev = dev, subscene = subscene)
  }

  rgl::rgl.setMouseCallbacks(button, begin = begin, update = update, end = NULL,
                             dev = dev, subscene = subscene)
  if (message)
    message("Callbacks set on button ", button, " of RGL device ", dev,
            " in subscene ", subscene)
} # dbltrack3d()



# ··············································································
# legendplot internals ----
# ··············································································

#' @keywords internal
xprod <- function(a, b)
  c(a[2] * b[3] - a[3] * b[2], a[3] * b[1] - a[1] * b[3], a[1] * b[2] - a[2] * b[1])

#' @keywords internal
vlen <- function(a) sqrt(sum(a^2))

#' @keywords internal
vangle <- function(a, b) acos(sum(a * b) / vlen(a) / vlen(b))


