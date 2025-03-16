scad_file=$(ls *.scad | head -n 1)
echo $scad_file

file_name="${scad_file%.*}"
echo $file_name

highest_number=$(ls $file_name#*.stl 2>/dev/null | sed -E 's/.*#([0-9]+)\..*/\1/' | sort -n | tail -n 1)
echo $highest_number

if [ -z "$highest_number" ]; then
  highest_number=0
fi

new_number=$((highest_number + 1))
echo $new_number

stl_file=$(ls *.stl | head -n 1)
file_name="${scad_file%.*}"

openscad -o $file_name#$new_number.stl $scad_file