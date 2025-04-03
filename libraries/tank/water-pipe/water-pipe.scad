include <tank/shared.scad>
use <tank/water-outlet/water-outlet.scad>

module pipe(
outlet_h=outlet_h,
tube_d1=tube_d,
tube_d2=tube_d) {
//    cylinder(h=outlet_h, d=tube_d);
    cyl(l=outlet_h, d1=tube_d1, d2=tube_d2, center=false);
}

module water_pipe(
outlet_h=outlet_h,
tube_d1=tube_d,
tube_d2=tube_d_outlet,
angle=angle,
scale=scale,
outlet_l=outlet_l) {
    union() {
        pipe(outlet_h, tube_d1, tube_d2);
        translate([0, 0, outlet_h])
            water_outlet(tube_d_outlet, angle, scale);
    }
}

water_pipe();