import subprocess

free_cad_cmd = '/Applications/FreeCAD.app/Contents/Resources/bin/freecadcmd'
generate_script = '../scripts/generate-exports.py'

def main():
    subprocess.run(
        [free_cad_cmd, generate_script],
        check=True)

if __name__ == "__main__":
    main()