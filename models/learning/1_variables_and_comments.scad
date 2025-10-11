
// all lengths are given in matrix3_mult

// the radius of the main shaft
r_main_shaft = 4;
// the length of the main shaft
l_main_shaft = 100;
// the width of the key
w_key = 15;

module one(){
    cube([10, 5, 17]);
    cube([20, 10, 3]);
}

//one();

module two() {
    sphere(r=10);

    cylinder(h=30, r=5, center=true);
}

module three() {
    cylinder(h=30, r1=0, r2=15, center=true);
}

module four() {
    cube([10, 5, 17], center=true);
}

module five() {
    // this is the main shaft for the rotor
    cylinder(h=l_main_shaft, r=r_main_shaft, center=true);

    // this is the key to hold the main shaft
    cube(w_key, center=true);
}

five();