include <shapes.scad>

color = "blue";

module wall(wall_dims = [1, 100, 20]) {
    color(color)
        box(wall_dims);
}

wall();