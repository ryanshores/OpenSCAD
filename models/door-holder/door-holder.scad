include <shared.scad>

door_x = 1000;
door_y = 50;
door_z = 400;
door_dims = [door_x, door_y, door_z];

handle_r = 12;
handle_y = 18;
handle_d_from_edge = 70;
//18 24 70

part_width = 5;

stay_straight_length = 150;

latch_length = 20;

module door() {

    handle_translate_x = door_x / 2 - handle_d_from_edge;
    handle_translate_y = -door_y / 2 - handle_y/2;
    handle_translate_z = 0;


    union() {
        cuboid(door_dims);
        translate([handle_translate_x, handle_translate_y, handle_translate_z])
            rotate([90, 0, 0])
                cyl(l=handle_y, r1=5 * handle_r, r2=handle_r);
        translate([handle_translate_x, handle_translate_y, handle_translate_z])
            rotate([90, 0, 0])
                cyl(l=handle_y*4, r=handle_r);
    }
}

module door_connector() {
    rotate([90,0,0])
            difference() {
                cyl(l=part_width, r=handle_r + part_width);
                cyl(l=part_width+ 0.01, r=handle_r);
            }
}

module door_connector_arm() {
    difference() {
        translate([handle_d_from_edge-handle_r*2.5, 0, 0])
            cuboid([handle_d_from_edge, part_width, handle_r*2], chamfer = 1);
        rotate([90,0,0])
            cyl(l=part_width+ 0.01, r=handle_r);
    }
}

module door_arm_stay() {
    union() {
        translate([handle_d_from_edge+part_width/2, stay_straight_length/2, 0])
            cuboid([part_width, stay_straight_length, handle_r*2], chamfer = 1);
        translate([handle_d_from_edge+part_width/2 + latch_length/2, stay_straight_length-latch_length/2,0])
            cuboid([latch_length, latch_length, latch_length], chamfer = 1);
    }
}

module door_holder() {
    union() {
        door_connector();
        door_connector_arm();
        door_arm_stay();
    }
}

translate([-door_x / 2+ handle_d_from_edge,door_y/2+handle_y, 0])
    %door();

door_holder();