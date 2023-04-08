// label font and text
label_font = "Segoe UI Symbol";
labels = [
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

// label_font = "Liberation Sans";
// labels = [
//     "1", "2", "3", "4",
//     "5", "6.", "7", "8",
//     "9.", "10", "11", "12",
//     "13", "14", "15", "16",
//     "17", "18", "19", "20",
//     "21", "22", "23", "24"
// ];

module label(i) {
    text(labels[i], size = 0.2, font = label_font, halign = "center", valign = "center", $fn = 16);
}

// how deeply label features are stamped into each face
label_depth = 0.05;

// each face is defined by a cube with a protruding label feature that will be
// "stamped into" the face of result polyhedra
module face(i) {
    union() {
        cube(6, center=true);
        translate([0, 0, -3 - label_depth]) linear_extrude(height=label_depth) label(i);
    }
}

// pentagonal icositetrahedron
//
// descended from <https://www.printables.com/model/318916>
function trib(x) = (x <= 3 ? 1 : trib(x-1) + trib(x-2) + trib(x-3) );
tribonacci = trib(18) / trib(17);
rotation = 45 + atan2(1, tribonacci^2);
angle = atan2(( -1 - tribonacci^2), (tribonacci+1)^2);
tilt = atan2(tribonacci - 1, cos(angle) - sin(angle));

// each facet is an arrangement of 4 face cubes, whose south-z faces intersect
// at a 4-vertex of the final icositetrahedron
module facet(i) {
    j = 4 * i;
    rotate([0, tilt, rotation +   0]) translate([0, 0, 4]) face(j + 0);
    rotate([0, tilt, rotation +  90]) translate([0, 0, 4]) face(j + 1);
    rotate([0, tilt, rotation + 180]) translate([0, 0, 4]) face(j + 2);
    rotate([0, tilt, rotation + 270]) translate([0, 0, 4]) face(j + 3);
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

// this final transformation places face 0 perpendicualr to the south-z axis as
// a good default for print orientation
rotate([0, 180-tilt, 0]) rotate([0, 0, -rotation]) die();
