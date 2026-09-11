# 3D scatter plot with a categorical legend

A generic function that, by default, draws a 3D scatter plot
([`rgl::plot3d()`](https://dmurdoch.github.io/rgl/dev/reference/plot3d.html))
with points colored according to the levels of a factor `f`, and
(optionally) adds a categorical legend (via
[`fplot3d()`](https://rubenfcasal.github.io/legendplot/reference/fplot3d.md)).

## Usage

``` r
fpoints3d(x, ...)

# Default S3 method
fpoints3d(
  x,
  y = NULL,
  z = NULL,
  f,
  col = hcld.colors(nlevels(f)),
  xlab = NULL,
  ylab = NULL,
  zlab = NULL,
  type = "p",
  legend = TRUE,
  legend.type = c("s", "c", "p", "l"),
  legend.zoom = 0.6,
  legend.width = 0.2,
  legend.size = 4,
  legend.dim = 0.2,
  legend.lab = NULL,
  lab.dist = 2.5,
  lab.rev = FALSE,
  add = FALSE,
  ...
)
```

## Arguments

- x:

  object used to select a method. In the default method, it provides the
  `x` coordinates for the plot (and optionally the `y` and `z`
  coordinates; any reasonable way of defining the coordinates is
  acceptable, see the function
  [`xyz.coords()`](https://rdrr.io/r/grDevices/xyz.coords.html) for
  details).

- ...:

  additional arguments passed to
  [`rgl::plot3d()`](https://dmurdoch.github.io/rgl/dev/reference/plot3d.html)
  for the main scatter plot (e.g. `size`).

- y, z:

  `y` and `z` point coordinates. Alternatively, a single argument `x`
  can be provided.

- f:

  (factor, or vector coercible to factor), used to color the points.

- col:

  vector of colors associated with each level of `f` (defaults to
  `hcld.colors(nlevels(f))`).

- xlab, ylab, zlab:

  labels for the coordinates.

- type:

  character indicating the type of item to plot (see
  [`rgl::plot3d()`](https://dmurdoch.github.io/rgl/dev/reference/plot3d.html):
  `"p"` for points, `"s"` for spheres, `"l"` for lines, `"h"` for line
  segments from z = 0, and `"n"` for nothing).

- legend:

  logical; if `TRUE` (default), the active rgl device is splitted into
  two subscenes, drawing the main plot in one and the categorical legend
  in the other (see
  [`fplot3d()`](https://rubenfcasal.github.io/legendplot/reference/fplot3d.md)).
  if `FALSE` only the (coloured) main plot is drawn and the arguments
  related to the legend are ignored
  ([`fplot3d()`](https://rubenfcasal.github.io/legendplot/reference/fplot3d.md)
  is not called).

- legend.type:

  character; symbol/object used to represent each level in the legend
  (see `type` in
  [`fplot3d()`](https://rubenfcasal.github.io/legendplot/reference/fplot3d.md)):
  `"s"` for spheres (default), `"c"` for cubes, `"p"` for points, or
  `"l"` for (horizontal) line segments.

- legend.zoom:

  zoom factor applied to the legend subscene/panel.

- legend.width:

  relative size of the legend symbols (spheres, cubes or line segments),
  as a fraction of the corresponding dimension of the legend subscene.

- legend.size:

  point size, if `type = "p"`, or line width, if `type = "l"` (in
  pixels; see `size` and `lwd` graphical parameters in
  [`rgl::par3d()`](https://dmurdoch.github.io/rgl/dev/reference/par3d.html);
  ignored in all other cases).

- legend.dim:

  relative dimension of the legend panel, as a fraction of the full
  width (or height) of the device.

- legend.lab:

  label for the axis of the color legend, defaults to a description of
  `f`.

- lab.dist:

  distance between the legend symbols and their text labels, as a
  multiple of the symbol size (`legend.width`).

- lab.rev:

  logical; if `TRUE` the order of the levels in the legend is reversed
  (by default they are shown from top to bottom).

- add:

  logical; if `TRUE` the scatter plot is just added to the existing plot
  (including the legend if `legend = TRUE`).

## Value

Called for its side effect (draws the 3D scatter plot and, unless
`legend = FALSE`, the legend on the active rgl device).

## See also

[`spoints3d()`](https://rubenfcasal.github.io/legendplot/reference/spoints3d.md),
[`fplot3d()`](https://rubenfcasal.github.io/legendplot/reference/fplot3d.md),
[`fcolor()`](https://rubenfcasal.github.io/legendplot/reference/categorical-color.md),
[`fshade3d()`](https://rubenfcasal.github.io/legendplot/reference/fshade3d.md),
[`rgl::plot3d()`](https://dmurdoch.github.io/rgl/dev/reference/plot3d.html).

## Examples

``` r
library(rgl)
open3d() # Alternatively, use `new3d()` to clear the current device or open a new one
with(mtcars, fpoints3d(hp, qsec, mpg, f = cyl, type = "s"))
3D plot

{"x":{"material":{"color":"#000000","alpha":1,"lit":true,"ambient":"#000000","specular":"#FFFFFF","emission":"#000000","shininess":50,"smooth":true,"front":"filled","back":"filled","size":3,"lwd":1,"fog":true,"point_antialias":false,"line_antialias":false,"texture":null,"textype":"rgb","texmode":"modulate","texmipmap":false,"texminfilter":"linear","texmagfilter":"linear","texenvmap":false,"depth_mask":true,"depth_test":"less","isTransparent":false,"polygon_offset":[0,0],"margin":"","floating":false,"tag":"","blend":["src_alpha","one_minus_src_alpha"]},"rootSubscene":73,"objects":{"82":{"id":82,"type":"spheres","material":{"lit":false},"vertices":"0","colors":"1","radii":[[0.03999999910593033]],"centers":"2","ignoreExtent":false,"fastTransparency":true,"flags":32770},"83":{"id":83,"type":"text","material":{"lit":false},"vertices":"3","colors":"4","texts":[["4"],["6"],["8"]],"cex":[[1]],"adj":[[0,0.5,0.5]],"centers":"5","family":[["sans"]],"font":[[1]],"ignoreExtent":false,"flags":33808},"85":{"id":85,"type":"text","material":{"lit":false,"margin":2,"edge":[-1,-1,-1]},"vertices":"6","colors":"7","texts":[["cyl"]],"cex":[[1]],"adj":[[1,0.5,0.5]],"centers":"8","family":[["sans"]],"font":[[1]],"ignoreExtent":true,"flags":33808},"88":{"id":88,"type":"spheres","material":{},"vertices":"9","colors":"10","radii":[[8.201210021972656]],"centers":"11","ignoreExtent":false,"fastTransparency":true,"flags":32771},"90":{"id":90,"type":"text","material":{"lit":false,"margin":0,"floating":true,"edge":[0,1,1]},"vertices":"12","colors":"13","texts":[["hp"]],"cex":[[1]],"adj":[[0.5,0.5,0.5]],"centers":"14","family":[["sans"]],"font":[[1]],"ignoreExtent":true,"flags":33808},"91":{"id":91,"type":"text","material":{"lit":false,"margin":1,"floating":true,"edge":[1,1,1]},"vertices":"15","colors":"16","texts":[["qsec"]],"cex":[[1]],"adj":[[0.5,0.5,0.5]],"centers":"17","family":[["sans"]],"font":[[1]],"ignoreExtent":true,"flags":33808},"92":{"id":92,"type":"text","material":{"lit":false,"margin":2,"floating":true,"edge":[1,1,1]},"vertices":"18","colors":"19","texts":[["mpg"]],"cex":[[1]],"adj":[[0.5,0.5,0.5]],"centers":"20","family":[["sans"]],"font":[[1]],"ignoreExtent":true,"flags":33808},"77":{"id":77,"type":"light","vertices":[[0,0,1]],"colors":[[1,1,1,1],[1,1,1,1],[1,1,1,1]],"viewpoint":true,"finite":false},"79":{"id":79,"type":"background","material":{"lit":false,"back":"lines"},"colors":"21","centers":"22","sphere":false,"fogtype":"none","fogscale":1,"flags":32768},"84":{"id":84,"type":"bboxdeco","material":{"front":"culled","back":"culled"},"colors":"23","axes":{"mode":["none","none","none"],"step":[-1,-1,-1],"nticks":[0,0,0],"marklen":[15,15,15],"expand":[1.029999971389771,1.029999971389771,1.029999971389771]},"draw_front":false,"flags":32769},"89":{"id":89,"type":"bboxdeco","material":{"front":"lines","back":"lines"},"vertices":"24","colors":"25","axes":{"mode":["pretty","pretty","pretty"],"step":[50,2,5],"nticks":[5,5,5],"marklen":[15,15,15],"expand":[1.029999971389771,1.029999971389771,1.029999971389771]},"draw_front":true,"flags":32769},"80":{"id":80,"type":"subscene","par3d":{"antialias":8,"FOV":0,"ignoreExtent":false,"listeners":80,"mouseMode":{"none":"none","left":"none","right":"zoom","middle":"fov","wheel":"pull"},"observer":[0,0,0.9675800800323486],"modelMatrix":[[1,0,0,-0.0300000011920929],[0,-4.371138828673793e-08,1,-0.5],[0,-1,-4.371138828673793e-08,-0.9675800800323486],[0,0,0,1]],"projMatrix":[[3.44502067565918,0,0,0],[0,0.6863126754760742,0,0],[0,0,-2.067012310028076,-2],[0,0,0,1]],"skipRedraw":false,"userMatrix":[[1,0,0,0],[0,-4.371138828673793e-08,1,0],[0,-1,-4.371138828673793e-08,0],[0,0,0,1]],"userProjection":[[1,0,0,0],[0,1,0,0],[0,0,1,0],[0,0,0,1]],"scale":[1,1,1],"viewport":{"x":0.796875,"y":0,"width":0.19921875,"height":1},"zoom":0.6000000238418579,"bbox":[-0.03999999910593033,0.1000000014901161,-0.03999999910593033,0.03999999910593033,0.1266666650772095,0.8733333349227905],"windowRect":[242,265,498,521],"family":"sans","font":1,"cex":1,"useFreeType":false,"fontname":"TT Arial","maxClipPlanes":8,"glVersion":4.6,"activeSubscene":0},"embeddings":{"viewport":"replace","projection":"replace","model":"replace","mouse":"replace"},"objects":[84,82,83,85,77],"parent":73,"subscenes":[],"flags":34067},"81":{"id":81,"type":"subscene","par3d":{"antialias":8,"FOV":30,"ignoreExtent":false,"listeners":81,"mouseMode":{"none":"none","left":"trackball","right":"zoom","middle":"fov","wheel":"pull"},"observer":[0,0,764.6736450195312],"modelMatrix":[[0.5795910358428955,0,0,-112.1508636474609],[0,6.677713871002197,6.558555126190186,-270.1452331542969],[0,-18.34686660766602,2.387119054794312,-474.4619140625],[0,0,0,1]],"projMatrix":[[3.732050895690918,0,0,0],[0,2.973978042602539,0,0],[0,0,-3.86370325088501,-2756.559814453125],[0,0,-1,0]],"skipRedraw":false,"userMatrix":[[1,0,0,0],[0,0.3420201433256682,0.9396926207859085,0],[0,-0.9396926207859085,0.3420201433256682,0],[0,0,0,1]],"userProjection":[[1,0,0,0],[0,1,0,0],[0,0,1,0],[0,0,0,1]],"scale":[0.5795910358428955,19.52432823181152,6.979468822479248],"viewport":{"x":0,"y":0,"width":0.796875,"height":1},"zoom":1,"bbox":[37.85000610351562,349.1499938964844,14.07994937896729,23.3200511932373,9.22495174407959,35.07505035400391],"windowRect":[242,265,498,521],"family":"sans","font":1,"cex":1,"useFreeType":false,"fontname":"TT Arial","maxClipPlanes":8,"glVersion":4.6,"activeSubscene":0},"embeddings":{"viewport":"replace","projection":"replace","model":"replace","mouse":"replace"},"objects":[89,88,90,91,92,77],"parent":73,"subscenes":[],"flags":34067},"73":{"id":73,"type":"subscene","par3d":{"antialias":8,"FOV":30,"ignoreExtent":false,"listeners":73,"mouseMode":{"none":"none","left":"trackball","right":"zoom","middle":"fov","wheel":"pull"},"observer":[0,0,823.132080078125],"modelMatrix":[[1,0,0,0],[0,0.3420201539993286,0.9396926164627075,0],[0,-0.9396926164627075,0.3420201539993286,-823.132080078125],[0,0,0,1]],"projMatrix":[[3.732050657272339,0,0,0],[0,3.732050657272339,0,0],[0,0,-3.863703727722168,-2967.29638671875],[0,0,-1,0]],"skipRedraw":false,"userMatrix":[[1,0,0,0],[0,0.3420201433256682,0.9396926207859085,0],[0,-0.9396926207859085,0.3420201433256682,0],[0,0,0,1]],"userProjection":[[1,0,0,0],[0,1,0,0],[0,0,1,0],[0,0,0,1]],"scale":[1,1,1],"viewport":{"x":0,"y":0,"width":1,"height":1},"zoom":1,"bbox":[123,-123,123,-123,123,-123],"windowRect":[242,265,498,521],"family":"sans","font":1,"cex":1,"useFreeType":false,"fontname":"TT Arial","maxClipPlanes":8,"glVersion":4.6,"activeSubscene":0},"embeddings":{"viewport":"replace","projection":"replace","model":"replace","mouse":"replace"},"objects":[79,77,80,81],"subscenes":[80,81],"flags":34067}},"crosstalk":{"key":[],"group":[],"id":[],"options":[]},"width":576,"height":384,"buffer":{"accessors":[{"bufferView":0,"componentType":5126,"count":3,"type":"VEC3"},{"bufferView":1,"componentType":5121,"count":3,"type":"VEC4","normalized":true},{"bufferView":2,"componentType":5126,"count":3,"type":"VEC3"},{"bufferView":3,"componentType":5126,"count":3,"type":"VEC3"},{"bufferView":4,"componentType":5121,"count":1,"type":"VEC4"},{"bufferView":5,"componentType":5126,"count":3,"type":"VEC3"},{"bufferView":6,"componentType":5126,"count":1,"type":"VEC3"},{"bufferView":7,"componentType":5121,"count":1,"type":"VEC4"},{"bufferView":8,"componentType":5126,"count":1,"type":"VEC3"},{"bufferView":9,"componentType":5126,"count":32,"type":"VEC3"},{"bufferView":10,"componentType":5121,"count":32,"type":"VEC4","normalized":true},{"bufferView":11,"componentType":5126,"count":32,"type":"VEC3"},{"bufferView":12,"componentType":5126,"count":1,"type":"VEC3"},{"bufferView":13,"componentType":5121,"count":1,"type":"VEC4"},{"bufferView":14,"componentType":5126,"count":1,"type":"VEC3"},{"bufferView":15,"componentType":5126,"count":1,"type":"VEC3"},{"bufferView":16,"componentType":5121,"count":1,"type":"VEC4"},{"bufferView":17,"componentType":5126,"count":1,"type":"VEC3"},{"bufferView":18,"componentType":5126,"count":1,"type":"VEC3"},{"bufferView":19,"componentType":5121,"count":1,"type":"VEC4"},{"bufferView":20,"componentType":5126,"count":1,"type":"VEC3"},{"bufferView":21,"componentType":5121,"count":1,"type":"VEC4"},{"bufferView":22,"componentType":5121,"count":1,"type":"VEC3"},{"bufferView":23,"componentType":5121,"count":1,"type":"VEC4"},{"bufferView":24,"componentType":5126,"count":16,"type":"VEC3"},{"bufferView":25,"componentType":5121,"count":1,"type":"VEC4"}],"bufferViews":[{"buffer":0,"byteLength":36,"byteOffset":0},{"buffer":0,"byteLength":12,"byteOffset":36},{"buffer":0,"byteLength":36,"byteOffset":48},{"buffer":0,"byteLength":36,"byteOffset":84},{"buffer":0,"byteLength":4,"byteOffset":120},{"buffer":0,"byteLength":36,"byteOffset":124},{"buffer":0,"byteLength":12,"byteOffset":160},{"buffer":0,"byteLength":4,"byteOffset":172},{"buffer":0,"byteLength":12,"byteOffset":176},{"buffer":0,"byteLength":384,"byteOffset":188},{"buffer":0,"byteLength":128,"byteOffset":572},{"buffer":0,"byteLength":384,"byteOffset":700},{"buffer":0,"byteLength":12,"byteOffset":1084},{"buffer":0,"byteLength":4,"byteOffset":1096},{"buffer":0,"byteLength":12,"byteOffset":1100},{"buffer":0,"byteLength":12,"byteOffset":1112},{"buffer":0,"byteLength":4,"byteOffset":1124},{"buffer":0,"byteLength":12,"byteOffset":1128},{"buffer":0,"byteLength":12,"byteOffset":1140},{"buffer":0,"byteLength":4,"byteOffset":1152},{"buffer":0,"byteLength":12,"byteOffset":1156},{"buffer":0,"byteLength":4,"byteOffset":1168},{"buffer":0,"byteLength":3,"byteOffset":1172},{"buffer":0,"byteLength":4,"byteOffset":1175},{"buffer":0,"byteLength":192,"byteOffset":1180},{"buffer":0,"byteLength":4,"byteOffset":1372}],"buffers":[{"byteLength":1376,"bytes":"AAAAAAAAAABVVVU/AAAAAAAAAAAAAAA/AAAAAAAAAACrqio+4WqG/1CjFf8Amt7/AAAAAAAA\nAABVVVU/AAAAAAAAAAAAAAA/AAAAAAAAAACrqio+zczMPQAAAABVVVU/zczMPQAAAAAAAAA/\nzczMPQAAAACrqio+AAAAAc3MzD0AAAAAVVVVP83MzD0AAAAAAAAAP83MzD0AAAAAq6oqPgAA\nwH8AAKBAAAAAAAAAAAEAAMB/AACgQAAAAAAAANxCFK6DQQAAqEEAANxC9iiIQQAAqEEAALpC\nSOGUQWZmtkEAANxCH4WbQTMzq0EAAC9D9iiIQZqZlUEAANJCj8KhQc3MkEEAAHVDpHB9Qc3M\nZEEAAHhCAACgQTMzw0EAAL5CMzO3QWZmtkEAAPZCZmaSQZqZmUEAAPZCMzOXQWZmjkEAADRD\nMzOLQTMzg0EAADRDzcyMQWZmikEAADRDAACQQTMzc0EAAE1DCtePQWZmJkEAAFdDXI+OQWZm\nJkEAAGZDKVyLQTMza0EAAIRCj8KbQZqZAUIAAFBC9iiUQTMz80EAAIJCMzOfQZqZB0IAAMJC\nexSgQQAArEEAABZDw/WGQQAAeEEAABZDZmaKQTMzc0EAAHVDXI92Qc3MVEEAAC9DZmaIQZqZ\nmUEAAIRCMzOXQWZm2kEAALZCmpmFQQAA0EEAAOJCMzOHQTMz80EAAIRDAABoQc3MfEEAAC9D\nAAB4QZqZnUEAgKdDmplpQQAAcEEAANpCzcyUQTMzq0FQoxX/UKMV/+Fqhv9QoxX/AJre/1Cj\nFf8Amt7/4WqG/+Fqhv9QoxX/UKMV/wCa3v8Amt7/AJre/wCa3v8Amt7/AJre/+Fqhv/haob/\n4WqG/+Fqhv8Amt7/AJre/wCa3v8Amt7/4WqG/+Fqhv/haob/AJre/1CjFf8Amt7/4WqG/wAA\n3EIUroNBAACoQQAA3EL2KIhBAACoQQAAukJI4ZRBZma2QQAA3EIfhZtBMzOrQQAAL0P2KIhB\nmpmVQQAA0kKPwqFBzcyQQQAAdUOkcH1BzcxkQQAAeEIAAKBBMzPDQQAAvkIzM7dBZma2QQAA\n9kJmZpJBmpmZQQAA9kIzM5dBZmaOQQAANEMzM4tBMzODQQAANEPNzIxBZmaKQQAANEMAAJBB\nMzNzQQAATUMK149BZmYmQQAAV0Ncj45BZmYmQQAAZkMpXItBMzNrQQAAhEKPwptBmpkBQgAA\nUEL2KJRBMzPzQQAAgkIzM59BmpkHQgAAwkJ7FKBBAACsQQAAFkPD9YZBAAB4QQAAFkNmZopB\nMzNzQQAAdUNcj3ZBzcxUQQAAL0NmZohBmpmZQQAAhEIzM5dBZmbaQQAAtkKamYVBAADQQQAA\n4kIzM4dBMzPzQQAAhEMAAGhBzcx8QQAAL0MAAHhBmpmdQQCAp0OamWlBAABwQQAA2kLNzJRB\nMzOrQQAAwH8AAIBAAACAPwAAAAEAAMB/AACAQAAAgD8AAMB/AACAQAAAgD8AAAABAADAfwAA\ngEAAAIA/AADAfwAAgEAAAIA/AAAAAQAAwH8AAIBAAACAPwEBAQEAAAAAAAABAAAASEIAAMB/\nAADAfwAAyEIAAMB/AADAfwAAFkMAAMB/AADAfwAASEMAAMB/AADAfwAAekMAAMB/AADAfwAA\nlkMAAMB/AADAfwAAwH8AAIBBAADAfwAAwH8AAJBBAADAfwAAwH8AAKBBAADAfwAAwH8AALBB\nAADAfwAAwH8AAMB/AAAgQQAAwH8AAMB/AABwQQAAwH8AAMB/AACgQQAAwH8AAMB/AADIQQAA\nwH8AAMB/AADwQQAAwH8AAMB/AAAMQgAAAAE="}]},"context":{"shiny":false,"rmarkdown":null},"vertexShader":"#line 2 1\n// File 1 is the vertex shader\n#ifdef GL_ES\n#ifdef GL_FRAGMENT_PRECISION_HIGH\nprecision highp float;\n#else\nprecision mediump float;\n#endif\n#endif\n\nattribute vec3 aPos;\nattribute vec4 aCol;\nuniform mat4 mvMatrix;\nuniform mat4 prMatrix;\nvarying vec4 vCol;\nvarying vec4 vPosition;\n\n#ifdef NEEDS_VNORMAL\nattribute vec3 aNorm;\nuniform mat4 normMatrix;\nvarying vec4 vNormal;\n#endif\n\n#if defined(HAS_TEXTURE) || defined (IS_TEXT)\nattribute vec2 aTexcoord;\nvarying vec2 vTexcoord;\n#endif\n\n#ifdef FIXED_SIZE\nuniform vec3 textScale;\n#endif\n\n#ifdef FIXED_QUADS\nattribute vec3 aOfs;\n#endif\n\n#ifdef IS_TWOSIDED\n#ifdef HAS_NORMALS\nvarying float normz;\nuniform mat4 invPrMatrix;\n#else\nattribute vec3 aPos1;\nattribute vec3 aPos2;\nvarying float normz;\n#endif\n#endif // IS_TWOSIDED\n\n#ifdef FAT_LINES\nattribute vec3 aNext;\nattribute vec2 aPoint;\nvarying vec2 vPoint;\nvarying float vLength;\nuniform float uAspect;\nuniform float uLwd;\n#endif\n\n#ifdef USE_ENVMAP\nvarying vec3 vReflection;\n#endif\n\nvoid main(void) {\n  \n#ifndef IS_BRUSH\n#if defined(NCLIPPLANES) || !defined(FIXED_QUADS) || defined(HAS_FOG) || defined(USE_ENVMAP)\n  vPosition = mvMatrix * vec4(aPos, 1.);\n#endif\n  \n#ifndef FIXED_QUADS\n  gl_Position = prMatrix * vPosition;\n#endif\n#endif // !IS_BRUSH\n  \n#ifdef IS_POINTS\n  gl_PointSize = POINTSIZE;\n#endif\n  \n  vCol = aCol;\n  \n// USE_ENVMAP implies NEEDS_VNORMAL\n\n#ifdef NEEDS_VNORMAL\n  vNormal = normMatrix * vec4(-aNorm, dot(aNorm, aPos));\n#endif\n\n#ifdef USE_ENVMAP\n  vReflection = normalize(reflect(vPosition.xyz/vPosition.w, \n                        normalize(vNormal.xyz/vNormal.w)));\n#endif\n  \n#ifdef IS_TWOSIDED\n#ifdef HAS_NORMALS\n  /* normz should be calculated *after* projection */\n  normz = (invPrMatrix*vNormal).z;\n#else\n  vec4 pos1 = prMatrix*(mvMatrix*vec4(aPos1, 1.));\n  pos1 = pos1/pos1.w - gl_Position/gl_Position.w;\n  vec4 pos2 = prMatrix*(mvMatrix*vec4(aPos2, 1.));\n  pos2 = pos2/pos2.w - gl_Position/gl_Position.w;\n  normz = pos1.x*pos2.y - pos1.y*pos2.x;\n#endif\n#endif // IS_TWOSIDED\n  \n#ifdef NEEDS_VNORMAL\n  vNormal = vec4(normalize(vNormal.xyz), 1);\n#endif\n  \n#if defined(HAS_TEXTURE) || defined(IS_TEXT)\n  vTexcoord = aTexcoord;\n#endif\n  \n#if defined(FIXED_SIZE) && !defined(ROTATING)\n  vec4 pos = prMatrix * mvMatrix * vec4(aPos, 1.);\n  pos = pos/pos.w;\n  gl_Position = pos + vec4(aOfs*textScale, 0.);\n#endif\n  \n#if defined(IS_SPRITES) && !defined(FIXED_SIZE)\n  vec4 pos = mvMatrix * vec4(aPos, 1.);\n  pos = pos/pos.w + vec4(aOfs,  0.);\n  gl_Position = prMatrix*pos;\n#endif\n  \n#ifdef FAT_LINES\n  /* This code was inspired by Matt Deslauriers' code in \n   https://mattdesl.svbtle.com/drawing-lines-is-hard */\n  vec2 aspectVec = vec2(uAspect, 1.0);\n  mat4 projViewModel = prMatrix * mvMatrix;\n  vec4 currentProjected = projViewModel * vec4(aPos, 1.0);\n  currentProjected = currentProjected/currentProjected.w;\n  vec4 nextProjected = projViewModel * vec4(aNext, 1.0);\n  vec2 currentScreen = currentProjected.xy * aspectVec;\n  vec2 nextScreen = (nextProjected.xy / nextProjected.w) * aspectVec;\n  float len = uLwd;\n  vec2 dir = vec2(1.0, 0.0);\n  vPoint = aPoint;\n  vLength = length(nextScreen - currentScreen)/2.0;\n  vLength = vLength/(vLength + len);\n  if (vLength > 0.0) {\n    dir = normalize(nextScreen - currentScreen);\n  }\n  vec2 normal = vec2(-dir.y, dir.x);\n  dir.x /= uAspect;\n  normal.x /= uAspect;\n  vec4 offset = vec4(len*(normal*aPoint.x*aPoint.y - dir), 0.0, 0.0);\n  gl_Position = currentProjected + offset;\n#endif\n  \n#ifdef IS_BRUSH\n  gl_Position = vec4(aPos, 1.);\n#endif\n}","fragmentShader":"#line 2 2\n// File 2 is the fragment shader\n#ifdef GL_ES\n#ifdef GL_FRAGMENT_PRECISION_HIGH\nprecision highp float;\n#else\nprecision mediump float;\n#endif\n#endif\nvarying vec4 vCol; // carries alpha\nvarying vec4 vPosition;\n#if defined(HAS_TEXTURE) || defined (IS_TEXT)\nvarying vec2 vTexcoord;\nuniform sampler2D uSampler;\n#endif\n\n#ifdef HAS_FOG\nuniform int uFogMode;\nuniform vec3 uFogColor;\nuniform vec4 uFogParms;\n#endif\n\n#if defined(IS_LIT) && !defined(FIXED_QUADS)\nvarying vec4 vNormal;\n#endif\n\n#if NCLIPPLANES > 0\nuniform vec4 vClipplane[NCLIPPLANES];\n#endif\n\n#if NLIGHTS > 0\nuniform mat4 mvMatrix;\n#endif\n\n#ifdef IS_LIT\nuniform vec3 emission;\nuniform float shininess;\n#if NLIGHTS > 0\nuniform vec3 ambient[NLIGHTS];\nuniform vec3 specular[NLIGHTS]; // light*material\nuniform vec3 diffuse[NLIGHTS];\nuniform vec3 lightDir[NLIGHTS];\nuniform bool viewpoint[NLIGHTS];\nuniform bool finite[NLIGHTS];\n#endif\n#endif // IS_LIT\n\n#ifdef IS_TWOSIDED\nuniform bool front;\nvarying float normz;\n#endif\n\n#ifdef FAT_LINES\nvarying vec2 vPoint;\nvarying float vLength;\n#endif\n\n#ifdef USE_ENVMAP\nvarying vec3 vReflection;\n#endif\n\nvoid main(void) {\n  vec4 fragColor;\n#ifdef FAT_LINES\n  vec2 point = vPoint;\n  bool neg = point.y < 0.0;\n  point.y = neg ? (point.y + vLength)/(1.0 - vLength) :\n                 -(point.y - vLength)/(1.0 - vLength);\n#if defined(IS_TRANSPARENT) && defined(IS_LINESTRIP)\n  if (neg && length(point) <= 1.0) discard;\n#endif\n  point.y = min(point.y, 0.0);\n  if (length(point) > 1.0) discard;\n#endif // FAT_LINES\n  \n#ifdef ROUND_POINTS\n  vec2 coord = gl_PointCoord - vec2(0.5);\n  if (length(coord) > 0.5) discard;\n#endif\n  \n#if NCLIPPLANES > 0\n  for (int i = 0; i < NCLIPPLANES; i++)\n    if (dot(vPosition, vClipplane[i]) < 0.0) discard;\n#endif\n    \n#ifdef FIXED_QUADS\n    vec3 n = vec3(0., 0., 1.);\n#elif defined(IS_LIT)\n    vec3 n = normalize(vNormal.xyz);\n#endif\n    \n#ifdef IS_TWOSIDED\n    if ((normz <= 0.) != front) discard;\n#endif\n\n#ifdef IS_LIT\n    vec3 eye = normalize(-vPosition.xyz/vPosition.w);\n    vec3 lightdir;\n    vec4 colDiff;\n    vec3 halfVec;\n    vec4 lighteffect = vec4(emission, 0.);\n    vec3 col;\n    float nDotL;\n#ifdef FIXED_QUADS\n    n = -faceforward(n, n, eye);\n#endif\n    \n#if NLIGHTS > 0\n    // Simulate two-sided lighting\n    if (n.z < 0.0)\n      n = -n;\n    for (int i=0;i<NLIGHTS;i++) {\n      colDiff = vec4(vCol.rgb * diffuse[i], vCol.a);\n      lightdir = lightDir[i];\n      if (!viewpoint[i]) {\n        if (finite[i]) {\n          lightdir = (mvMatrix * vec4(lightdir, 1.)).xyz;\n        } else {\n          lightdir = (mvMatrix * vec4(lightdir, 0.)).xyz;\n        }\n      }\n      if (!finite[i]) {\n        halfVec = normalize(lightdir + eye);\n      } else {\n        lightdir = normalize(lightdir - vPosition.xyz/vPosition.w);\n        halfVec = normalize(lightdir + eye);\n      }\n      col = ambient[i];\n      nDotL = dot(n, lightdir);\n      col = col + max(nDotL, 0.) * colDiff.rgb;\n      col = col + pow(max(dot(halfVec, n), 0.), shininess) * specular[i];\n      lighteffect = lighteffect + vec4(col, colDiff.a);\n    }\n#else\n    lighteffect.a = 1.;\n#endif\n    \n#else // not IS_LIT\n    vec4 colDiff = vCol;\n    vec4 lighteffect = colDiff;\n#endif\n    \n#ifdef IS_TEXT\n    vec4 textureColor = lighteffect*texture2D(uSampler, vTexcoord);\n#endif\n    \n#ifdef HAS_TEXTURE\n\n// These calculations use the definitions from \n// https://docs.gl/gl3/glTexEnv\n\n#ifdef USE_ENVMAP\n    float m = 2.0 * sqrt(dot(vReflection, vReflection) + 2.0*vReflection.z + 1.0);\n    vec4 textureColor = texture2D(uSampler, vReflection.xy / m + vec2(0.5, 0.5));\n#else\n    vec4 textureColor = texture2D(uSampler, vTexcoord);\n#endif\n\n#ifdef TEXTURE_rgb\n\n#if defined(TEXMODE_replace) || defined(TEXMODE_decal)\n    textureColor = vec4(textureColor.rgb, lighteffect.a);\n#endif \n\n#ifdef TEXMODE_modulate\n    textureColor = lighteffect*vec4(textureColor.rgb, 1.);\n#endif\n\n#ifdef TEXMODE_blend\n    textureColor = vec4((1. - textureColor.rgb) * lighteffect.rgb, lighteffect.a);\n#endif\n\n#ifdef TEXMODE_add\n    textureColor = vec4(lighteffect.rgb + textureColor.rgb, lighteffect.a);\n#endif\n\n#endif //TEXTURE_rgb\n        \n#ifdef TEXTURE_rgba\n\n#ifdef TEXMODE_replace\n// already done\n#endif \n\n#ifdef TEXMODE_modulate\n    textureColor = lighteffect*textureColor;\n#endif\n\n#ifdef TEXMODE_decal\n    textureColor = vec4((1. - textureColor.a)*lighteffect.rgb) +\n                     textureColor.a*textureColor.rgb, \n                     lighteffect.a);\n#endif\n\n#ifdef TEXMODE_blend\n    textureColor = vec4((1. - textureColor.rgb) * lighteffect.rgb,\n                    lighteffect.a*textureColor.a);\n#endif\n\n#ifdef TEXMODE_add\n    textureColor = vec4(lighteffect.rgb + textureColor.rgb,\n                    lighteffect.a*textureColor.a);\n#endif\n    \n#endif //TEXTURE_rgba\n    \n#ifdef TEXTURE_alpha\n    float luminance = dot(vec3(1.,1.,1.),textureColor.rgb)/3.;\n\n#if defined(TEXMODE_replace) || defined(TEXMODE_decal)\n    textureColor = vec4(lighteffect.rgb, luminance);\n#endif \n\n#if defined(TEXMODE_modulate) || defined(TEXMODE_blend) || defined(TEXMODE_add)\n    textureColor = vec4(lighteffect.rgb, lighteffect.a*luminance);\n#endif\n \n#endif // TEXTURE_alpha\n    \n// The TEXTURE_luminance values are not from that reference    \n#ifdef TEXTURE_luminance\n    float luminance = dot(vec3(1.,1.,1.),textureColor.rgb)/3.;\n\n#if defined(TEXMODE_replace) || defined(TEXMODE_decal)\n    textureColor = vec4(luminance, luminance, luminance, lighteffect.a);\n#endif \n\n#ifdef TEXMODE_modulate\n    textureColor = vec4(luminance*lighteffect.rgb, lighteffect.a);\n#endif\n\n#ifdef TEXMODE_blend\n    textureColor = vec4((1. - luminance)*lighteffect.rgb,\n                        lighteffect.a);\n#endif\n\n#ifdef TEXMODE_add\n    textureColor = vec4(luminance + lighteffect.rgb, lighteffect.a);\n#endif\n\n#endif // TEXTURE_luminance\n \n    \n#ifdef TEXTURE_luminance_alpha\n    float luminance = dot(vec3(1.,1.,1.),textureColor.rgb)/3.;\n\n#if defined(TEXMODE_replace) || defined(TEXMODE_decal)\n    textureColor = vec4(luminance, luminance, luminance, textureColor.a);\n#endif \n\n#ifdef TEXMODE_modulate\n    textureColor = vec4(luminance*lighteffect.rgb, \n                        textureColor.a*lighteffect.a);\n#endif\n\n#ifdef TEXMODE_blend\n    textureColor = vec4((1. - luminance)*lighteffect.rgb,\n                        textureColor.a*lighteffect.a);\n#endif\n\n#ifdef TEXMODE_add\n    textureColor = vec4(luminance + lighteffect.rgb, \n                        textureColor.a*lighteffect.a);\n\n#endif\n\n#endif // TEXTURE_luminance_alpha\n    \n    fragColor = textureColor;\n\n#elif defined(IS_TEXT)\n    if (textureColor.a < 0.1)\n      discard;\n    else\n      fragColor = textureColor;\n#else\n    fragColor = lighteffect;\n#endif // HAS_TEXTURE\n    \n#ifdef HAS_FOG\n    // uFogParms elements: x = near, y = far, z = fogscale, w = (1-sin(FOV/2))/(1+sin(FOV/2))\n    // In Exp and Exp2: use density = density/far\n    // fogF will be the proportion of fog\n    // Initialize it to the linear value\n    float fogF;\n    if (uFogMode > 0) {\n      fogF = (uFogParms.y - vPosition.z/vPosition.w)/(uFogParms.y - uFogParms.x);\n      if (uFogMode > 1)\n        fogF = mix(uFogParms.w, 1.0, fogF);\n      fogF = fogF*uFogParms.z;\n      if (uFogMode == 2)\n        fogF = 1.0 - exp(-fogF);\n      // Docs are wrong: use (density*c)^2, not density*c^2\n      // https://gitlab.freedesktop.org/mesa/mesa/-/blob/master/src/mesa/swrast/s_fog.c#L58\n      else if (uFogMode == 3)\n        fogF = 1.0 - exp(-fogF*fogF);\n      fogF = clamp(fogF, 0.0, 1.0);\n      gl_FragColor = vec4(mix(fragColor.rgb, uFogColor, fogF), fragColor.a);\n    } else gl_FragColor = fragColor;\n#else\n    gl_FragColor = fragColor;\n#endif // HAS_FOG\n    \n}","players":[],"webGLoptions":{"preserveDrawingBuffer":true},"fastTransparency":true},"evals":[],"jsHooks":[]}
```
