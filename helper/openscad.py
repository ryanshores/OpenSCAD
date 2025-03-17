import subprocess

from model import Part
from model.PartType import PartType
from utility import logs

# Configure logging
logger = logs.Logger(__name__)

allowed_types = [PartType.STL, PartType.CSG]

def export(part: Part, part_type: PartType):
    """
    Generates the STL file using OpenSCAD.
    """
    if part_type not in allowed_types:
        raise Exception("invalid part type")
    try:
        # Run the OpenSCAD command to generate the STL file
        logger.debug("generating %s", part_type)

        if part_type == PartType.CSG:
            file_path = part.csg_file_path
        elif part_type == PartType.STL:
            file_path = part.stl_file_path

        subprocess.run(['openscad', '-o', file_path, part.scad_file_path], check=True)
        logger.debug("created %s", file_path)
    except Exception as e:
        logger.error("%s error: %s", part_type, e)
    finally:
        logger.info("finished %s", part_type)