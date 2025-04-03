include <tank/shared.scad>
use <tank/water-outlet/water-outlet.scad>

module pipe(
outlet_height=outlet_height,
tube_d1=tube_d,
tube_d2=tube_d) {
    cyl(l=outlet_height, d1=tube_d1, d2=tube_d2, center=false);
}

module water_pipe(
outlet_height=outlet_height,
tube_d=tube_d,
tube_d_outlet=tube_d_outlet,
angle=angle,
scale=scale,
outlet_length=outlet_length) {
    union() {
        pipe(outlet_height, tube_d, tube_d_outlet);
        translate([0, 0, outlet_height])
            water_outlet(tube_d_outlet, angle, scale, outlet_length);
    }
}

water_pipe();