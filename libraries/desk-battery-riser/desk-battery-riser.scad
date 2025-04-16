include <ecoflow-delta-3-plus/shared.scad>
use <ecoflow-delta-3-plus/ecoflow-delta-3-plus.scad>

// Dimensions: 16.9” (L) x 2.9” (H) x 3.5” (W)
// 25.4mm = 1 inch
// 16.9 * 25.4 = 429.26
// 2.9 * 25.4 = 73.66
// 3.5 * 25.4 = 88.9
battery_dims = [73.66, 429.26, 88.9];
charger_dims = [170 + 40, 75, 45];
wall_thickness = 5;
gap = 1;
chamfer = 5;

// h to beat 354

module battery_box(battery_dims = battery_dims, wall_thickness = wall_thickness) {
    battery_clearance_dims = [
        battery_dims.x + gap * 3,
        battery_dims.y,
        battery_dims.z + gap * 2
    ];

    box_dims = [
        battery_clearance_dims.x * 2 + wall_thickness * 3,
        ecoflow_feet_translate_y,
        battery_clearance_dims.z + wall_thickness * 2
    ];

    battery_translate_x = box_dims.x / 2 - battery_clearance_dims.x / 2- wall_thickness;
    battery_translate_z = 0;

    difference() {
        rounded_prismoid(
            size1=[box_dims.x,ecoflow_dims.y / 2],
            size2=[box_dims.x,box_dims.y],
            h=box_dims.z,
            r=chamfer,
            center=true);

        translate([-battery_translate_x, 0,battery_translate_z])
            cuboid(battery_clearance_dims, chamfer = chamfer);

        translate([battery_translate_x, 0,battery_translate_z])
            cuboid(battery_clearance_dims, chamfer = chamfer);
    }
}

module battery_box_v2(battery_dims = battery_dims, wall_thickness = wall_thickness) {
    battery_clearance_dims = [
        battery_dims.x + gap * 3,
        battery_dims.y,
        battery_dims.z + gap * 2
    ];

    box_dims = [
        battery_clearance_dims.x * 2 + wall_thickness * 3,
        ecoflow_feet_translate_y * 2,
        battery_clearance_dims.z + wall_thickness * 2
    ];

    battery_translate_x = box_dims.x / 2 - battery_clearance_dims.x / 2- wall_thickness;
    battery_translate_z = 0;

    teardrop_r = 30;
    teardrop_translate_y = teardrop_r + (box_dims.z / 2 - teardrop_r) - 5;
    teardrop_rotate_y = 45;
    teardrop_rotate_z = 90;

    difference() {
        rounded_prismoid(
            size1=[box_dims.x,ecoflow_dims.y / 2],
            size2=[box_dims.x,box_dims.y],
            h=box_dims.z,
            r=chamfer,
            center=true);

        translate([-battery_translate_x, 0,battery_translate_z])
            cuboid(battery_clearance_dims, chamfer = chamfer);

        translate([battery_translate_x, 0,battery_translate_z])
            cuboid(battery_clearance_dims, chamfer = chamfer);

        translate([0,teardrop_translate_y,0])
            rotate([0,-teardrop_rotate_y, teardrop_rotate_z])
                teardrop(r=teardrop_r, h=box_dims.y, ang=teardrop_rotate_y);

        translate([0,-teardrop_translate_y,0])
            rotate([0,teardrop_rotate_y, teardrop_rotate_z])
                teardrop(r=teardrop_r, h=box_dims.y, ang=teardrop_rotate_y);
    }
}

module charger_box(charger_dims = charger_dims, wall_thickness = wall_thickness) {
    box_dims = [
        charger_dims.x + wall_thickness,
        charger_dims.y + wall_thickness + gap,
        charger_dims.z + wall_thickness + gap
    ];
    echo("box_dims: ", box_dims);

    box_transalte = [0, 0, box_dims.z / 2];

    charger_translate_x = wall_thickness;
    charger_translate_y = 0;
    charger_translate_z = (charger_dims.z / 2) + wall_thickness / 2 + gap / 2;

    charger_translate = [charger_translate_x, charger_translate_y, charger_translate_z];

    difference() {
        translate(box_transalte)
            cuboid(box_dims, chamfer = chamfer);

        translate(charger_translate)
            cuboid(charger_dims, chamfer = chamfer);
    }
}

battery_box_v2();

translate([battery_dims.x / 2 + wall_thickness / 2 + gap * 1.5, 0, 0])
%   cuboid(battery_dims, chamfer = chamfer);

translate([0, 0, ecoflow_dims.z /2 + battery_dims.x - 18])
%   ecoflow_delta_3_plus();

translate([0, 0, - battery_dims.z /2 - gap - wall_thickness])
%   cylinder(r=5, 354);