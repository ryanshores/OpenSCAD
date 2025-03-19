import subprocess

from model import Part
from model.PartType import PartType
from utility import logs

# Configure logging
logger = logs.Logger(__name__)

def export(part: Part, part_type: PartType):
    """
    Generates the STL file using OpenSCAD.
    """
    export_map = {
        PartType.STL: part.stl_file_path,
        PartType.CSG: part.csg_file_path,
        PartType.PNG: part.png_file_path
    }
    
    if part_type not in export_map:
        raise Exception("invalid export type")
    
    try:
        # Run the OpenSCAD command to generate the STL file
        logger.debug("generating %s", part_type)

        file_path = export_map[part_type]

        subprocess.run(['openscad', '-o', file_path, part.scad_file_path], check=True)
        logger.debug("created %s", file_path)
    except Exception as e:
        logger.error("%s error: %s", part_type, e)
    finally:
        logger.info("finished %s", part_type)