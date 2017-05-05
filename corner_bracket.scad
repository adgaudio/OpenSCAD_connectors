use <repeat_grid.scad>
use <connector.scad>

/*
 * Create many different kinds of corner brackets with this module.
 *
 * EXAMPLES:
 * corner_bracket(1, 0, 1);  // Join 2 extrusions on the x and z axes
 * corner_bracket(2, 1, 0);  // Join 2 extrusions on the x and y axes
 * corner_bracket(2, 1, 1);  // Join 3 extrusions on the x,y,z axes OR
 *                              join 2 extrusions on the y and z axes
 *
 * corner_bracket(3,4,5);  // extend in many directions
 * corner_bracket(2,2,2, bolt_hole_offset=4);  // offset can be very useful
 *
 *
 * PARAMETERS:
 *
 *   n_holes_{x,y,z} - how many screw holes in each dimension.
 *       Screw holes are spaced every `side_length` mm
 *   side_length - how long the side of the extrusion is.  A 2020 extrusion is 20mm.
 *   {xz,xy,yz}_side_plate - whether or not to use supporting side plates (if
 *       relevant).
 *   side_plate_th - the wall thickness of the support.
 *   th - the thickness of the base plate that touches the extrusion
 *   bolt_diameter - the diameter of the bolt hole.  Set to tight tolerance by default
 *   bolt_hole_offset - number of mm to make the bolt hole wider by.
 */
module corner_bracket(
    n_holes_x, n_holes_y, n_holes_z,
    side_length=default_extrusion_side_length,
    side_plate_th=default_thickness,
    xz_side_plate=true, xy_side_plate=true, yz_side_plate=true,
    th=default_thickness,
    bolt_diameter=m5_hole_tight,
    bolt_hole_offset=default_bolt_hole_offset) {

  _corner(has_z_connection=n_holes_z > 0, th=th) {
    connector(n_holes_x, width=side_length, base_length=side_length, th=th,
        bolt_diameter=bolt_diameter, bolt_hole_offset=bolt_hole_offset);
    connector(n_holes_y, width=side_length, base_length=side_length, th=th,
        bolt_diameter=bolt_diameter, bolt_hole_offset=bolt_hole_offset);
    translate([0,0,-th])
      connector(n_holes_z, width=side_length, base_length=side_length, th=th,
          bolt_diameter=bolt_diameter, bolt_hole_offset=bolt_hole_offset);
  }

  // side plate for stability
  // x,z plates
  if (xz_side_plate && n_holes_x > 0 && n_holes_z > 0)
    for (i = [0,1])
      translate([0,i*(side_length-side_plate_th),side_length])
        rotate([-90,0,0])
        linear_extrude(side_plate_th)
        isosceles_triangle_2D(side_length);

  // x,y plates $children == 2
  if (xy_side_plate && n_holes_x > 1 && n_holes_y > 0)
    translate([side_length, -side_length, 0])
      linear_extrude(side_plate_th)
      isosceles_triangle_2D(side_length);
  // y,z plates $children == 3
  if (yz_side_plate && n_holes_y > 0 && n_holes_z > 0)
    translate([th,-side_length,0])rotate([0,-90,0])
      linear_extrude(side_plate_th)
      isosceles_triangle_2D(side_length);
}


// Internal code below here


module _corner(has_z_connection, th) {
  children(0);
  rotate([0,0,-90])children(1);
  if (has_z_connection)
    rotate([0,-90,0])translate([0,0,0])children(2);
}

module isosceles_triangle_2D(l) {
  intersection(){
    square(l);
    rotate([0,0,45])square(l*2);
  }
}

include <defaults.scad>
