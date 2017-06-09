/* Generate a many instances of an object along 1, 2 or 3 dimensions
 *
 *
 * EXAMPLE: I want to:
 *   - Create 24 (24=4*3*2) cylinders,
 *     spaced every 5mm along X, every 10mm along y and every 15mm along z
 *
 * use <./PATH/TO/repeat_grid.scad>
 * repeat_grid([4,3,2], [5,10,15]) {
 *   cylinder(r=5/2,h=5);
 * }
 *
 *
 * PARAMETERS:
 *
 * n_times_xyz - an [x,y,z] array containing number of times to repeat object
 *    in each dimension
 * by_length_xyz - an [x,y,z] array of of distance between neighboring objects
 *    along each dimension
 * center - if true, center the grid on the origin
 */
module repeat_grid(n_times_xyz, by_length_xyz, center=false) {
  I = n_times_xyz;
  B = by_length_xyz;
  c = center ? 1 : 0;
  for (x = [0:1:max(I[0]-1, 0)],
      y = [0:1:max(I[1]-1, 0)],
      z = [0:1:max(I[2]-1, 0)]) {
    translate([B[0]*(x - c*max(I[0]-1, 0)/2),
               B[1]*(y - c*max(I[1]-1, 0)/2),
               B[2]*(z - c*max(I[2]-1, 0)/2)])
      children(0);
  }
}


// demo

translate([0,-90,0]) {
  text("repeat_grid([3,2,4], [60,40,20]) {", halign="center");
  translate([-80,-15,0]) {
    text("sphere(r=20);", halign="left");
    translate([-10,-15,0]) {
      text("}", halign="left");
    } } }
repeat_grid([3, 2, 4], [60,40,20], center=true) {
  sphere(r=20);
}
