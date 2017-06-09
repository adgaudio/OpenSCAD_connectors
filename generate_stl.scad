/*
 * This script generates STL files for thingiverse
 * To export all these files in one go, I use a openscad_exporter:
 *
 * openscad_exporter generate_stl.scad
 *
 * The openscad_exporter script is available here:
 * wget https://github.com/adgaudio/OpenSCAD-Tools/blob/master/openscad_exporter
 */
use <connector.scad>;
use <tjoint.scad>;
use <corner_bracket.scad>;


module corner_bracket_101o() {  // make me
  corner_bracket(1,0,1,bolt_hole_offset=4);
}
module corner_bracket_12012o() {  // make me
  corner_bracket([1,2],0,[1,2], bolt_hole_offset=4);
}
module corner_bracket_222o() {  // make me
  corner_bracket(2,2,2,bolt_hole_offset=4);
}
module corner_bracket_210o() {  // make me
  corner_bracket(2,1,0,bolt_hole_offset=4);
}

module tjoint_3130o() {  // make me
  tjoint([3,1], [3,0], bolt_hole_offset=4);
}
module tjoint_3030o() {  // make me
  tjoint([3,0], [3,0], bolt_hole_offset=4);
}
module tjoint_5353o() {  // make me
  tjoint([5,2], [5,2], bolt_hole_offset=4);
}
module tjoint_3131o() {  // make me
  tjoint([3,1], [3,1], bolt_hole_offset=4);
}
module tjoint_321222o() {  /// make me
  tjoint([[3,2],1], [[2,2],2], bolt_hole_offset=4);
}


module connector_2() {  // make me
  connector(2, bolt_diameter=m5_hole_loose);
}
module connector_3() {  // make me
  connector(3, bolt_diameter=m5_hole_loose);
}
module connector_4() {  // make me
  connector(4, bolt_diameter=m5_hole_loose);
}
module connector_22() {  // make me
  connector([2,2], bolt_diameter=m5_hole_loose);
}
module connector_23() {  // make me
  connector([2,3], bolt_diameter=m5_hole_loose);
}
module connector_24() {  // make me
  connector([2,4], bolt_diameter=m5_hole_loose);
}
module connector_33() {  // make me
  connector([3,3], bolt_diameter=m5_hole_loose);
}
module connector_44() {  // make me
  connector([4,4], bolt_diameter=m5_hole_loose);
}


include <_defaults.scad>
