include <ecoflow-delta-3-plus/shared.scad>

// Approx. x 202 z 283.6 mm
// x 500 × z 714 pixels
dc_z_bottom = 113/714 * ecoflow_stated_dims.z; // 53.5 mm
dc_translate = [0, ecoflow_dims.y / 2, dc_z - ecoflow_dims.z / 2 + ecoflow_feet.z];

// 140 166
dc_x = 140/500 * ecoflow_stated_dims.x; // 56.8 mm
dc_z = 166/714 * ecoflow_stated_dims.z; // 65.1 mm
dc_dims = [dc_x, 10, dc_z]; // y dim is for representation only

feet_translate = [ecoflow_dims.x / 2 - ecoflow_feet.x, 0, - ecoflow_feet.z / 2 - ecoflow_dims.z / 2];

module ecoflow_delta_3_plus() {
    union() {
        cuboid(ecoflow_dims, chamfer = 15);

        // dc port
        translate(dc_translate)
            cuboid(dc_dims, fillet = 5);

        // feet
        translate(feet_translate) // right
            cuboid(ecoflow_feet, chamfer = 1);

        translate([-feet_translate.x, feet_translate.y, feet_translate.z]) // left
            cuboid(ecoflow_feet, chamfer = 1);
    }
}

ecoflow_delta_3_plus();