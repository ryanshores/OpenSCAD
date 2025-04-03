include <tank/shared.scad>

module waterfall_centered() {
    // Create a waterfall using the imported STL file
    translate_z = 98 / 2;
        translate([0,0, translate_z])
            rotate([0, 0, 270])
                import("original.stl", convexity = 10, center = true);
}

waterfall_centered();