include <shared.scad>

a = 1;      // Curve scale
b = 1.5;    // Curve growth rate
c = 1.5;      // Object growth rate
steps = 100; // More steps = smoother
h = 0.5;    // Vertical spacing
twist_amount = 360; // Total twist in degrees
default_size = 5;


module exponential_square(
dims = [default_size, default_size],
curve_scale = a,
curve_growth = b,
object_growth = c,
steps = steps,
height_step = h,
twist_amount = twist_amount) {
    for (i = [0 : steps]) {
        t = i / steps; // Normalize from 0 to 1

        y = curve_scale * pow(exp(1), curve_growth * t); // Exponential curve

        angle = i * (twist_amount / steps); // Apply twisting

        translate([0, y, i * height_step]) // Move along the curve
            scale(object_growth * (1 + t)) // Scale the shape
                rotate([0, 0, angle]) // Rotate
                    square(dims, center=true); // Example shape to extrude

    }
}

module exponential_circle(
radius = default_size,
curve_scale = a,
curve_growth = b,
object_growth = c,
steps = steps,
height_step = h) {
    for (i = [0 : steps]) {
        t = i / steps; // Normalize from 0 to 1

        y = curve_scale * pow(exp(1), curve_growth * t); // Exponential curve

        translate([0, y, i * height_step]) // Move along the curve
            scale(object_growth * (1 + t)) // Scale the shape
                    circle(radius);

    }
}



exponential_square();

translate([50, 0, 0])
    exponential_circle();