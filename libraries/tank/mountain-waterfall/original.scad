include <tank/shared.scad>


module waterfall(distance_inner=distance_inner) {
    // Create a waterfall using the imported STL file

    translate_x = - distance_inner / 2 - 7.5;
    translate_y = wall_y - wall_y / 4;
    translate_z = 0;

    rotate_x = 00;
    rotate_y = 00;
    rotate_z = 270;

    translate([translate_x, translate_y, translate_z]) {
        rotate([rotate_x, rotate_y, rotate_z]) {
            import("original.stl", convexity = 3);
        }
    }
}

module waterfall_centered() {
    // Create a waterfall using the imported STL file
    translate_z = 98 / 2;
    translate([0,0, translate_z])
        rotate([0, 0, 270])
            import("original.stl", convexity = 3, center = true);
}

waterfall_centered();