include <tank/shared.scad>
use <tank/walls/walls.scad>
use <tank/mountain-waterfall/original.scad>
use <tank/water-pipe/water-pipe.scad>
use <tank/water-outlet/water-outlet.scad>

//Mount Eros’ Embrace
//Zephyr’s Kiss Ridge

module pipe_positioned(hole_translate_dims = [0,0,0], tube_d = tube_d, tube_d_outlet = tube_d_outlet, outlet_height = outlet_height) {
    hole_z = outlet_height - hole_translate_dims[2];

    translate(hole_translate_dims) {
        pipe(hole_z, tube_d, tube_d_outlet);
    }
}

module full_outlet_positioned(hole_translate_dims = [0,0,0], tube_d = tube_d, tube_d_outlet = tube_d_outlet, outlet_height = outlet_height, outlet_length = outlet_length, outlet_rotate = outlet_rotate, angle = angle) {
    hole_z = outlet_height - hole_translate_dims[2];

    translate(hole_translate_dims) {
        rotate([0,0,outlet_rotate])
            water_pipe(hole_z, tube_d, tube_d_outlet, angle, scale, outlet_length);
    }
}

// Nyx and Hemera’s Divide
module nyx_and_hemeras_divide(tube_d=tube_d, tube_d_outlet=tube_d_outlet) {

    hole_translate_x = -29.3;
    hole_translate_y = 29.5;
    hole_translate_z =27.8;
    hole_translate_dims = [hole_translate_x, hole_translate_y, hole_translate_z];

    left_outlet_length = 15;
    left_outlet_translate_x = -36;
    left_outlet_translate_y = 29.4;
    left_outlet_translate_z = 80;
    left_outlet_translate = [left_outlet_translate_x, left_outlet_translate_y, left_outlet_translate_z];
    left_outlet_rotate_z = 100;
    left_outlet_angle_y = -140;
    left_outlef_angle_z = 10;
    left_outlet_rotate = [0,left_outlet_angle_y,left_outlef_angle_z];

    right_outlet_height = 70;
    right_outlet_length = 17;
    right_outlet_rotate = -85;
    right_outleft_angle = 130;

    // left outlet
    translate(left_outlet_translate)
        rotate(left_outlet_rotate)
            linear_extrude(height = left_outlet_length, scale=scale)
                circle(r = tube_d_outlet / 2);

    // right outlet
    full_outlet_positioned(
        hole_translate_dims=hole_translate_dims,
        tube_d = tube_d,
        tube_d_outlet = tube_d_outlet,
        outlet_height=right_outlet_height,
        outlet_length=right_outlet_length,
        outlet_rotate=right_outlet_rotate,
        angle=right_outleft_angle);
}

//	Peak of Apollo’s Whisper
module peak_of_apollos_whisper(tube_d=tube_d, tube_d_outlet=tube_d_outlet) {

    hole_translate_x = -82;
    hole_translate_y = 35;
    hole_translate_z =27.8;
    hole_translate_dims = [hole_translate_x, hole_translate_y, hole_translate_z];

    outlet_height = 83;
    outlet_length = 13;
    outlet_rotate = 90;
    angle = 128;

    full_outlet_positioned(hole_translate_dims=hole_translate_dims, tube_d = tube_d, tube_d_outlet = tube_d_outlet, outlet_height=outlet_height, outlet_length=outlet_length, outlet_rotate=outlet_rotate, angle=angle);
}

//	Rainbow Summit Falls
module rainbow_summit_falls(tube_d=tube_d, tube_d_outlet=tube_d_outlet) {

    hole_translate_x = 95.8;
    hole_translate_y = 36;
    hole_translate_z =37.3;
    hole_translate_dims = [hole_translate_x, hole_translate_y, hole_translate_z];
    outlet_height = 60;

    pipe_positioned(hole_translate_dims=hole_translate_dims, tube_d = tube_d, tube_d_outlet = tube_d_outlet, outlet_height=outlet_height);

    // left outlet
    outlet_translate_x = 91.5;
    outlet_translate_y = 36;
    outlet_translate_z = 66;
    outlet_translate = [outlet_translate_x,outlet_translate_y, outlet_translate_z];
    outlet_length = 7;
    outlet_rotate_y = -110;
    outlet_rotate_z = 5;
    outlet_rotation = [0,outlet_rotate_y,outlet_rotate_z];

    translate(outlet_translate)
        rotate(outlet_rotation)
            linear_extrude(height = outlet_length, scale=scale)
                circle(r = tube_d_outlet / 2);
}

module tank_mountain_waterfall(tube_d=tube_d) {
    // Cut larger holes in the mountain for tube diameter

    difference() {
        waterfall_centered();
        peak_of_apollos_whisper();
        nyx_and_hemeras_divide();
        rainbow_summit_falls();
    }
}

walls();

//peak_of_apollos_whisper();
//nyx_and_hemeras_divide();
//rainbow_summit_falls();

tank_mountain_waterfall();

