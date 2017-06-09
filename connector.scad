// 2020 extrusions are the smallest unit of measurement
use <grid.scad>


/*
 * Create a rectangle with screw holes in it spaced for an extrusion.
 * This is mostly a helper module for other modules.
 *
 * EXAMPLES:
 *
 * connector(4);  // a strip of 4 holes that could be used to join 2 extrusions
 * connector(1, bolt_hole_offset=3);  // offsets can be useful
 *
 * connector([2,3]);  // makes a rectangle with 6 regularly spaced holes
 *
 */
module connector(
    n_holes,
    width=default_extrusion_side_length,
    base_length=default_extrusion_side_length,
    th=default_thickness,
    bolt_diameter=m5_hole_tight,
    bolt_hole_offset=default_bolt_hole_offset) {

  n_holes_x = (len(n_holes) == undef) ? n_holes : n_holes[0];
  n_holes_y = (len(n_holes) == undef) ? 1 : (len(n_holes) == 1) ? 1 : n_holes[1];
  length_x = n_holes_x * base_length;
  length_y = n_holes_y * width;
  difference() {
    cube([length_x, length_y, th]);
    translate([base_length/2, width/2, -.5])
      for (i = [0:1:n_holes_x], j = [0:1:n_holes_y])
        translate([i * base_length, j * width, 0])
          if (bolt_hole_offset > 0) {
            hull() for (k=[-1,1])
              translate([k*bolt_hole_offset/2,0,0])
              cylinder(r=bolt_diameter/2, h=th+1, $fs=1);
          } else {
            cylinder(r=bolt_diameter/2, h=th+1, $fs=1);
          }
  }
}


// demo

translate([0,120,0])text("connector(num_holes, ...);", halign="center");
translate([-20,-10,0])grid([90, 45], center=true) {
  text("(4)", size=6);
  text("(1, bolt_hole_offset=3)", size=6);
  text("([2,3])", size=6);
  text("([3,2], width=30, base_length=10, th=20)", size=6);
}
grid([90, 45], center=true) {
  connector(4);
  connector(1, bolt_hole_offset=3);
  connector([2,3]);
  connector([3,2], width=30, base_length=10, th=20);
}


include <_defaults.scad>
