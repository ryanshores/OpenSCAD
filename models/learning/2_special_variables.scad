// will set the cylinder to have 50 sides
$fn = 50;

l_shaft = 100;
r_shaft = 5;

// set fn to make 6 sides
cylinder(r=r_shaft, h=l_shaft, center=true, $fn=6);
// will use the 50 sides set from above
sphere(r=20);