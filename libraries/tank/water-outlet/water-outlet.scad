include <tank/shared.scad>

module water_outlet(tube_d=tube_d, angle=angle, scale=scale) {

    rot = angle-90;

    translate([0,tube_d,0])
        rotate([-rot,0,0])
            rotate([0, 270,180])
                union() {
                    rotate_extrude(angle=angle)
                        translate([tube_d, 0, 0])
                            circle(r = tube_d / 2);

                    rotate([90,00,00])
                    translate([tube_d, 0, 0])
                        linear_extrude(height = tube_d, scale=scale)
                                    circle(r = tube_d / 2);
        }
}

water_outlet();
