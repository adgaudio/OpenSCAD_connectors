// 2020 extrusions are the smallest unit of measurement


/*
 * Create a rectangle with screw holes in it spaced for an extrusion.
 * This is mostly a helper module for other modules.
 *
 * EXAMPLES:
 *
 * connector(4);  // a strip of 4 holes that could be used to join 2 extrusions
 * connector(1, bolt_hole_offset=3);  // offsets can be useful
 *
 */
module connector(
    n_holes,
    width=default_extrusion_side_length,
    base_length=default_extrusion_side_length,
    th=default_thickness,
    bolt_diameter=m5_hole_tight,
    bolt_hole_offset=default_bolt_hole_offset) {

  length = n_holes * base_length;
  difference() {
    cube([length, width, th]);
    translate([base_length/2, width/2, -.5])
      for (i = [0:1:n_holes])
        translate([i * base_length, 0, 0])
          if (bolt_hole_offset > 0) {
            hull() for (j=[-1,1])
              translate([j*bolt_hole_offset/2,0,0])
              cylinder(r=bolt_diameter/2, h=th+1, $fs=1);
          } else {
            cylinder(r=bolt_diameter/2, h=th+1, $fs=1);
          }
  }
}


include <_defaults.scad>
