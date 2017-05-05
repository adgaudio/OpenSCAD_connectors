use <connector.scad>

/*
 * Create joints to pull together 2 extrusions at different angles in the
 * xy plane
 *
 * EXAMPLES:
 *
 * I have
 *   - a 4*20mm connector (ie it has 4 screw holes)
 *   - a 3*20mm connector (ie with 3 screw holes)
 * And I want to intersect them at different screw hole positions
 *
 *   tjoint([4,0], [3,0]);
 *   tjoint([4,1], [3,0]);
 *   tjoint([4,2], [3,0]);
 *   tjoint([4,2], [3,1]);
 *
 *   tjoint([5,2], [5,2], 45);  // you can use different angles
 *
 *
 * Parameters:
 *
 *   connector{1,2} - an array in form: [num_screw_holes, intersect_index]
 *       "num_holes" specifies how long to make the connector.
 *       "intersect_index" specifies at which hole on this connector to
 *       intersect the other connector.
 *   angle - the degrees at which these two connectors connect
 *   side_length - how long the side of the extrusion is.
 *       By default, a 2020 extrusion is 20mm on all sides.
 *   th - the thickness of the connector
 *   bolt_diameter - the diameter of the bolt hole.  Set to tight tolerance by default
 *   bolt_hole_offset - number of mm to make the bolt hole wider by.
 *
 *
 */
module tjoint(
    connector1, connector2, angle=90,
    side_length=default_extrusion_side_length,
    th=default_thickness,
    bolt_diameter=m5_hole_tight,
    bolt_hole_offset=default_bolt_hole_offset) {
  // TODO
  // TODO: grid of different objects
  // TODO: demo.scad using grid
  //

  translate([-connector1[1]*side_length-side_length/2,0-side_length/2,0])
    connector(connector1[0], width=side_length, base_length=side_length,
      th=th, bolt_diameter=bolt_diameter, bolt_hole_offset=bolt_hole_offset);

  hyp2 = connector2[1] * 20;
  function X(hyp) = hyp * cos(angle);
  function Y(hyp) = hyp * sin(angle);
  translate([-X(hyp2),-Y(hyp2),0])
  rotate([0,0,angle])translate([-side_length/2,-side_length/2,0])
    connector(connector2[0], width=side_length, base_length=side_length,
      th=th, bolt_diameter=bolt_diameter, bolt_hole_offset=bolt_hole_offset);
}

include <defaults.scad>
