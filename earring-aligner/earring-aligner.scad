include <global-resolution.scad>

module earring_aligner() {
    difference() {
        cylinder(10, 15, 1);
        cylinder(10, 2, 2);
    }
}

earring_aligner();