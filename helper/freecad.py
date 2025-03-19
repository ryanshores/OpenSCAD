import FreeCAD
import Part
import importCSG  # OpenSCAD import module in FreeCAD

from model import Part as PartModel
from model.PartType import PartType
from utility import logs

logger = logs.Logger(__name__)

def export_step(part: PartModel): Part.export([part], part.step_file_path)
    
### Not working on arm arch, abandoning for now
# importCSG relies on PySide2 which is not compiled for arm
# plan to recompile freecad if needed
class freecad:
    def __init__(self, part: PartModel):
        self.part = part
        self.document_name = self.part.name
        self.document = self.initialize_document()
        self.part = self.initialize_part()
        logger.info(part.name)
        
    def initialize_document(self) -> FreeCAD.Document:
        """
        Initializes the FreeCAD document.
        """
        try:
            logger.debug(self.document_name)
            # Create a new FreeCAD document
            return FreeCAD.newDocument(self.document_name)
        except Exception as e:
            logger.error(e)
            raise Exception("failed to initialize document")
        finally:
            logger.info(self.document_name)

    def initialize_part(self) -> Part:
        """
        Loads the scad part using OpenSCAD.
        """
        try:
            logger.debug(self.part.scad_file_path)

            # Import the .scad file
            importCSG.insert(self.part.scad_file_path, self.document_name)
            
            # # Import the CSG file
            # shape = Part.read(self.part.scad_file_path)
            # 
            # # Add the shape to the document
            # part = self.document.addObject("Part::Feature", "Shape")
            # part.Shape = shape
        
            # Recompute the document to apply changes
            self.document.recompute() 
            
            return part
        except Exception as e:
            logger.error(e)
            raise Exception("failed to initialize part")
        finally:
            logger.info(self.part.scad_file_path)

    def export_step(self, part_type: PartType):
        """
        Exports the scad file using OpenSCAD.
        """
        try:
            logger.debug(part_type)

            Part.export([self.part], self.part.step_file_path)
        except Exception as e:
            logger.error(e)
        finally:
            logger.info(self.part_type)

    