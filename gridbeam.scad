/*********************************
* OpenSCAD GridBeam Library      *
* (c) Timothy Schmidt 2013       *
* http://www.github.com/gridbeam *
* License: LGPL 2.1 or later     *
*********************************/

// To Do:
// integrate option to choose between imperial and metric gridbeam
// integrate option to set beam width
// integrate option to set length (in feet or meter, depending on whether imperial or metric gridbeam ); do this
// by having the script calculate out the required segments by this method: entered length / entered beam_width = number_of_segments
// A command to draw a horizontal gridbeam with 1 inch width and 4,5 feet length gridbeam should become: xBeam imperial 1 4,5
// ------

// A segment starts from 'the middle between 2 holes + the whole itself + the next middle between 2 holes' 
// Consequently, a segment equals the width of the beam (so one, one-and-a-half, or two inch with imperial gridbeam, or 25, 40 or 50 mm with metric grdbeam)

// zBeam(segments) - create a vertical gridbeam strut 'segments' long
// xBeam(segments) - create a horizontal gridbeam strut along the X axis
// yBeam(segments) - create a horizontal gridbeam strut along the Y axis

// To draw a bolt in the gridbeam, use the nuts_and_bolts.scad script or metric_fastners.scad script

include <units.scad>

beam_width = inch * 1.5;
beam_hole_diameter = inch * 5/16;
beam_hole_radius = beam_hole_diameter / 2;
beam_is_hollow = 1;
beam_wall_thickness = inch * 1/8;
beam_shelf_thickness = inch * 1/4;

module zBeam(segments) {
if (mode == "model") {
	difference() {
		cube([beam_width, beam_width, beam_width * segments]);
		for(i = [0 : segments - 1]) {
			translate([beam_width / 2, beam_width + 1, beam_width * i + beam_width / 2])
			rotate([90,0,0])
			cylinder(r=beam_hole_radius, h=beam_width + 2);

			translate([-1, beam_width / 2, beam_width * i + beam_width / 2])
			rotate([0,90,0])
			cylinder(r=beam_hole_radius, h=beam_width + 2);
		}
	if (beam_is_hollow == 1) {
		translate([beam_wall_thickness, beam_wall_thickness, -1])
		cube([beam_width - beam_wall_thickness * 2, beam_width - beam_wall_thickness * 2, beam_width * segments + 2]);
	}
}
}

if (mode == "dxf") {

}
}

module xBeam(segments) {
if (mode == "model") {
	translate([0,0,beam_width])
	rotate([0,90,0])
	zBeam(segments);
}

if (mode == "dxf") {

}
}

module yBeam(segments) {
if (mode == "model") {
	translate([0,0,beam_width])
	rotate([-90,0,0])
	zBeam(segments);
}

if (mode == "dxf") {

}
}

module zBolt(segments) {
if (mode == "model") {

}

if (mode == "dxf") {

}
}

module xBolt(segments) {
if (mode == "model") {
}

if (mode == "dxf") {

}
}

module yBolt(segments) {
if (mode == "model") {
}

if (mode == "dxf") {

}
}

module translateBeam(v) {
	for (i = [0 : $children - 1]) {
		translate(v * beam_width) child(i);
	}
}

module topShelf(width, depth, corners) {
if (mode == "model") {
	difference() {
		cube([width * beam_width, depth * beam_width, beam_shelf_thickness]);

		if (corners == 1) {
		translate([-1,  -1,  -1])
		cube([beam_width + 2, beam_width + 2, beam_shelf_thickness + 2]);
		translate([-1, (depth - 1) * beam_width, -1])
		cube([beam_width + 2, beam_width + 2, beam_shelf_thickness + 2]);
		translate([(width - 1) * beam_width, -1, -1])
		cube([beam_width + 2, beam_width + 2, beam_shelf_thickness + 2]);
		translate([(width - 1) * beam_width, (depth - 1) * beam_width, -1])
		cube([beam_width + 2, beam_width + 2, beam_shelf_thickness + 2]);
		}
	}
}

if (mode == "dxf") {

}
}

module bottomShelf(width, depth, corners) {
if (mode == "model") {
	translate([0,0,-beam_shelf_thickness])
	topShelf(width, depth, corners);
}

if (mode == "dxf") {

}
}

module  backBoard(width, height, corners) {
if (mode == "model") {
	translate([beam_width, 0, 0])
	difference() {
		cube([beam_shelf_thickness, width * beam_width, height * beam_width]);

		if (corners == 1) {
		translate([-1,  -1,  -1])
		cube([beam_shelf_thickness + 2, beam_width + 2, beam_width + 2]);
		translate([-1, -1, (height - 1) * beam_width])
		cube([beam_shelf_thickness + 2, beam_width + 2, beam_width + 2]);
		translate([-1, (width - 1) * beam_width, -1])
		cube([beam_shelf_thickness + 2, beam_width + 2, beam_width + 2]);
		translate([-1, (width - 1) * beam_width, (height - 1) * beam_width])
		cube([beam_shelf_thickness + 2, beam_width + 2, beam_width + 2]);
		}
	}
}

if (mode == "dxf") {

}
}

module frontBoard(width, height, corners) {
if (mode == "model") {
	translate([-beam_width - beam_shelf_thickness, 0, 0])
	backBoard(width, height, corners);
}

if (mode == "dxf") {

}
}
