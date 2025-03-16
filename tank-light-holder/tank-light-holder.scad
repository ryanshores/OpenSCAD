include <shapes.scad>

module box(dims) {
    cuboid([dims[0], dims[1], dims[2]], [0,0,0]);
}

module tank(light_dims=light_dims, tank_dims=tank_dims) {
    tank_offset_x = light_dims[0]/2 - tank_dims[0]/2;
    tank_offset_y = light_dims[1]/2 -  tank_dims[1]/2;

    color("green")
        translate([tank_offset_x, tank_offset_y, light_dims[2]])
            box(tank_dims);
}

module tank2(light_dims=light_dims, tank_dims=tank_dims, wall_thickness=wall_thickness) {
    tank_offset_x = light_dims[0]/2 - tank_dims[0]/2;
    tank_offset_y = light_dims[1]/2 -  tank_dims[1]/2;

    color("green")
    translate([tank_offset_x, tank_offset_y, light_dims[2]])
   prismoid(
        size1=[tank_dims[0]+wall_thickness, tank_dims[1]],
        size2=[tank_dims[0],tank_dims[1]],
        h=tank_dims[2],
        align=V_UP+V_BACK+V_RIGHT);
}

module light(light_dims=light_dims, tank_dims=tank_dims) {
    color("red")
        box(light_dims);
}

module tank_light(light_dims=light_dims, tank_dims=tank_dims) {
    tank2(light_dims, tank_dims);
    light(light_dims, tank_dims);
}

module tank_light_holder(light_dims=light_dims, tank_dims=tank_dims, wall_thickness=wall_thickness) {
    holder_y = light_dims[1] + 2 * wall_thickness;
    holder_z = light_dims[2] + tank_dims[2] + 2 * wall_thickness;
    dims = [light_dims[0],holder_y, holder_z];
    cut_x = ( light_dims[0] - tank_dims[0] )/2 - wall_thickness;

    difference() {
        // holder
        translate([0,-wall_thickness,-wall_thickness]) color("blue") box(dims);

        // tank light
        tank_light(light_dims, tank_dims);
        translate([cut_x, 0, -tank_z/2]) tank(light_dims, tank_dims);
        translate([-cut_x, 0, -tank_z/2]) tank(light_dims, tank_dims);

        translate([0, 0, -tank_z]) tank(light_dims, tank_dims);
        translate([cut_x, 0, -tank_z]) tank(light_dims, tank_dims);
        translate([-cut_x, 0, -tank_z]) tank(light_dims, tank_dims);

        translate([0, 0, -tank_z*2]) tank(light_dims, tank_dims);
        translate([cut_x, 0, -tank_z*2]) tank(light_dims, tank_dims);
        translate([-cut_x, 0, -tank_z*2]) tank(light_dims, tank_dims);

    }
}

light_x = 205;
light_y = 30;
light_z = 15.5;
light_dims = [light_x, light_y, light_z];

tank_x = 153;
tank_y= 88;
tank_z = 10.5;
tank_dims = [tank_x, tank_y, tank_z];

wall_thickness = 2;

tank_light_holder(light_dims, tank_dims, wall_thickness);
