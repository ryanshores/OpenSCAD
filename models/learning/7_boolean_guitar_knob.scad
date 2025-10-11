$fn=100;

module draft() {
    translate([30, 0, 0])
    union() {
        sphere(r=10);
        cube(20);
        translate([0, 20, 0])
            cylinder(r=10, h=10);
    }
}

module draft2() {
    difference() {
        cube(50, center=true);

        cylinder(h=100, r=20, center=true);

        rotate([90, 0, 0])
            cylinder(h=100, r=20, center=true);

        rotate([0, 90, 0])
            cylinder(h=100, r=20, center=true);
    }
}

module draft3() {
    intersection() {
        sphere(r=20);
        cube(30, center=true);
        cube([100, 100, 10], center=true);
    }
}

D_BASE = 26;
D_MID = 19;
D_TOP = 17;

H_BASE = 1.5;
H_MID = 1.5;
H_TOP = 7;

D_HOLE = 6;

GAP = 0.2;

module knob(
    d_base = D_BASE, d_mid = D_MID, d_top = D_TOP,
    h_base = H_BASE, h_mid = H_MID, h_top = H_TOP,
    d_hole = D_HOLE) {

    difference(){
        union() {
            cylinder(h=h_base, d=d_base);
            translate([0, 0, h_base]) cylinder(h=h_mid, r1=d_base/2, r2=d_mid/2);
            translate([0, 0, h_base + h_mid]) cylinder(h=h_top, r1=d_mid/2, r2=d_top/2);

        }
        translate([0, 0, -GAP]) cylinder(h=h_top + GAP, d=d_hole);
    }
}

module knob2(d_base = D_BASE, d_mid = D_MID, d_top = D_TOP,
    h_base = H_BASE, h_mid = H_MID, h_top = H_TOP,
    d_hole = D_HOLE) {

    difference(){
        union() {
            cylinder(h=h_base, d=d_base);

            translate([0, 0, h_base]) cylinder(h=h_mid, r1=d_base/2, r2=d_mid/2);

            translate([0, 0, h_base + h_mid]) // cylinder(h=h_top, r1=d_mid/2, r2=d_top/2);
            linear_extrude(height=h_top, scale=d_top/d_mid)
                polygon(points=[for(i=[0:0.5:360]) (d_mid/2 + 0.2 * cos(50 * i) - 0.2) * [cos(i), sin(i)]]);

        }
        translate([0, 0, -GAP]) cylinder(h=h_top + GAP, d=d_hole);
    }
}

knob2();