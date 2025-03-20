include <shapes.scad>

light_x = 205;
light_y = 30;
light_z = 15.5;
light_dims = [light_x, light_y, light_z];


module light(light_dims=light_dims) {
    color("red")
    translate([-translate_x, 0, 0])
    box(light_dims);
}

light(light_dims);