include <shapes.scad>

stud_d = 2;
aligner_d = 7;
aligner_h = 2.5;

module earring_aligner() {
    
    difference() {
        cylinder(aligner_h, aligner_d, stud_d);
        cylinder(h = aligner_h, d = aligner_d);
    }
}

module earring_aligner_v2() {
    
    difference() {
        rounded_prismoid(size1=[aligner_d  ,aligner_d], size2=[0,0], h=aligner_h, r=0.2);
        cylinder(h = aligner_h, d = stud_d);
    }
}

earring_aligner_v2();