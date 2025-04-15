include <plants/railing-planter/shared.scad>
use <shapes/keyhole.scad>

module keyholes(keyhole_inner = keyhole_inner,
keyhole_outer = keyhole_outer,
distance_y = distance_y,
thickness = thickness) {
    translate([0,-keyhole_outer / 2,0]) {
        rotate([0,0,180]){
            union() {
                translate([0, -distance_y / 2])
                    keyhole(
                        head_diameter = keyhole_outer,
                        shaft_diameter = keyhole_inner,
                        slot_length = 8,
                        thickness=thickness,
                        rounded = false);

                translate([0, distance_y / 2])
                    keyhole(
                        head_diameter = keyhole_outer,
                        shaft_diameter = keyhole_inner,
                        slot_length = 8,
                        thickness = thickness,
                        rounded = false);
            }
        }
    }
}


module planter_rail(
keyhole_inner = keyhole_inner,
keyhole_outer = keyhole_outer,
distance_y = distance_y,
thickness = thickness
) {
    difference() {
        cube([keyhole_outer * 2, distance_y * 1.5, thickness], center = true);

        keyholes(
            keyhole_inner = keyhole_inner,
            keyhole_outer = keyhole_outer,
            distance_y = distance_y,
            thickness = thickness);
    }
}

module railing_planter(
keyhole_inner = keyhole_inner,
keyhole_outer = keyhole_outer,
distance_x = distance_x,
distance_y = distance_y) {

    union() {
        translate([-distance_x / 2, 0, 0])
            planter_rail(keyhole_inner, keyhole_outer, distance_y);
        translate([distance_x / 2, 0, 0])
            planter_rail(keyhole_inner, keyhole_outer, distance_y);
    }
}
planter_rail(5, 10, 50, 5);
railing_planter(keyhole_inner, keyhole_outer, distance_x, distance_y);