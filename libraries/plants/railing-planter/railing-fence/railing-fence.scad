include <plants/railing-planter/shared.scad>

x_units = 4;
y_units = 4;

module railing_fence(
    x_units = x_units,
    y_units = y_units,
    fence_height = fence_height,
    fence_diameter = fence_diameter) {
    rotate([90, 0, 0]) {
        union() {
            translate([- x_units / 2 * fence_height, 0, 0]) {
                for (i = [0 : x_units]) {
                   translate([i * fence_height, 0, 0])
                        cylinder(r=fence_diameter / 2, h=fence_height * y_units, center=true);
                }
            }
            translate([0, 0, y_units / 2 * fence_height]) {
                rotate([0, 90, 0]) {
                    for (j = [0 : y_units]) {
                        translate([j * fence_height, 0, 0])
                            cylinder(r = fence_diameter / 2, h = fence_height * x_units, center = true);
                    }
                }
            }
        }
    }
}

railing_fence();