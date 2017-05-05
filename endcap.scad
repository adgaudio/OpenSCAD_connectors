use <repeat_grid.scad>
use <defaults.scad>

/*
 * Generate endcaps for aluminum extrusions.
 *
 * These have been tested to fit Openbuilds and Misumi 20mm extrusions.
 *
 * EXAMPLES
 * endcap(20,20);  // For a 2020 extrusion:
 * endcap(20,40);  // For a 2040 extrusion:
 * endcap(20,80);  // For a 2080 extrusion:
 *
 * endcap(40,80,bolt_hole=m5_hole_tight);
 *
 * Parameters:
 *
 * x and y - the number of millimeters per side.
 * h - the length of the section of endcap that inserts into the extrusion
 * th - the thickness of the base plate of the endcap
 * bolt_hole - pass in a screw hole diameter if you wish to fasten the endcap
 *   to the extrusion using a bolt.
 * min_side_length - *experimental* the base denomination for your extrusion.
 *   if your extrusion is a 15 series, you could try setting this value to 38.1
 *   (which is 1.5 inches).  Untested, but might work.
 */
module endcap(x=20, y=20, h=8, th=2, bolt_hole=0, min_side_length=20) {
  repeat_grid(
      [x/min_side_length, y/min_side_length, 1],
      [min_side_length,min_side_length,0])
    _endcap_1x1(
      min_side_length, h=h, th=th,
      min_side_length=min_side_length, bolt_hole=bolt_hole);
}



// Internal code below here


module _round_square(xy) {
  minkowski() {
    square([xy[0] - 2, xy[1] - 2], center=true);
    circle(r=1, center=true);
  }
}

module _insert(h, th, min_side_length) {
  // x
  lbig=10 /20*min_side_length;
  lsmall=5 /20*min_side_length;
  // z
  d=3.95 /20*min_side_length;
  dslant=2.5 /20*min_side_length;
  // y
  h=h + th;

  translate([0,0,(dslant)]){
    rotate([180,0,0]) translate([0,0,dslant/2])
      linear_extrude(height=dslant, scale=[lsmall / lbig,1],
          center=true, $fa=4, $fs=.5)
      _round_square([lbig, h]);
    linear_extrude(height=d-dslant, $fa=4,$fs=.5)
      _round_square([lbig, h]);
    /* %translate([0,0,-.5])cube([lbig,h,d],center=true); */
  }
}

module _endcap_1x1(h, th, min_side_length, bolt_hole) {
  l=7.5 /20*min_side_length;
  m = min_side_length;
  translate([0,0,h/2+th/2])
    rotate([-90,0,0])
    {
      translate([0,0,-l/2])rotate([0,180,0])_insert(
          h=h, th=th, min_side_length=m);
      translate([0,0,l/2])_insert(
          h=h, th=th, min_side_length=m);
      translate([l/2,0,0])rotate([0,90,0])_insert(
          h=h, th=th, min_side_length=m);
      translate([-l/2,0,0])rotate([0,-90,0])_insert(
          h=h, th=th, min_side_length=m);
      /* %cube([l,l,l],center=true); */
      difference(){
      translate([0,h/2,0])cube([m,th,m],center=true);
      rotate([-90,0,0])translate([0,0,th+.5])
        cylinder(r=bolt_hole/2, h=th+1, $fa=4, $fs=.5);
      }
    }
}
