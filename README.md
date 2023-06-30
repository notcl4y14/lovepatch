# lovepatch

This a love2D library that generates 9-patches. https://en.wikipedia.org/wiki/9-slice_scaling. Thanks to darkfrei for helping with the code (or just even writing all by himself).
The example code is in the `main.lua` file.

# Library functions

`patch.load(filename, edgeWidth, edgeHeight)` - Generates a new 9-patch object.

`path.draw(patch, x, y, width, height)` - Draws a 9-patch object at the given position.
