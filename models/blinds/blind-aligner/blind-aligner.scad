include <blinds/shared.scad>
use <blinds/blinds/blinds.scad>

module blind_aligner(blind_dims=blind_dims, blinds_dims=blinds_dims,part_w=part_w, wall_d=wall_d) {
    difference() {
        union() {
            cube_x = part_w;
            cube_y = 2 * wall_d + blind_dims[1];
            cube_z = blind_dims[2] + wall_d + blinds_dims[2];
            cube_1_dims = [cube_x, cube_y, cube_z];

            cube_x_p = part_w / 2;
            cube_y_p = (blind_dims[1] / 2) + wall_d;
            cube_z_p = (blind_dims[2] / 2) + wall_d;
            cube_1_p_dims = [-cube_x_p, -cube_y_p, -cube_z_p];

            cuboid(cube_1_dims, cube_1_p_dims, fillet = fillet);

            cube_y_2 = blinds_dims[1] + 2 * wall_d;
            cube_z_2 = blinds_dims[2] + wall_d / 2;
            cube_2_dims = [cube_x, cube_y_2, cube_z_2];

            cube_y_2_p = blinds_dims[1] / 2 + wall_d;
            cube_z_2_p = blind_dims[2] - blind_dims[2] / 2 - wall_d / 2;

            cube_2_p_dims = [-cube_x_p, -cube_y_2_p, cube_z_2_p];

            cuboid(cube_2_dims, cube_2_p_dims, fillet = fillet);
        }

        blinds();
    }
}

blind_aligner();