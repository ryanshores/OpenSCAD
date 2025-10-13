import os
import sys
from solid import scad_render_to_file, linear_extrude, difference, polygon
from solid.objects import cube, translate, cylinder, rotate

from models import render_to_file, Out

SEGMENTS = 48

HOLE_DIAMETER = 5.5
HOLE_OFFSET = 5.59

LENGTH_TOP = 14.5
LENGTH_SIDE = 11
LENGTH_BOTTOM = 7.9
WIDTH = 12.5
THICKNESS = 3.5

RIDGE_WIDTH = 1.2
RIGHT_HEIGHT = 1

def assembly(
        hole_diameter=HOLE_DIAMETER,
        hole_offset=HOLE_OFFSET,
        length_top=LENGTH_TOP,
        length_side=LENGTH_SIDE,
        length_bottom=LENGTH_BOTTOM,
        width=WIDTH,
        thickness=THICKNESS,
        ridge_width=RIDGE_WIDTH,
        right_height=RIGHT_HEIGHT,
):
    window_part = linear_extrude(height=width)(
            polygon(points=[
                [1,0],
                [length_top,0],
                [length_top+2, length_side-1],
                [length_top+3, length_side],
                [length_top+length_bottom-ridge_width,length_side],
                [length_top+length_bottom-ridge_width, length_side+right_height],
                [length_top+length_bottom, length_side+right_height],
                [length_top+length_bottom, length_side-thickness+1],
                [length_top+length_bottom-1, length_side-thickness],
                [length_top+thickness+1.5, length_side-thickness],
                [length_top+thickness, -thickness+1],
                [length_top+thickness-1, -thickness],
                [1, -thickness],
                [0, -thickness+1],
                [0,-1]
            ])
    )

    hole = translate((hole_offset, 0, width/2)) (
            rotate((90,0,0)) (
                cylinder(d=hole_diameter, h=3*thickness, segments=20)
            )
    )

    return difference() (window_part, hole)


if __name__ == '__main__':
    render_to_file(assembly(), Out.NONE)