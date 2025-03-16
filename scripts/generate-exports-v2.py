"""
This script generates STL, CSG, and STEP files from OpenSCAD files using FreeCAD.
It must be run using the FreeCAD Python interpreter.

Classes:
    GenerateExports: Handles the generation of export files.

Usage:
    Run the script with the FreeCAD Python interpreter to generate the export files.
"""
FREECADPATH = '/Applications/FreeCAD.app/Contents/Resources' # path to your FreeCAD
FREECAD_LIBPATH = f'FREECADPATH/lib'
FREECAD_MODPATH = f'FREECADPATH/Mod'
import sys
sys.path.append(FREECAD_LIBPATH)
sys.path.append(FREECAD_MODPATH)
import os
import logging
import glob
import re
import subprocess
import FreeCAD
import Part
import Mesh
import importCSG
from freecad import module_io
import Import

# Configure logging
logging.basicConfig(level=logging.DEBUG, format='%(asctime)s - %(levelname)s - %(message)s')
logger = logging.getLogger(__name__)

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
        self.step_file = os.path.join(self.directory, f"{version_name}.step")
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
            self.generate_step_v2()
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

    def generate_step(self):
        """
        Generates the STEP file using FreeCAD.
        """
        try:
            logger.debug("generating step")

            # Create a new document
            doc = FreeCAD.newDocument("CSG_to_STEP")
            logger.debug("created freecad document")

            # Import the CSG file
            shape = self.import_csg_part()
            logger.debug("created shape")

            # Add the shape to the document
            obj = doc.addObject("Part::Feature", self.part_name)
            obj.Shape = shape
            logger.debug("added shape to document")

            # Recompute the document to apply changes
            doc.recompute()
            logger.debug("recomputed document")

            # Export the part to a STEP file
            Part.export([shape], self.step_file)
            logger.debug("exported shape to step")

            # Close the document
            FreeCAD.closeDocument("CSG_to_STEP")
            logger.debug("created %s", self.step_file)
        except Exception as e:
            logger.error("failed step: %s", e)
        finally:
            logger.info("finished step")

    def generate_step_v2(self):
        """
        Generates the STEP file using FreeCAD.
        """
        try:
            logger.debug("generating step v2")

            # Create a new document
            doc = FreeCAD.newDocument(self.part_name)
            # FreeCAD.setActiveDocument(self.part_name)
            logger.debug("created freecad document")

            # Import the CSG file
            module_io.OpenInsertObject("importCSG", self.csg_file, "insert", self.part_name)
            logger.debug("imported csg")

            doc.recompute()
            logger.debug("recomputed document")

            __objs__ = [doc.getObject(self.part_name)]
            Import.export(__objs__, self.step_file)
            del(__objs__)
            logger.debug("exported shape to step")

            # Close the document
            FreeCAD.closeDocument(self.part_name)
            logger.debug("created %s", self.step_file)
        except Exception as e:
            logger.error("failed step: %s", e)
        finally:
            logger.info("finished step")

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