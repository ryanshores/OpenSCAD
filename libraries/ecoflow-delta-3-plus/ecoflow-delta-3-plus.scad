include <ecoflow-delta-3-plus/shared.scad>

dc_dims = [57, 20, 65];

dc_z = 45;
dc_translate = [
    0,
    ecoflow_dims.y / 2,
    dc_z - ecoflow_dims.z / 2
];

echo ("dc_translate: ", dc_translate);

module ecoflow_delta_3_plus() {
    union() {
        cuboid(ecoflow_dims, fillet = 5);
        translate(dc_translate)
            cuboid(dc_dims, fillet = 5);
    }
}

ecoflow_delta_3_plus();