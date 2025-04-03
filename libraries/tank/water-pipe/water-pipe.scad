include <tank/shared.scad>
use <tank/water-outlet/water-outlet.scad>

module pipe(outlet_h=outlet_h, tube_d=tube_d) {
    cylinder(h=outlet_h, d=tube_d);
}

module water_pipe(
outlet_h=outlet_h,
tube_d=tube_d,
angle=angle,
scale=scale) {

    union() {
        pipe(outlet_h, tube_d);
        translate([0, 0, outlet_h])
            water_outlet(tube_d, angle, scale);
    }
}

water_pipe();