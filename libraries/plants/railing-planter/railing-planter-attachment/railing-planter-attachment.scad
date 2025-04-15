include <plants/railing-planter/shared.scad>
use <plants/railing-planter/railing-fence/railing-fence.scad>
use <plants/railing-planter/railing-planter.scad>

module local_planter(
    fence_diameter=fence_diameter,
    keyhole_outer=keyhole_outer,
    distance_y=distance_y,
    thickness=thickness) {
        translate([0, 0, 3 * fence_diameter])
            planter_rail();
}

module attachment(
    keyhole_outer=keyhole_outer,
    distance_y=distance_y) {
    x = keyhole_outer * 3;
    y = distance_y * 1.5;
    union() {
        translate([0, 0, - fence_diameter])
            cube([x, y, thickness], center = true);
        translate([0, distance_y / 4, 0])
            cube([x,distance_y/2,fence_diameter], center = true);
        translate([0, 4 * y / 12, fence_diameter])
            cube([x, y/2, thickness], center = true);
        translate([0, - distance_y + distance_y / 4, 0])
            cube([x,distance_y/2,fence_diameter], center = true);
        translate([0, - distance_y / 2, fence_diameter])
            cube([x,7 * distance_y / 8,fence_diameter], center = true);
    }
}

%local_planter();

%railing_fence(
    x_units = 1,
    y_units = 3
);

attachment();