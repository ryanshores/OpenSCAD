include <shared.scad>

// global
part_thickness = 3;

// tank
//// wall
wall_x = 5;
wall_y = 190;
wall_z = 15;
wall_dims = [wall_x, 190, 15];

//// walls
distance_inner = 236;
distance_outer = 247;
distance = (distance_inner + distance_outer) / 2;
walls_dims = [distance, wall_y, wall_z];

// light
light_x = 205;
light_y = 30;
light_z = 15.5;
light_dims = [light_x, light_y, light_z];
light_cord_diameter=5;

// tank-light-holder-sitting
height_raise=30;