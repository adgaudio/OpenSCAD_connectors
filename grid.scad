/*
 * Arrange many different items in a grid.
 *
 * EXAMPLES:
 *
 *  grid([15, 6]) {
 *    cube([4,5,1]);
 *    cylinder(r=3, h=10);
 *    cube([6,6,5]);
 *    cylinder(r=3, h=5);
 *  }
 *
 *  use <connector.scad>;
 *  grid([30,30]) {
 *    connector(1);
 *    connector(2);
 *    connector(3);
 *  }
 *
 * PARAMETERS:
 *
 * space - a single number or an array specifying distance between children
 *          along x and y axes.
 * center - boolean.  Whether to position center of grid over origin.
 *
 */
module grid(space, center=false) {
  n = ceil(sqrt($children));
  c = center ? 1 : 0;
  spacex = (len(space) == undef) ? space : space[0];
  spacey = (len(space) == undef) ? space : (
      (len(space) == 1) ? space[0] : space[1] );
  for (i=[0:1:n-1], j=[0:1:n-1]) {
    idx = n*i+j;

    if (idx < $children) {
      translate([j*spacex - c*spacex*(n-1)/2, i*spacey - c*spacey*(n-1)/2, 0])
        children(idx);
    }
  }
}
