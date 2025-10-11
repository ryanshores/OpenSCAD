// transforms
// translate, rotate, scale
// make an x with rounded ends
// use hull to make a cube with rounded edges

$fn=60;

module draft() {
    translate([20, 0, 0])
        sphere(r=10);

    translate([-20, 0, 0])
    rotate([0, 45, 10])
        cylinder(h=15, r=5, $fn = 6);

    scale([10, 2, 1])
    cylinder(h=10, r=5, 3);
}

module part() {
    // order matters, done in reverse order
    // each next function treats all below as an object

    color("blue")
    scale([2, 1, 1])// then scale along x
    rotate([0, 0, -90]) // then rotate about z
    translate([20, 0, 0]) // first translate along x
        cylinder(h=15, r=10);

    color("green")
    translate([20, 0, 0]) // then translate along x axis
    rotate([0, 0, 90]) // then rotate along z axis
    scale([2, 1, 1]) // first scale to widen
        cylinder(h=15, r=10);

    // can be doubled up
    color("red")
    rotate([0, 30, 0])
    scale([2, 1, 1])// then scale along x
    rotate([0, 0, -90]) // then rotate about z
    translate([20, 0, 0]) // first translate along x
        cylinder(h=15, r=10);
}

L = 100;
R = 5;

module final() {
    angle = 45;
    rotate([0, angle, 0])
        cylinder(h = L, r = R, center = true);

    rotate([0, -angle, 0])
        cylinder(h = L, r = R, center = true);

    // bad example, translated too far out
    translate([L/2, 0, L/2])
        sphere(r=R);

    // better example, use trig to get correct x and y
    color("grey")
    translate([cos(angle)*L/2, 0, sin(angle)*L/2])
        sphere(r=R);

    color("#ffc0ed")
    rotate([0, angle, 0])
    translate([L/2, 0, 0])
        sphere(r=R);

    color("#99ff00")
    rotate([0, 90 + angle, 0])
    translate([L/2, 0, 0])
        sphere(r=R);

    color("#c0edff")
    rotate([0, 180 + angle, 0])
    translate([L/2, 0, 0])
        sphere(r=R);
}

module rounded_cube(L=5, R=5) {
    hull() {
        // bottom corners
        translate([-L/2, -L/2, -L/2])
            sphere(r=R);

        translate([L/2, -L/2, -L/2])
            sphere(r=R);

        translate([-L/2, L/2, -L/2])
            sphere(r=R);

        translate([L/2, L/2, -L/2])
            sphere(r=R);

        // top corners (+z axis)
        translate([-L/2, -L/2, L/2])
            sphere(r=R);

        translate([L/2, -L/2, L/2])
            sphere(r=R);

        translate([-L/2, L/2, L/2])
            sphere(r=R);

        translate([L/2, L/2, L/2])
            sphere(r=R);
    }
}

module final_with_hole() {
    hull() {
        rounded_cube();

        // add cylinder
        cylinder(r=R, h=2*L);
    }
}

translate([-150, 0, 0])
    %draft();

translate([0, 150, 0])
    part();

translate([150, 0, 0])
    final();

translate([250, 0, 0])
rotate([0, 45, 0])
    rounded_cube(L=15, R=1);

final_with_hole();
