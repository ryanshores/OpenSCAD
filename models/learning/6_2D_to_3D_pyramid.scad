
HEIGHT = 10;
LENGTH = 10;
Scale = 1;
NAME = "Ryan Shores";

module draft(h = HEIGHT, l = LENGTH) {
    linear_extrude(height = h, scale=0)
        square(l, center = true);
}

module draft2(h = HEIGHT, l = LENGTH, s = Scale) {
    linear_extrude(height = h, scale=s)
        polygon([[0,10], [10,10], [0,0], [5, -5]]);
}

module draft3(name = NAME, height = HEIGHT) {
    linear_extrude(height = height)
        // halign left, right, center
        // valign top, bottom, center, baseline
        text(name, size = 20, halign="center", valign="center");

    cube([180, 30, 5], center=true);
}

module draft4(name = NAME, height = HEIGHT) {
    linear_extrude(height = height)
        // halign left, right, center
        // valign top, bottom, center, baseline
        text(name, size = 20, halign="center", valign="center");

    translate([0, 0, -5/2])
        cube([180, 30, 5], center=true);
}

draft4();