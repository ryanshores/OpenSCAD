include <tank/shared.scad>

color = "blue";

module wall(wall_dims = wall_dims) {
    color(color)
        cuboid(wall_dims);
}

wall();