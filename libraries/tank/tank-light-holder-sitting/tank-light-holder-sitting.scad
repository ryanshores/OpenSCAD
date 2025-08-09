include <tank/shared.scad>
use <tank/walls/walls.scad>
use <tank/light/light.scad>
use <shapes/exponential.scad>


color = "green";

module light_walls(
    height_raise=height_raise,
    wall_dims=wall_dims,
    walls_dims=walls_dims,
    light_dims=light_dims) {
    light_translate_z = wall_dims[2] + height_raise;

    translate([0, 0,light_translate_z])
        light();

    walls();
}

module tank_light_holder_sitting(
    height_raise=height_raise,
    wall_dims=wall_dims,
    walls_dims=walls_dims,
    light_dims=light_dims,
    part_thickness=part_thickness) {

    attachment_padding = part_thickness * 2;

    attachment_x = wall_dims[0] + attachment_padding;
    attachment_y = light_dims[1] + attachment_padding;
    attachment_z = wall_dims[2] + height_raise + part_thickness;

    attachment_translate_x = walls_dims[0] / 2;
    attachment_translate_y = 0;
    attachment_translate_z = wall_dims[2] + (part_thickness/2);

    light_attachment_x = walls_dims[0] + attachment_padding + wall_dims[0];
    light_attachment_y = light_dims[1] + attachment_padding;
    light_attachment_z = light_dims[2] + part_thickness;

    light_attachment_translate_x = 0;
    light_attachment_translate_y = 0;
    light_attachment_translate_z = wall_dims[2] + height_raise + part_thickness;
//    29/13

    difference(){
        union() {
            // left wall attachment
            translate([-attachment_translate_x, attachment_translate_y, attachment_translate_z])
                cuboid([attachment_x, attachment_y, attachment_z]);

            // right wall attachment
            translate([attachment_translate_x, attachment_translate_y, attachment_translate_z])
                difference() {
                    cuboid([attachment_x, attachment_y, attachment_z]);
                    translate([part_thickness, 0, 0])
                        cuboid([light_cord_diameter, light_cord_diameter, attachment_z + part_thickness]);
                }

            // light attachment
            translate([light_attachment_translate_x, light_attachment_translate_y, light_attachment_translate_z])
                cuboid([light_attachment_x, light_attachment_y, light_attachment_z]);
        }

        light_walls(height_raise, wall_dims, walls_dims, light_dims);

    }

}



!tank_light_holder_sitting();
light_walls(height_raise, wall_dims, walls_dims, light_dims);




