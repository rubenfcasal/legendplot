#····································································
#   legendplot package ----
#····································································
#
#   (c) Ruben Fernandez-Casal
#   Created: Jul 2026
#
#   NOTE: Press Ctrl + Shift + O to show document outline in RStudio
#····································································

#' legendplot: Standard and 'rgl' Plots with Legends
#'
#' This package provides tools to combine standard R plots or 'rgl' 3D plots
#' with a legend, facilitating the creation of composite figures that mix 2D or 3D
#' visualizations with a categorical or continuous legend.
#' For more information visit <https://rubenfcasal.github.io/legendplot/articles/legendplot.html>.
#' @aliases legendplot
#' @import graphics
#' @import rgl
#' @importFrom grDevices colorRamp rgb
# @importFrom methods is
# @name legendplot-package
# @docType package
"_PACKAGE"



#' Surface Mesh of Auckland's Maunga Whau Volcano
#'
#' Surface mesh corresponding to the altitude on a 10m by 10m grid
#' of Auckland's Maunga Whau volcano.
#'
#' @format ## `volcanom`
#' A [rgl::mesh3d]-class object with 5307 vertices and 10320 triangles.
#' @source
#' [datasets::volcano] and example taken from [rgl::surface3d].
#' @examples
#' library(rgl)
#' open3d()
#' aspect3d(1, 1, 3)  # Exaggerate the relief
#' shade3d(volcanom, col = "lightgreen")
"volcanom"

# library(rgl)
# # Malla de datos `volcano` (?surface3d)
# # z <- 2 * volcano # Exaggerate the relief
# z <- volcano
# x <- 10 * (seq_len(nrow(z)) - 1) # 10 meter spacing (S to N)
# y <- 10 * (seq_len(ncol(z)) - 1) # 10 meter spacing (E to W)
# surface3d(x, y, z, back = "lines")
# volcanom <- as.mesh3d()
# usethis::use_data(volcanom, overwrite = TRUE)
# ?datasets::volcano



#····································································
.onAttach <- function(libname, pkgname) {
#····································································
  # pkg.info <- utils::packageDescription(pkgname, libname, fields = c("Title", "Version", "Date"))
  pkg.info <- drop(read.dcf(
    file = system.file("DESCRIPTION", package = "legendplot"),
    fields = c("Title", "Version", "Date")
  ))
  packageStartupMessage(
    paste0("\n legendplot: ", pkg.info["Title"], ",\n"),
    paste0(" version ", pkg.info["Version"], " (built on ", pkg.info["Date"], ").\n"),
    paste0(" Copyright (C) R. Fernandez-Casal 2012-", format(as.Date(pkg.info["Date"]), "%Y"), ".\n"),
    " Type `vignette(\"legendplot\", package = \"legendplot\")`\n",
    " or visit https://rubenfcasal.github.io/legendplot\n",
    " for an overview.\n"
  )

  # # Are we running in reprex::reprex?  If so, do
  # # the knitr setup so our output appears there.
  # options(rgl.useNULL = TRUE)
  # in_reprex <- !is.null(getOption("reprex.current_venue"))
  # if (in_reprex) {
  #   setupKnitr(autoprint = TRUE)
  # }
}
