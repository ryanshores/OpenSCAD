import glob
import os
import re

from model.PartType import PartType
from utility.logs import Logger
from helper import openscad
from helper.freecad import freecad

logger = Logger(__name__)

VERSION_LABEL = 'v'
DRAFT_VERSION_LABEL = 'draft'

class Part():
    def __init__(self, directory: str, dry_run: bool):
        self.directory = directory
        self.dry_run = dry_run
        self.name = os.path.basename(directory)
        self.scad_file_path = os.path.join(self.directory, f"{self.name}.{PartType.SCAD.value}")
        self.validate()
        self.output_dir = self.get_output()
        self.clear_output()
        logger.info(self.name)

    def validate(self):
        """
        Validates the scad file exits
        """
        if not os.path.exists(self.scad_file_path):
            raise FileNotFoundError(self.scad_file_path)

    def get_output(self) -> str:
        """
        Determines the output folder to use, v# or draft
        """

        if self.dry_run:
            output_folder = DRAFT_VERSION_LABEL
        else:
            # get version folders
            versions = glob.glob(pathname=os.path.join(self.directory, f"{VERSION_LABEL}*"))

            # extract numbers from stl_files
            pattern = rf'{VERSION_LABEL}(\d+)$'
            numbers = [int(re.search(pattern, file).group(1))
                       for file in versions if re.search(pattern, file)]

            # get the highest number
            version = (max(numbers) if numbers else 0) + 1

            output_folder = f'{VERSION_LABEL}{version}'

        os.makedirs(output_folder, exist_ok=output_folder==DRAFT_VERSION_LABEL)

        return output_folder

    def clear_output(self):
        """
            Deletes all files in directory.
        """
        files = glob.glob(os.path.join(self.output_dir, '*'))
        for file in files:
            if os.path.isfile(file):
                os.remove(file)

    def get_file_path(self, type: PartType) -> str:
        return os.path.join(self.output_dir, f"{self.name}.{type.value}")

    def create_png(self): openscad.export(self, PartType.PNG)

    def create_stl(self): openscad.export(self, PartType.STL)

    def create_csg(self): openscad.export(self, PartType.CSG)

    def create_step(self): freecad(self).export_step()