import enum

class PartType(enum.Enum):
    SCAD = 'scad'
    STL = 'stl'
    CSG = 'csg'
    STEP = 'step'
    PNG = 'png'