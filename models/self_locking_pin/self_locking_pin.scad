include <shared.scad>

// --- (mm) ---
pin_diameter = 4;      // [2:0.5:10] Diameter of the pin body
pin_length = 6;        // [5:1:50] Total length of the pin
head_diameter = 8;     // [5:1:50] Diameter of the head
head_thickness = 1;    // [0.5:0.5:5] Thickness of the head
slot_length = 6;       // [5:1:50] Length of the slot
slot_width = 1;        // [1:1:50] Width of the slot

// --- Main function ---
module self_locking_pin() {
    difference() {
        union() {
            // Corps du pin
            cylinder(h = pin_length, d = pin_diameter);
            
            // Tête 
            translate([0, 0, pin_length])
                cylinder(d = head_diameter,h=head_thickness);

            // Base (zone de verrouillage)
            translate([0, 0, pin_length-pin_length-3])
    cylinder(h = 3, d1 = pin_diameter, d2 = pin_diameter*1.3);
        }

        // Fente autobloquante 
        translate([0, 0, 0])
    cube([slot_width, pin_diameter*1.3, slot_length], center = true);
    }
}

// Generate the model
self_locking_pin();