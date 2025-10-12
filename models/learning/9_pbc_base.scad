/* [Hidden] */
$fn = 20;
GAP = 0.2;

/* [PCB Board] */
// the width dimension of the pcb board
L = 172.7;
// the depth dimension of the pcb board
W = 52.1;
//  the height/thickness of the pcb board
T = 1.6;

/* [PCB Board Holes] */
X_HOLE_1 = 78.7;
X_HOLE_2 = 80;

D_HOLE_1 = 2;
D_HOLE_2 = 3;

Y_HOLE_1 = 35.6/2;
Y_HOLE_2 = 42.6/2;

/* [Trey Dimensions] */
// the amount of space between the bottom of the board and the trey
H_TREY = 5; // [1:1:10]
// the thickness of the part walls
T_WALL = 1.2; // [1:0.2:4]

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
            translate([i*xh_1, 0, -GAP])
                cylinder(d=dh_1, h=t+GAP*2);
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

    color("#4a4646")
    union() {
        // base plate
        translate_z = - t_wall / 2 - h_trey;
        translate([0, 0, translate_z])
            cube([
                base_x,
                base_y,
                t_wall
            ], center = true);
        
        for(i=[-1,1]) {
            // front and back bookends
            fb_z = h_trey + t;
            fb_translate_z = (fb_z)/2 - h_trey;
            scale([1,i,1])
            translate([0, base_y/2 - t_wall/2, fb_translate_z])
                cube([
                    base_x,
                    t_wall,
                    fb_z
                ], center = true);
            
            // inner ledge
            ledge_z = h_trey - GAP;
            ledge_translate_z = (ledge_z)/2 - h_trey;
            scale([1,i,1])
            translate([0, w/2 - t_wall/4, ledge_translate_z])
                cube([
                    base_x,
                    t_wall,
                    ledge_z
                ], center = true);
                
            // left right bookends
            lr_z = fb_z;
            lr_translate_z = fb_translate_z;
            scale([i,1,1])
            translate([base_x/2 - t_wall/2, 0, lr_translate_z])
            cube([t_wall,base_y,lr_z], center = true);
            
            
        }
    }
}

module base_plate(
    dims,
    h_trey
) {
    translate_z = dims.z / 2 - h_trey;
    translate([0, 0, translate_z])
        cube(dims, center = true);
}

module base_screwhole(dims, ) {

}

module pcb_base_v2(
    w=W,
    l=L,
    t=T,
    h_trey=H_TREY,
    t_wall=T_WALL
) {
    base_x = l + 2 * t_wall + 2 * GAP;
    base_y = w + 2 * t_wall + 2 * GAP;

    color("#4a4646")
    union() {
        // base plate
        base_plate([base_x, base_y, t_wall], h_trey);
        
        for(i=[-1,1]) {
            // front and back bookends
            wall_h = h_trey + t;
            scale([1,i,1])
            translate([0, base_y/2 - t_wall/2, 0])
                base_plate([base_x, t_wall, wall_h], h_trey);
            
            // inner ledge
            ledge_z = h_trey - GAP;
            ledge_w = l/w;
            ledge_count = floor(ledge_w);
            ledge_max = (w*ledge_count)/2 - 1;
            ledge_max_or_one = ledge_max > 0 ? ledge_max : 1;
            for (j=[0:w/2:ledge_max_or_one]) {
                for(k=[-1,1]) {
                    scale([k,i,1])
                    translate([j + (ledge_w)/2, w/2 - t_wall/4, 0])
                        base_plate([ledge_w, t_wall, ledge_z], h_trey);
                }
            }

            // left right ledge
            ledge_2_w = w/l;
            ledge_2_count = floor(ledge_2_w);
            ledge_2_max = (l*ledge_2_count)/2 - 1;
            ledge_2_max_or_one = ledge_2_max > 0 ? ledge_2_max : 1;
            for (j=[0:l/2:ledge_2_max_or_one]) {
                for(k=[-1,1]) {
                    scale([i,k,1])
                    translate([l/2 - t_wall/4, j + (ledge_2_w)/2, 0])
                        base_plate([t_wall, ledge_2_w, ledge_z], h_trey);
                }
            }
                
            // left right bookends
            scale([i,1,1])
            translate([base_x/2 - t_wall/2, 0, 0])
                base_plate([t_wall, base_y, wall_h], h_trey);
            
            
        }
    }
}

module base_with_screws(
    w=W,
    l=L,
    t=T,
    h_trey=H_TREY,
    t_wall=T_WALL,
    xh_1=X_HOLE_1,
    yh_1=Y_HOLE_1,
    dh_1=D_HOLE_1,
    xh_2=X_HOLE_2,
    yh_2=Y_HOLE_2,
    dh_2=D_HOLE_2
) {
    color("grey")
    union() {
        pcb_base_v2(w, l, t, h_trey, t_wall);

        translate([0,0,-h_trey]) {
            
            for(i=[-1:1]) {
            translate([i*xh_1,0,0])
            difference() {
                cylinder(
                    h=h_trey-GAP,
                    d=dh_1+t_wall
                );
                cylinder(
                    h=h_trey+GAP,
                    d=dh_1-GAP
                );
            }
            }

            for(i=[-1,1]) {
            for(j=[-1,1])
            translate([i*xh_2, j*yh_2, 0])
            difference() {
                cylinder(
                    h=h_trey-GAP,
                    d=dh_2+t_wall
                );
                cylinder(
                    h=h_trey+GAP,
                    d=dh_2-GAP
                );
            }
            }
        }

    }
}

%pbc_board();
base_with_screws();





















