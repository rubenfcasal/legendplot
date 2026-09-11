## ----include = FALSE----------------------------------------------------------
knitr::opts_chunk$set(
  collapse = TRUE,
  comment = "##",
  fig.dim = c(6, 5), 
  fig.align = "center"
)
library(rgl)
setupKnitr(autoprint = TRUE)

## ----setup--------------------------------------------------------------------
library(legendplot)

## ----splot--------------------------------------------------------------------
scale.range <- range(mtcars$mpg)
res <- splot(slim = scale.range, legend.lab = "mpg")
with(mtcars, 
     plot(hp, qsec, col = scolor(mpg, slim = scale.range),
          pch = 16, cex = 1.5, main = "Motor Trend Car Road Tests")
)
par(res$old.par) # restore graphical parameters; equivalent to `par.reset()`

## ----splot-shared-legend, fig.dim=c(9, 5)-------------------------------------
set.seed(1)
nx <- c(40, 40)
x1 <- seq(-1, 1, length.out = nx[1])
x2 <- seq(-1, 1, length.out = nx[2])
trend <- outer(x1, x2, function(x, y) x^2 - y^2)
y <- trend + rnorm(prod(nx), 0, 0.1)

scale.range <- c(-1.2, 1.2)
scale.color <- jet.colors(256)

old.par <- par(mfrow = c(1, 2), omd = c(0.05, 0.85, 0.05, 0.95))
image(x1, x2, trend, zlim = scale.range, main = "Trend", col = scale.color)
image(x1, x2, y, zlim = scale.range, main = "Data", col = scale.color)
par(old.par)
splot(slim = scale.range, col = scale.color, legend.shrink = 0.7, add = TRUE)

## ----spoints------------------------------------------------------------------
with(mtcars, 
     spoints(hp, qsec, mpg, main = "Motor Trend Car Road Tests",
             xlab = "Horsepower", ylab = "1/4 mile time", 
             legend.lab = "Miles per gallon")
)

## ----simage-spersp, fig.dim=c(9, 5)-------------------------------------------
old.par <- par(mfrow = c(1, 2))
spersp(x1, x2, trend, slim = scale.range, main = "Trend", zlab = "y", legend = FALSE)
simage(x1, x2, y, slim = scale.range, main = "Data", legend.mar = 10, legend.width = 3)
par(old.par)

## ----fplot--------------------------------------------------------------------
f <- as.factor(mtcars$cyl)
res <- fplot(levels(f), col = cat.colors(nlevels(f)), type = "point",
             legend.lab = "cyl")
with(mtcars, plot(hp, qsec, col = fcolor(f, col = res$col),
                   pch = 16, cex = 1.5, main = "Motor Trend Car Road Tests"))
par.reset() # par(res$old.par)

## ----fpoints, eval=FALSE------------------------------------------------------
# with(mtcars,
#      fpoints(hp, qsec, f = cyl, col = cat.colors(cyl),
#              main = "Motor Trend Car Road Tests")
# )

## ----splot3d------------------------------------------------------------------
library(rgl)
# Use `open3d()` or `new3d()` to open a new device.
scale.range <- range(mtcars$mpg)
splot3d(slim = scale.range, legend.lab = "mpg")
with(mtcars, 
     plot3d(hp, qsec, wt, type = "s",
            col = scolor(mpg, slim = scale.range))
)

## ----spoints3d, eval=FALSE----------------------------------------------------
# with(mtcars, spoints3d(hp, qsec, wt, s = mpg, type = "s"))

## ----sshade3d-----------------------------------------------------------------
sshade3d(volcanom, s = volcanom$vb[3, ], meshColor = "facesvertices")

