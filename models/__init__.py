import os
import sys

from enum import Enum
from solid import OpenSCADObject, scad_render_to_file, scad_render

GLOBAL_SEGMENTS = 48


class Out(Enum):
    NONE = "none",
    SCAD = "scad",
    BAMBU = "stl"


def render_to_file(
        scad_object: OpenSCADObject,
        out: Out = None):

    if out == Out.NONE:
        scad_render(scad_object=scad_object,
                    file_header=f'$fn = {GLOBAL_SEGMENTS};')
    else:
        # get the path of the calling file
        calling_file = os.path.abspath(sys.argv[0])
        file_out = scad_render_to_file(
            scad_object=scad_object,
            file_header=f'$fn = {GLOBAL_SEGMENTS};',
            include_orig_code=False,
            out_dir=os.path.dirname(calling_file),
            filepath=os.path.basename(calling_file).replace(".py", ".scad")
        )
        print(f"{__file__}: SCAD file written to: \n{file_out}")

        if out == Out.BAMBU:
            # Open in Bambu
            stl_file = file_out.replace(".scad", ".stl")
            os.system(f"openscad -o {stl_file} {file_out}")
            print(f"{__file__}: STL file written to: \n{stl_file}")
            os.system(f"open -a BambuStudio {stl_file}")
        elif out == Out.SCAD:
            # Auto-open in OpenSCAD
            os.system(f"open -a OpenSCAD-2021.01.app {file_out}")

    print("Done.")