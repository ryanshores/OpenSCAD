include <global-resolution.scad>

module earring_aligner() {
    stud_d = 2;
    aligner_d = 5;
    aligner_h = 2.5;
    
    difference() {
        cylinder(aligner_h, aligner_d, stud_d);
        cylinder(aligner_h, stud_d, stud_d);
    }
}

earring_aligner();