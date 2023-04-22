use <octernary.scad>;

pips = [
    "⠂",
    "⠄⠁",
    "⠄⠂⠁",
    "⠌⠡",

    "⠌⠂⠡",
    "⠌⠌⠌",
    "⠌⠇⠡",
    "⠇⠒⠇",

    "⠇⠇⠇",
    "⠇⠭⠇",
    "⠭⠇⠭",
    "⠭⠭⠭",

    "⢎⣙⡱",
    "⢎⣫⡱",
    "⣜⣋⣣",
    "⣜⣫⣣",

    "⢷⣲⡾",
    "⢷⣶⡾",
    "⢷⣷⡾",
    "⢾⣿⡷",

    "⣾⣿⡷",
    "⣾⣿⣷",
    "⣾⣿⣿",
    "⣿⣿⣿"
];

module pip(id) {
    text(pips[id], size = 0.2, font = "Segoe UI Symbol", halign = "center", valign = "center", $fn = 16);
}

module ordinal_label(id) {
    rotate([0, 0, 90])
    text(str(id+1), size = 0.2, font = "Liberation Sans", halign = "center", valign = "center", $fn = 16);
}

module octernary_mark(id) {
    // better pentagon alignment
    scale([1.3, 1.3, 1]) translate([-0.05, -0.05, 0]) rotate([0, 0, 180])

    // center and shrink
    scale([0.5, 0.5, 1]) translate([-0.5, -0.5, 0])

    octernary(id+1);
}

// how deeply label features are stamped into each face
label_depth = 0.05;

label_perm = [
  16, 22, 5, 3,
  19, 21, 6, 0,
  15, 9, 12, 11,
  10, 13, 14, 8,
  23, 17, 2, 4,
  20, 18, 1, 7
];

// each face is defined by a cube with a protruding label feature that will be
// "stamped into" the face of result polyhedra
module face(id) {
    label_id = label_perm[id];
    union() {
        cube(6, center=true);
        translate([0, 0, -3 - label_depth]) #linear_extrude(height=label_depth) {
            // ordinal_label(label_id);
            // pip(label_id);
            octernary_mark(label_id);
        }
    }
}

// pentagonal icositetrahedron
//
// Descended from <https://www.printables.com/model/318916>
//
// See <https://mathworld.wolfram.com/PentagonalIcositetrahedron.html>
// for futher exploration on the the tribonacci constant surprise
function trib(x) = (x <= 3 ? 1 : trib(x-1) + trib(x-2) + trib(x-3) );
tribonacci = trib(18) / trib(17);
rotation = 45 + atan2(1, tribonacci^2);
angle = atan2(( -1 - tribonacci^2), (tribonacci+1)^2);
tilt = atan2(tribonacci - 1, cos(angle) - sin(angle));

// each facet is an arrangement of 4 face cubes, whose south-z faces intersect
// at a 4-vertex of the final icositetrahedron
module facet(id) {
    face_id = 4 * id;
    rotate([0, tilt, rotation +   0]) translate([0, 0, 4]) face(face_id + 0);
    rotate([0, tilt, rotation +  90]) translate([0, 0, 4]) face(face_id + 1);
    rotate([0, tilt, rotation + 180]) translate([0, 0, 4]) face(face_id + 2);
    rotate([0, tilt, rotation + 270]) translate([0, 0, 4]) face(face_id + 3);
}

// the die is formed by 6 facets aligned along each primary cube axis,
// subtracted from a base cube.
module die() {
    difference() {
        cube(3, center=true);
        rotate([  0,   0, 0]) facet(0);
        rotate([ 90,   0, 0]) facet(1);
        rotate([180,   0, 0]) facet(2);
        rotate([270,   0, 0]) facet(3);
        rotate([  0, -90, 0]) facet(4);
        rotate([  0,  90, 0]) facet(5);
    }
}

// this final transformation places face 0 perpendicular to the south-z axis as
// a good default for print orientation
rotate([0, 180-tilt, 0]) rotate([0, 0, -rotation]) die();
