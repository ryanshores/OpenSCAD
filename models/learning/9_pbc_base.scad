
$fn = 20;

// dimemsions of the pcb board
W = 52.1;
L = 172.7;
T = 1.6;

GAP = 0.2;

X_HOLE_1 = 78.7;
X_HOLE_2 = 80;

D_HOLE_1 = 2;
D_HOLE_2 = 3;

Y_HOLE_1 = 35.6/2;
Y_HOLE_2 = 42.6/2;

H_TREY = 5;
T_WALL = 1.2;

module pbc_board(
    w=W,
    l=L,
    t=T,
    gap_b=H_TREY,
    xh_1=X_HOLE_1,
    xh_2=X_HOLE_2,
    dh_1=D_HOLE_1,
    dh_2=D_HOLE_2,
    yh_1=Y_HOLE_1,
    yh_2=Y_HOLE_2
) {
    color("#0A6F38")
    difference() {
        translate([0, 0, t / 2])
            cube([l,w,t], center=true);

        for(i=[-1,0,1]) {
            translate([i*xh_1, 0, 0])
                cylinder(d=dh_1, h=t+GAP);
        }
        for(i=[-1,1]) {
            for(j=[-1,1]) {
                translate([i*xh_2, j*yh_2, -GAP])
                    cylinder(d=dh_2, h=t+GAP*2);
            }
        }
    }
}


module pcb_base(
    w=W,
    l=L,
    t=T,
    h_trey=H_TREY,
    t_wall=T_WALL
) {
    base_x = l + 2 * t_wall + 2 * GAP;
    base_y = w + 2 * t_wall + 2 * GAP;
    translate_z = - t_wall / 2 - h_trey;

    fb_z = h_trey + t_wall + t;
    fb_translate_z = (t_wall + t)/2;

    color("#4a4646")
    union() {
        translate([0, 0, translate_z])
            cube([
                base_x,
                base_y,
                t_wall
            ], center = true);
        for(i=[-1,1]) {
            // front and back bookends
            scale([1,i,1])
            translate([0, base_y/2 - t_wall/2, fb_translate_z])
                cube([
                    base_x,
                    t_wall,
                    fb_z
                ], center = true);
        }
    }
}

pbc_board();
pcb_base();





















