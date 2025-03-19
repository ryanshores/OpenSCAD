import glob
import os
import re

from model.PartType import PartType
from utility.logs import Logger
from helper import openscad

logger = Logger(__name__)

class Part():
    def __init__(self, directory: str):
        self.directory = directory
        self.name = os.path.basename(directory)
        self.scad_file_path = os.path.join(self.directory, f"{self.name}.scad")
        self.version = self.validate_get_version()
        self.version_name = f'{self.name}#{self.version}'
        self.png_file_path = os.path.join(self.directory, f"{self.name}.{PartType.PNG.value}")
        self.stl_file_path = os.path.join(self.directory, f"{self.version_name}.{PartType.STL.value}")
        self.csg_file_path = os.path.join(self.directory, f"{self.version_name}.{PartType.CSG.value}")
        self.step_file_path = os.path.join(self.directory, f"{self.version_name}.{PartType.STEP.value}")
        logger.info(self.version_name)

    def validate_get_version(self) -> int:
        """
        Verifies the initialization of the Part class, and gets the next version number.

        Returns:
            int: The version number.
        """
        # get stl files
        if not os.path.exists(self.scad_file_path):
            logger.error("no SCAD file found in the current directory")
            exit(1)

        stl_files = glob.glob(pathname=os.path.join(self.directory, "*#*.stl"))

        # extract numbers from stl_files
        numbers = [int(re.search(r'#(\d+)\.stl$', file).group(1))
                   for file in stl_files if re.search(r'#(\d+)\.stl$', file)]

        # get the highest number
        return (max(numbers) if numbers else 0) + 1

    def create_png(self): openscad.export(self, PartType.PNG)
        
    def create_stl(self): openscad.export(self, PartType.STL)

    def create_csg(self): openscad.export(self, PartType.CSG)