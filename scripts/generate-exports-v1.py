"""
This script generates STL, CSG files from OpenSCAD files using FreeCAD.

Classes:
    GenerateExports: Handles the generation of export files.

Usage:
    Run the script to generate the export files.
"""
import os
import logging
import glob
import re
import subprocess

# Configure logging
logging.basicConfig(level=logging.DEBUG, format='%(asctime)s - %(levelname)s - %(message)s')
logger = logging.getLogger(__name__)

class GenerateExports:
    """
    A class to generate STL, CSG files from OpenSCAD files.

    Attributes:
        dry_run (bool): If True, generated files will be deleted after creation.
        stl_file (str): Path to the generated STL file.
        csg_file (str): Path to the generated CSG file.
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
        self.directory = os.getcwd()
        self.part_name = os.path.basename(self.directory)
        self.scad_file_path = os.path.join(self.directory, f"{self.part_name}.scad")
        if not os.path.exists(self.scad_file_path):
            logger.error("no SCAD file found in the current directory")
            exit(1)
        # get stl files
        stl_files = glob.glob(pathname=os.path.join(self.directory, "*#*.stl"))

        # extract numbers from stl_files
        numbers = [int(re.search(r'#(\d+)\.stl$', file).group(1))
                   for file in stl_files if re.search(r'#(\d+)\.stl$', file)]

        # get the highest number
        self.version = (max(numbers) if numbers else 0) + 1
        version_name = f'{self.part_name}#{self.version}'
        self.stl_file = os.path.join(self.directory, f"{version_name}.stl")
        self.csg_file = os.path.join(self.directory, f"{version_name}.csg")
        logger.info(version_name)
        if self.dry_run: logger.debug('dry run')

    def set_version(self):
        """
        Sets the version number of the generated files.

        Returns:
            int: The version number.
        """
        # get stl files
        stl_files = glob.glob(pathname=os.path.join(self.directory, "*#*.stl"))

        # extract numbers from stl_files
        numbers = [int(re.search(r'#(\d+)\.stl$', file).group(1))
                   for file in stl_files if re.search(r'#(\d+)\.stl$', file)]

        # get the highest number
        self.version = (max(numbers) if numbers else 0) + 1

    def generate(self):
        """
        Generates the STL, CSG, and STEP files.
        """
        try:
            logger.info("generating exports for %s", self.part_name)
            self.generate_stl()
            self.generate_csg()
        except Exception as e:
            logger.error("an error occurred: %s", e)
            exit(1)
        finally:
            self.handle_dry_run()
            logger.info("finished generating exports for %s", self.part_name)

    def generate_stl(self):
        """
        Generates the STL file using OpenSCAD.
        """
        try:
            # Run the OpenSCAD command to generate the STL file
            logger.debug("generating stl")
            subprocess.run(['openscad', '-o', self.stl_file, self.scad_file_path], check=True)
            logger.debug("created %s", self.stl_file)
        except Exception as e:
            logger.error("stl error: %s", e)
        finally:
            logger.info("finished stl")

    def generate_csg(self):
        """
        Generates the CSG file using OpenSCAD.
        """
        try:
            # Run the OpenSCAD command to generate the CSG file
            logger.debug("generating csg")
            subprocess.run(['openscad', '-o', self.csg_file, self.scad_file_path], check=True)
            logger.debug("created %s", self.csg_file)
        except Exception as e:
            logger.error("csg error: %s", e)
        finally:
            logger.info("finished csg")

    def validate_csg(self) -> Mesh:
        try:
            logger.debug("validating csg")
            if not os.path.exists(self.csg_file):
                logger.debug("csg not generated... creating")
                self.generate_csg()
            if not os.path.exists(self.csg_file):
                raise Exception("csg not generated")
        except Exception as e:
            logger.error("failed csg import %s", e)
            raise e

    def import_csg_mesh(self) -> Mesh:
        try:
            logger.debug("importing csg mesh")
            self.validate_csg()

            shape = Mesh.Mesh(self.csg_file)
            logger.debug("created shape")
            return shape
        except Exception as e:
            logger.error("failed csg mesh import %s", e)
            raise e

    def import_csg_part(self) -> Part:
        try:
            logger.debug("importing csg part")
            self.validate_csg()

            shape = Part.read(self.csg_file)
            logger.debug("created shape")
            return shape
        except Exception as e:
            logger.error("failed csg part import %s", e)
            raise e

    def handle_dry_run(self):
        """
        Handles the dry run by deleting the generated files if dry_run is True.
        """
        if not self.dry_run: return
        logger.debug("starting dry run clean up")
        if os.path.exists(self.stl_file): os.remove(self.stl_file)
        if os.path.exists(self.csg_file): os.remove(self.csg_file)
        logger.info("finished dry run clean up")

task = GenerateExports()
task.generate()