weight = 3;
width = 100;

foot_bevel = 2;
cross_bevel = 2;
head_bevel = 2;

head_rad = 30;
head_len = 40;

tip_narrow = 0.4;

foot = 40;
mark = 20;
mark_at = 40;

head_base = 2*weight * head_len / head_rad;

points = [

    // 0-3: base line
    [0,  weight],
    [0, -weight],
    [width,  weight],
    [width, -weight],
    // NOTE: 3 and 4 are usually paired with 25 and 24 respectively, not used together

    // 4-5: arrow head bases
    [width - head_base,  weight],
    [width - head_base, -weight],

    // 6-7: footer bases
    [2*weight,  weight],
    [2*weight, -weight],

    // 8-9: top arrow head
    [width - head_len,              head_rad + weight],
    [width - head_len + head_bevel, head_rad - weight],

    // 10-11: bottom arrow head
    [width - head_len,              -head_rad - weight],
    [width - head_len + head_bevel, -head_rad + weight],

    // 12-15: footer
    [0,                      foot],
    [2*weight - foot_bevel,  foot],
    [0,                     -foot],
    [2*weight - foot_bevel, -foot],

    // 16-19: cross mark
    [mark_at - weight + cross_bevel,  mark],
    [mark_at + weight - cross_bevel,  mark],
    [mark_at - weight + cross_bevel, -mark],
    [mark_at + weight - cross_bevel, -mark],

    // 20-23: cross mark bases
    [mark_at - weight,  weight],
    [mark_at - weight, -weight],
    [mark_at + weight,  weight],
    [mark_at + weight, -weight],

    // 24-25: tip
    [width,  weight*tip_narrow],
    [width, -weight*tip_narrow],

];

paths = [

    // 1. base + bottom arrow
    [ 0, 2, 25, 10, 11, 5, 1 ],

    // 2. base + top arrow
    [ 1, 3, 24, 8, 9, 4, 0 ],

    // 3. base + full arrow
    [ 0, 4, 9, 8, 24, 25, 10, 11, 5, 1 ],

    // 4. base + bottom foot + bottom arrow
    [ 0, 2, 25, 10, 11, 5, 7, 15, 14 ],

    // 5. base + bottom foot + top arrow
    [ 14, 15, 7, 3, 24, 8, 9, 4, 0 ],

    // 6. base + bottom foot + full arrow
    [ 0, 4, 9, 8, 24, 25, 10, 11, 5, 7, 15, 14 ],

    // 7. base + top foot + bottom arrow
    [ 12, 13, 6, 2, 25, 10, 11, 5, 1 ],

    // 8. base + top foot + top arrow
    [ 1, 3, 24, 8, 9, 4, 6, 13, 12 ],

    // 9. base + top foot + full arrow
    [ 12, 13, 6, 4, 9, 8, 24, 25, 10, 11, 5, 1 ],

    // 10. base + full foot + bottom arrow
    [ 12, 13, 6, 2, 25, 10, 11, 5, 7, 15, 14 ],

    // 11. base + top arrow
    [ 14, 15, 7, 3, 24, 8, 9, 4, 6, 13, 12 ],

    // 12. base + full arrow
    [ 12, 13, 6, 4, 9, 8, 24, 25, 10, 11, 5, 7, 15, 14 ],

    // 13. base + cross mark + bottom arrow
    [ 0, 20, 16, 17, 22, 2, 25, 10, 11, 5, 23, 19, 18, 21, 1 ],

    // 14. base + cross mark + top arrow
    [ 1, 21, 18, 19, 23, 3, 24, 8, 9, 4, 22, 17, 16, 20, 0 ],

    // 15. base + cross mark + full arrow
    [ 0, 20, 16, 17, 22, 4, 9, 8, 24, 25, 10, 11, 5, 23, 19, 18, 21, 1 ],

    // 16. base + cross mark + bottom foot + bottom arrow
    [ 0, 20, 16, 17, 22, 2, 25, 10, 11, 5, 23, 19, 18, 21, 7, 15, 14 ],

    // 17. base + cross mark + bottom foot + top arrow
    [ 14, 15, 7, 21, 18, 19, 23, 3, 24, 8, 9, 4, 22, 17, 16, 20, 0 ],

    // 18. base + cross mark + bottom foot + full arrow
    [ 0, 20, 16, 17, 22, 4, 9, 8, 24, 25, 10, 11, 5, 23, 19, 18, 21, 7, 15, 14 ],

    // 19. base + cross mark + top foot + bottom arrow
    [ 12, 13, 6, 20, 16, 17, 22, 2, 25, 10, 11, 5, 23, 19, 18, 21, 1 ],

    // 20. base + cross mark + top foot + top arrow
    [ 1, 21, 18, 19, 23, 3, 24, 8, 9, 4, 22, 17, 16, 20, 6, 13, 12 ],

    // 21. base + cross mark + top foot + full arrow
    [ 12, 13, 6, 20, 16, 17, 22, 4, 9, 8, 24, 25, 10, 11, 5, 23, 19, 18, 21, 1 ],

    // 22. base + cross mark + full foot + bottom arrow
    [ 12, 13, 6, 20, 16, 17, 22, 2, 25, 10, 11, 5, 23, 19, 18, 21, 7, 15, 14 ],

    // 23. base + cross mark + top arrow
    [ 14, 15, 7, 21, 18, 19, 23, 3, 24, 8, 9, 4, 22, 17, 16, 20, 6, 13, 12 ],

    // 24. base + cross mark + full arrow
    [ 12, 13, 6, 20, 16, 17, 22, 4, 9, 8, 24, 25, 10, 11, 5, 23, 19, 18, 21, 7, 15, 14 ],

];

module octernary(n) {
    h = max(foot, head_rad + weight);
    max_dim = max(width, 2*h);

    scale([1/max_dim, 1/max_dim, 1])
    translate([0, h, 0])
    polygon(points, paths=[paths[n-1]]);
}

ch = 1.0;
cw = 1.5;

translate([0, 7*ch, 0]) {
    translate([   0, 0, 0]) octernary(1);
    translate([  cw, 0, 0]) octernary(2);
    translate([2*cw, 0, 0]) octernary(3);
};

translate([0, 6*ch, 0]) {
    translate([   0, 0, 0]) octernary(4);
    translate([  cw, 0, 0]) octernary(5);
    translate([2*cw, 0, 0]) octernary(6);
};

translate([0, 5*ch, 0]) {
    translate([   0, 0, 0]) octernary(7);
    translate([  cw, 0, 0]) octernary(8);
    translate([2*cw, 0, 0]) octernary(9);
};

translate([0, 4*ch, 0]) {
    translate([   0, 0, 0]) octernary(10);
    translate([  cw, 0, 0]) octernary(11);
    translate([2*cw, 0, 0]) octernary(12);
};

translate([0, 3*ch, 0]) {
    translate([   0, 0, 0]) octernary(13);
    translate([  cw, 0, 0]) octernary(14);
    translate([2*cw, 0, 0]) octernary(15);
};

translate([0, 2*ch, 0]) {
    translate([   0, 0, 0]) octernary(16);
    translate([  cw, 0, 0]) octernary(17);
    translate([2*cw, 0, 0]) octernary(18);
};

translate([0, ch, 0]) {
    translate([   0, 0, 0]) octernary(19);
    translate([  cw, 0, 0]) octernary(20);
    translate([2*cw, 0, 0]) octernary(21);
};

translate([0, 0, 0]) {
    translate([   0, 0, 0]) octernary(22);
    translate([  cw, 0, 0]) octernary(23);
    translate([2*cw, 0, 0]) octernary(24);
};
