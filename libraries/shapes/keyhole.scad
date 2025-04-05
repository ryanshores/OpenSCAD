module keyhole(
    head_diameter = 8,      // Diameter of the top (screw head)
    shaft_diameter = 4,     // Diameter of the bottom (screw shaft)
    slot_length = 10,       // Distance from head center to shaft center
    thickness = 3,          // Height (for 3D extrusion)
    rounded = true          // Optionally use rounded connector
) {
    difference() {
        // Extruded 2D shape
        linear_extrude(height = thickness) {
            if (rounded) {
                hull() {
                    translate([0, 0]) circle(head_diameter / 2, $fn=50);
                    translate([0, -slot_length]) circle(shaft_diameter / 2, $fn=50);
                }
            } else {
                // Sharp transition
                union() {
                    circle(head_diameter / 2, $fn=50);
                    translate([0, -slot_length])
                        circle(shaft_diameter / 2, $fn=50);
                    translate([-shaft_diameter / 2, -slot_length])
                        square([shaft_diameter, slot_length]);
                }
            }
        }
    }
}

keyhole(rounded=false);