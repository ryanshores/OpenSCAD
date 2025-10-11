$fn=100;

GAP = 0.2;

W = 22.2-1;
T = 8.3-1;
L = W*2;
SCREW_D = 6;
HEX_W = 11.25;
HEX_T = 4.2;

R_CORNER = 2;

module draft(w=W, t=T, l=L, screw_d=SCREW_D, hex_w=HEX_W, hex_t=HEX_T) {
    difference() {
        cube([w, l, t], center=true);
        cylinder(d=screw_d, h=t+2, center=true);
        translate([0, 0, -T/2-GAP])
        cylinder(d=hex_w, h=hex_t+GAP, $fn=6);
    }

}

module channel_bolt(w=W, t=T, l=L, screw_d=SCREW_D, hex_w=HEX_W, hex_t=HEX_T, r_corner=R_CORNER) {
    difference() {
        hull() {
            for(i=[-1,1]) {
                for(j=[-1,1]) {
                    translate([i * (w/2 - r_corner), j * (l/2 - r_corner), 0])
                        cylinder(r=r_corner, h=T, center=true);
                }
            }
        }
        cylinder(d=screw_d, h=t+2, center=true);
        translate([0, 0, -T/2-GAP])
            cylinder(d=hex_w, h=hex_t+GAP, $fn=6);
    }

}


//translate([0, 0, -T/2-GAP])
//        % cylinder(d=HEX_W, h=HEX_T+GAP, $fn=6);

channel_bolt();
