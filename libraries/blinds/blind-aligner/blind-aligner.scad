include <blinds/shared.scad>

module blind_aligner(blind_h=blind_h, blind_d=blind_d, part_w=part_w, wall_d=wall_d, alignment_h=alignment_h) {
    diff = 0.01;
    diff_w = part_w + diff;
    diff_h = blind_h + diff;
    difference() {
        // part
        cuboid([part_w, 2 * wall_d + blind_d, blind_h + wall_d + alignment_h], fillet = 1);
        
        // blinds diff
        translate([0,0,-alignment_h/2+wall_d/4]) {
            cuboid([diff_w, blind_d, diff_h]);
        }
        
        // alignment rack
        translate([0,0,blind_h-wall_d/2]) {
            cuboid([diff_w, blind_d, alignment_h]);
        }
    }
}

blind_aligner();