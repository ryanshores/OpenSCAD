import os
import FreeCAD # do not remove
import Part
import importCSG  # OpenSCAD import module in FreeCAD

from model import Part as PartModel
from model.PartType import PartType
from utility import logs

logger = logs.Logger(__name__)

class freecad:
    def __init__(self, part: PartModel):
        self.part = part
        self.document_name = self.part.name
        self.document = self.open_document()
        logger.info(self.document_name)

    def open_document(self):
        """
        Loads the csg part using OpenSCAD.
        """
        try:
            logger.debug(self.part.name)
            file_name = self.part.get_file_path(PartType.CSG)

            if not os.path.exists(file_name):
                logger.info("generating csg file")
                self.part.create_csg()
            if not os.path.exists(file_name):
                raise FileNotFoundError(file_name)

            # open the csg file
            document = importCSG.open(file_name)

            # Recompute the document to apply changes
            document.recompute()
            logger.info(self.part.name)
            return document
        except Exception as e:
            logger.error(e)
            raise Exception("failed to open document")

    def export_step(self):
        """
        Exports the scad file using OpenSCAD.
        """
        try:
            file_name = self.part.get_file_path(PartType.STEP)
            logger.debug(file_name)

            objects =self.document.Objects

            parts = list(filter(lambda o: not o.InList , objects))

            Part.export(parts, file_name)

            logger.info(file_name)
        except Exception as e:
            logger.error(e)

    