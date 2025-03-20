use <../wall/wall.scad>

distance_inner = 100;
wall_x = 1;
wall_dims = [wall_x, 100, 20];

module walls(distance_inner=distance_inner, wall_dims=wall_dims) {
    wall();

    wall_x = wall_dims[0];
    translate([distance_inner+wall_x, 0, 0])
    wall();
}

walls();