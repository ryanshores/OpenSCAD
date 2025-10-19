include <blinds/shared.scad>

color = "white";

module blinds(blind_dims=blind_dims, bllinds_dims=blinds_dims, wall_d=wall_d) {
    color(color)

    cuboid(blind_dims, fillet = fillet);

    cube_start_x = - blinds_dims[0] / 2;
    cube_start_y = - blinds_dims[1] / 2;
    cube_start_z = blind_dims[2] / 2 + wall_d / 2;
    cube_start_dims = [cube_start_x, cube_start_y, cube_start_z];

    color(color)
            cuboid(blinds_dims, cube_start_dims, fillet = fillet);
}

blinds();