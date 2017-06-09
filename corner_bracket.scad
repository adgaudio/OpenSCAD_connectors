use <repeat_grid.scad>
use <connector.scad>
use <grid.scad>;

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
 * corner_bracket([3,2], 2, [4,2]);  // also supports 2d connectors
 *
 *
 * PARAMETERS:
 *
 *   n_holes_{x,y,z} - how many screw holes in each respective dimension.
 *       Screw holes are spaced every `side_length` mm
 *       Can be an array or a scalar value, and is passed to connector.scad
 *   side_length - how long the side of the extrusion is.
 *       By default, a 2020 extrusion is 20mm on all sides.
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

  _corner(has_z_connection=n_holes_z > 0 || n_holes_z[0]>0, th=th) {
    connector(n_holes_x, width=side_length, base_length=side_length, th=th,
        bolt_diameter=bolt_diameter, bolt_hole_offset=bolt_hole_offset);
    connector(n_holes_y, width=side_length, base_length=side_length, th=th,
        bolt_diameter=bolt_diameter, bolt_hole_offset=bolt_hole_offset);
    translate([0,0,-th])
      connector(n_holes_z, width=side_length, base_length=side_length, th=th,
          bolt_diameter=bolt_diameter, bolt_hole_offset=bolt_hole_offset);
  }

  function ndim(scalar_or_arr) = len(scalar_or_arr) == undef ? 1 : scalar_or_arr[1];
  function gt(scalar_or_arr, n) = len(scalar_or_arr) == undef ? scalar_or_arr > n : scalar_or_arr[0] > n;

  // side plate for stability
  // x,z plates
  if (xz_side_plate && gt(n_holes_x, 0) && gt(n_holes_z, 0))
    for (i = [0:1:min(ndim(n_holes_x), ndim(n_holes_z))])
      translate([0,i*(side_length-side_plate_th),side_length])
        rotate([-90,0,0])
        linear_extrude(side_plate_th)
        isosceles_triangle_2D(side_length);

  // x,y plates $children == 2
  if (xy_side_plate && gt(n_holes_x, ndim(n_holes_y)) && gt(n_holes_y, 0))
    translate([side_length*ndim(n_holes_y), -side_length, 0])
      linear_extrude(side_plate_th)
      isosceles_triangle_2D(side_length);

  // y,z plates $children == 3
  if (yz_side_plate && gt(n_holes_y, 0) && gt(n_holes_z, 0))
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


// demo:

translate([0,145,0])
  text("corner_bracket(n_holes_x, n_holes_y, n_holes_z, ...);",
      halign="center");
translate([0,35,0])grid([90], center=true) {
  union() {
    translate([0,10,0])text("([3,2],[2,2],[2,2])", size=6);
    text("  bolt_hole_offset=4)", size=6);
  }
  union() {
    translate([0,10,0])text("([1,2],0,[1,2])", size=6);
    text("  bolt_hole_offset=4)", size=6);
  }
  union() {
    translate([0,10,0])text("(2, 2, 2, ", size=6);
    text("  bolt_hole_offset=4)", size=6);
  }
  text("(3, 1, 2)", size=6);
  text("(2, 1, 0)", size=6);
  text("(1, 0, 1)", size=6);
  text("(2, 1, 1)", size=6);
  text("(1, 1, 1)", size=6);

}
grid([90], center=true) {
  translate([0,-20,0])corner_bracket([3,2],[2,2],[2,2],bolt_hole_offset=4);
  translate([0,-20,0])corner_bracket([1,2],0,[1,2], bolt_hole_offset=4);
  corner_bracket(2,2,2, bolt_hole_offset=4);
  corner_bracket(3,1,2);
  corner_bracket(2, 1, 0);
  corner_bracket(1, 0, 1);
  corner_bracket(2, 1, 1);
  corner_bracket(1, 1, 1);
}


include <_defaults.scad>
