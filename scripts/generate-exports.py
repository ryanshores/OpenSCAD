import argparse
import os

from model.Part import Part
from utility import logs

logger = logs.Logger(__name__)

class GenerateExports:
    """
    A class to generate specified export files from OpenSCAD files.

    Attributes:
        dry_run (bool): If True, generated files will be deleted after creation.
        export_types (list): List of export types to generate.
        part (Part): The Part object representing the part to be exported.
    """

    def __init__(self, dry_run=False, export_types=None):
        """
        Initializes the GenerateExports class with the given parameters.

        Args:
            dry_run (bool): If True, generated files will be deleted after creation.
            export_types (list): List of export types to generate.
        """
        self.dry_run = dry_run
        self.export_types = export_types if export_types else ['png', 'step']
        self.part = Part(os.getcwd(), self.dry_run)

    def generate(self):
        """
        Generates the specified export files.
        """
        try:
            logger.info("generating %s for %s",self.export_types, self.part.name)
            if 'png' in self.export_types or 'all' in self.export_types:
                self.part.create_png()
            if 'stl' in self.export_types or 'all' in self.export_types:
                self.part.create_stl()
            if 'csg' in self.export_types or 'all' in self.export_types:
                self.part.create_csg()
            if 'step' in self.export_types or 'all' in self.export_types:
                self.part.create_step()
            logger.info("finished generating exports for %s", self.part.name)
        except Exception as e:
            logger.error("an error occurred: %s", e)
            exit(1)

if __name__ == "__main__":
    try:
        parser = argparse.ArgumentParser(description="Generate specified export files from OpenSCAD files.")
        parser.add_argument('--dry-run', action='store_true', help="If set, generated files will be deleted after creation.")
        parser.add_argument('--export-types',
                            nargs='+',
                            choices=['stl', 'csg', 'step', 'png', 'all'],
                            default=['all'],
                            help="Specify which export types to generate (default: all).")
        args = parser.parse_args()

        task = GenerateExports(dry_run=args.dry_run, export_types=args.export_types)
        task.generate()
    except Exception as e:
        logger.error("an error occurred: %s", e)
        exit(1)