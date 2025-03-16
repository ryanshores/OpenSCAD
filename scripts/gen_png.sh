scad_file=$(ls *.scad | head -n 1)
file_name="${scad_file%.*}"

openscad -o $file_name.png *.scad