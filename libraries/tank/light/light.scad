include <tank/shared.scad>

module light(light_dims=light_dims, light_cord_diameter=light_cord_diameter) {
    color("red")
//    box(light_dims);
    union() {
        cuboid([light_dims[0], light_dims[1], light_dims[2]]);
        translate([light_dims[0], 0, 0])
            rotate([0, 90, 0])
                cylinder(r = light_cord_diameter / 2, h = light_dims[0], center = true);
    }
}

light();