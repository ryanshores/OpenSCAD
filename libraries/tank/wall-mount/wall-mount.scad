include <tank/shared.scad>

module wall_mount(
    wall_thickness = back_wall_y,
    part_x= 15,
    part_y = 40,
    part_z = 10,
    part_thickness = 2) {

    color("blue")
    union() {
        cuboid([part_x, part_y, part_thickness]);

        translate([0, wall_thickness/2 + part_thickness / 2, 0])
            downcube([part_x, part_thickness, part_z]);

        translate([0, -wall_thickness/2 - part_thickness / 2, 0])
            downcube([part_x, part_thickness, part_z]);

    }
}

wall_mount();