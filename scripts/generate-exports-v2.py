"""
This script generates STL, CSG, and STEP files from OpenSCAD files using FreeCAD.
It must be run using the FreeCAD Python interpreter.

Classes:
    GenerateExports: Handles the generation of export files.

Usage:
    Run the script with the FreeCAD Python interpreter to generate the export files.
"""
import os

from model.Part import Part
from utility import logs

logger = logs.Logger(__name__)

class GenerateExports:
    """
    A class to generate STL, CSG, and STEP files from OpenSCAD files.

    Attributes:
        dry_run (bool): If True, generated files will be deleted after creation.
        stl_file (str): Path to the generated STL file.
        csg_file (str): Path to the generated CSG file.
        step_file (str): Path to the generated STEP file.
        directory (str): Current working directory.
        part_name (str): Name of the part derived from the directory name.
        scad_file_path (str): Path to the OpenSCAD file.
        version (int): Version number for the generated files.
    """

    def __init__(self, dry_run=False):
        """
        Initializes the GenerateExports class with the given parameters.

        Args:
            dry_run (bool): If True, generated files will be deleted after creation.
        """
        self.dry_run = dry_run
        self.part = Part(os.getcwd())
        if self.dry_run: logger.debug('dry run')



    def generate(self):
        """
        Generates the STL, CSG, and STEP files.
        """
        try:
            logger.info("generating exports for %s", self.part.name)
            self.part.create_step()
        except Exception as e:
            logger.error("an error occurred: %s", e)
            exit(1)
        finally:
            self.handle_dry_run()
            logger.info("finished generating exports for %s", self.part.name)

    def handle_dry_run(self):
        """
        Handles the dry run by deleting the generated files if dry_run is True.
        """
        if not self.dry_run: return
        logger.debug("starting dry run clean up")
        if os.path.exists(self.stl_file): os.remove(self.stl_file)
        if os.path.exists(self.csg_file): os.remove(self.csg_file)
        if os.path.exists(self.step_file): os.remove(self.step_file)
        logger.info("finished dry run clean up")

task = GenerateExports()
task.generate()