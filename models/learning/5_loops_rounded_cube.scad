$fn = 20;

module draft() {
    translate([100, 0, 0])
    for(i = [0:5:360]) {
        rotate([0, 0, i])
        translate([30, 0, 0])
            sphere(r = 10);

    }

    for(i = [0,5,10,15,20]) {
        rotate([0, 0, i])
            translate([30, 0, 0])
                sphere(r = 10);
    }
}

module rounded_cube(l=10, r=2) {
    hull () {
        for (ix=[-1, 1]) {
            for (iy=[-1, 1]) {
                for (iz=[-1, 1]) {
                    translate([ix * (l/2 - r), iy * (l/2 - r), iz * (l/2 - r)])
                        sphere(r=2);

                }
            }
        }
    }
}

//translate([100, 0, 0])
//    draft();

rounded_cube();