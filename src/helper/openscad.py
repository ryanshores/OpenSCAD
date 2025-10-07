import subprocess

from src.models import Part
from src.models.PartType import PartType
from src.utility import logs

# Configure logging
logger = logs.Logger(__name__)

SUPPORTED_EXTENSIONS = [PartType.PNG, PartType.STL, PartType.CSG]

def export(part: Part, part_type: PartType):
    """
    Generates the STL file using OpenSCAD.
    """
    if part_type not in SUPPORTED_EXTENSIONS:
        raise Exception("invalid export type")

    try:
        logger.debug("%s.%s", part.name, part_type.value)

        file_path = part.get_file_path(part_type)

        subprocess.run(['openscad', '-o', file_path, part.scad_file_path], check=True)

        logger.info(file_path)
    except Exception as e:
        logger.error(e)