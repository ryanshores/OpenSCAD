use <shared.scad>
//include <BOSL/constants.scad>
//use <BOSL/shapes.scad>

module box(dims) {
    cuboid([dims[0], dims[1], dims[2]], [0,0,0]);
}