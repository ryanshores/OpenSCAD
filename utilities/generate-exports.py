import os
import logging
import glob
import re
import subprocess
import FreeCAD
import Part

# Configure logging
logging.basicConfig(level=logging.DEBUG, format='%(asctime)s - %(levelname)s - %(message)s')
logger = logging.getLogger(__name__)

class GenerateExports:
    def __init__(self, dry_run=False):
        self.dry_run = dry_run
        self.stl_file = None
        self.csg_file = None
        self.step_file = None
        self.directory = os.getcwd()
        self.part_name = os.path.basename(self.directory)
        scad_file_name = f"{self.part_name}.scad"
        self.scad_file_path = os.path.join(self.directory, scad_file_name)
        if not os.path.exists(self.scad_file_path):
            logger.error("No .scad file found in the current directory.")
            exit(1)
        # get stl files
        stl_files = glob.glob(pathname=os.path.join(self.directory, "*#*.stl"))

        # extract numbers from stl_files
        numbers = [int(re.search(r'#(\d+)\.stl$', file).group(1))
                   for file in stl_files if re.search(r'#(\d+)\.stl$', file)]

        # get the highest number
        self.version = (max(numbers) if numbers else 0) + 1
        logger.info("Using file: %s for version %s",
                     scad_file_name, self.version)

    def generate(self):
        try:
            self.generate_stl()
            self.generate_csg()
            self.generate_step()
        except Exception as e:
            logger.error("An error occurred: %s", e)
            exit(1)
        finally:
            self.handle_dry_run()

    def generate_stl(self):
        # Run the OpenSCAD command to generate the STL file
        logger.debug("Generating STL file for %s", self.part_name)
        self.stl_file = os.path.join(self.directory, f"{self.part_name}#{self.version}.stl")
        subprocess.run(['openscad', '-o', self.stl_file, self.scad_file_path], check=True)

    def generate_csg(self):
        # Run the OpenSCAD command to generate the CSG file
        logger.debug("Generating CSG file for %s", self.part_name)
        self.csg_file = os.path.join(self.directory, f"{self.part_name}#{self.version}.csg")
        subprocess.run(['openscad', '-o', self.csg_file, self.scad_file_path], check=True)

    def generate_step(self):
        if not self.csg_file or not os.path.exists(self.csg_file):
            logger.error("CSG file not generated.")
            return

        # Path to the output STEP file
        self.step_file = os.path.join(self.directory, f"{self.part_name}#{self.version}.step")

        # Create a new document
        doc = FreeCAD.newDocument("CSG_to_STEP")

        # Import the CSG file
        Part.importCSG(self.csg_file)

        # Get the imported part
        part = doc.Objects[0]

        # Recompute the document to apply changes
        doc.recompute()

        # Export the part to a STEP file
        Part.export([part], self.step_file)

        # Close the document
        FreeCAD.closeDocument("CSG_to_STEP")

    def handle_dry_run(self):
        if not self.dry_run: return
        logger.info("Dry run enabled.")
        if os.path.exists(self.stl_file): os.remove(self.stl_file)
        if os.path.exists(self.csg_file): os.remove(self.csg_file)
        if os.path.exists(self.step_file): os.remove(self.step_file)


if __name__ == "__main__":
    logger.info("start")
    task = GenerateExports(True)
    logger.info("generating exports")
    task.generate()
