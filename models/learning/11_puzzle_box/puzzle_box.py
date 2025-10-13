from solid import square, OpenSCADObject

from models import render_to_file, Out

def box() -> OpenSCADObject:
    return square(10)

def assembly() -> OpenSCADObject:
    return box()

if __name__ == "__main__":
    render_to_file(assembly(), Out.SCAD)