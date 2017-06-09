# local params=" --imgsize=800,800 --camera=186,40,20,34,0,341,636"



files=( "connector.scad" "tjoint.scad" "corner_bracket.scad" "repeat_grid.scad" )
for scad_file in "${files[@]}" ; do
openscad --imgsize=550,500 --camera=20,0,0,45,0,25,800 -o images/${scad_file/.scad/.png} $scad_file
done

