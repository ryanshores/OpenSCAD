include <tank/shared.scad>
use <shapes/exponential.scad>

angle = 120;
diameter = 5;
radius = 10;
length = 10;
scale = [1, 2];

module cone(outlet_length=outlet_length, scale=scale) {
    linear_extrude(height = outlet_length, scale=scale)
        circle(r = tube_d / 2);
}

module curve(radius=radius, diameter=diameter, angle=angle) {
    rotate_extrude(angle=angle)
        translate([radius, 0, 0])
            circle(r = diameter / 2);
}

module water_outlet(
tube_d=tube_d,
angle=angle,
scale=scale,
outlet_length=outlet_length) {

    rot = angle-90;

    translate([0,tube_d,0])
        rotate([-rot,0,0])
            rotate([0, 270,180])
                union() {
                    curve(radius=tube_d, diameter=tube_d, angle=angle);

                    rotate([90,00,00])
                        translate([tube_d, 0, -0.0001])
                            cone(outlet_length = outlet_length, scale=scale);
                }
}

module water_outlet_v2(
tube_d=tube_d,
curve_scale = 5,
curve_growth = 2.5,
height = 10,
scale=scale,
outlet_length=outlet_length) {
    height_step = 0.05;
    steps = height / height_step;

    exponential_circle(
        radius = tube_d / 2,
        curve_scale = curve_scale,
        curve_growth = curve_growth,
        object_scale = scale,
        steps = steps,
        height_step = height_step);
}

translate([50, 0, 0])
    water_outlet();

water_outlet_v2();
