include <tank/shared.scad>
use <tank/wall/wall.scad>

module walls(distance=distance, wall_x = wall_x) {
    translate([-distance/2, 0, 0])
    wall();

    translate([distance/2, 0, 0])
    wall();
}

walls();