/*

descended from <https://www.printables.com/model/318916>
- reworked control flow to provide face indices
- added face label type driven by those

*/

face_depth = 0.05;

// NOTE: when using braille codepoints, need to use a capable font ; this one worked on my windows system:
face_font = "Segoe UI Symbol";
// face_font = "Liberation Sans";

// pentagonal icositetrahedron
function trib(x) = (x <= 3 ? 1 : trib(x-1) + trib(x-2) + trib(x-3) );
tribonacci = trib(18) / trib(17);
rotation = 45 + atan2(1, tribonacci^2);
angle = atan2(( -1 - tribonacci^2), (tribonacci+1)^2);
tilt = atan2(tribonacci - 1, cos(angle) - sin(angle));

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

// labels = [
//     "1", "2", "3", "4",
//     "5", "6.", "7", "8",
//     "9.", "10", "11", "12",
//     "13", "14", "15", "16",
//     "17", "18", "19", "20",
//     "21", "22", "23", "24"
// ];

/* TODO: how best to arrange face labels?

here are notes on point-pairs and edge adjacenies from our natrual 1-24 labeling:

    face : point -- adjacents...

     1 :  3 --  2  4 15 16 22
     2 :  4 --  1  3 15 17 20     
     3 :  1 --  2  4  5  6 20     
     4 :  2 --  1  3  5 22 23     
    
     5 :  7 --  3  4  6  8 23     
     6 :  8 --  3  5  7 19 20      
     7 :  5 --  6  8  9 10 19     
     8 :  6 --  3  5  7 19 20     
    
     9 : 11 --  7  8 10 12 24    
    10 : 12 --  7  9 11 18 19    
    11 :  9 -- 10 12 13 14 18    
    12 : 10 --  9 11 21 13 24    
    
    13 : 15 --  11 12 14 16 21    
    14 : 16 --  11 13 15 17 18    
    15 : 13 --   1  2 14 16 17    
    16 : 14 --   1 13 15 21 22    

    17 : 19 --   2 14 15 18 20
    18 : 20 --  10 11 14 17 19
    19 : 17 --   6  7 10 13 20
    20 : 18 --   2  3  6 17 19

    21 : 23 --  12 13 16 22 24
    22 : 24 --   1  4 16 21 23
    23 : 21 --   4  5  8 22 24
    24 : 22 --   8  9 12 21 23

*/

module face(i) {
    union() {
        cube(6, center=true);
        translate([0, 0, -3 - face_depth]) linear_extrude(height=face_depth) {
            text(labels[i], size = 0.2, font = face_font, halign = "center", valign = "center", $fn = 16);
        }
    }
}

module facet(i) {
    j = 4 * i;
    rotate([0, tilt, rotation + 0]) translate([0, 0, 4]) face(j + 0);
    rotate([0, tilt, rotation + 90]) translate([0, 0, 4]) face(j + 1);
    rotate([0, tilt, rotation + 180]) translate([0, 0, 4]) face(j + 2);
    rotate([0, tilt, rotation + 270]) translate([0, 0, 4]) face(j + 3);
}

module die() {
    difference() {
        cube(3, center=true);
        rotate([0, 0, 0]) facet(0);
        rotate([90, 0, 0]) facet(1);
        rotate([180, 0, 0]) facet(2);
        rotate([270, 0, 0]) facet(3);
        rotate([0, -90, 0]) facet(4);
        rotate([0, 90, 0]) facet(5);
    }
}

// face(24);

rotate([0, 180-tilt, 0]) rotate([0, 0, -rotation]) die();
