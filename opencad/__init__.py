FREECADPATH = '/Applications/FreeCAD.app/Contents/Resources' # path to your FreeCAD
FREECAD_LIBPATH = f'FREECADPATH/lib'
FREECAD_MODPATH = f'FREECADPATH/Mod'
import sys
sys.path.append(FREECAD_LIBPATH)
sys.path.append(FREECAD_MODPATH)