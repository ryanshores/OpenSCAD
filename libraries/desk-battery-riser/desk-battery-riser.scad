include <ecoflow-delta-3-plus/shared.scad>
use <ecoflow-delta-3-plus/ecoflow-delta-3-plus.scad>

battery_dims = [75, 430, 90];
charger_dims = [170 + 40, 75, 45];
wall_thickness = 15;
gap = 5;
chamfer = 5;

module battery_box(battery_dims = battery_dims, wall_thickness = wall_thickness) {
    battery_clearance_dims = [
        battery_dims.x + gap * 2,
        battery_dims.y,
        battery_dims.z + gap * 2
    ];

    box_dims = [
        battery_clearance_dims.x * 2 + wall_thickness * 3,
        ecoflow_dims.y,
        battery_clearance_dims.z + wall_thickness * 2
    ];

    battery_translate_x = box_dims.x / 2 - battery_clearance_dims.x / 2- wall_thickness;

    battery_left_translate = [-battery_translate_x, 0,0];
    battery_right_translate = [battery_translate_x, 0,0];

    difference() {
        cuboid(box_dims, chamfer = chamfer);

        translate(battery_left_translate)
            cuboid(battery_clearance_dims, chamfer = chamfer);

        translate(battery_right_translate)
            cuboid(battery_clearance_dims, chamfer = chamfer);
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

//desk_battery_riser();
battery_box();
//charger_box();
translate([0, 0, ecoflow_dims.z /2 + battery_dims.x])
    %ecoflow_delta_3_plus();