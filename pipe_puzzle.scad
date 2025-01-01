// Define the parameters for the pipe
pipe_radius = 3;
segment_length = 10;
bend_radius = 10; // Include extra room for the bend itself

// Define a module for the straight segments
module straight_segment(length, pipe_radius) {
    cylinder(h=length, r=pipe_radius, center=false, $fn=50);
}

// Define a module for the quarter-torus
module quarter_torus(bend_radius, pipe_radius) {
    rotate([90, 0, 0]) // Rotate to start bending upwards
    translate([bend_radius, 0, 0])
    rotate_extrude(angle=90, $fn=50)
    translate([bend_radius, 0, 0])
    circle(r=pipe_radius, $fn=50);
}

// Assemble the pipe with bends and straight segments
module bend(pipe_radius, segment_length, bend_radius) {
union() {
    // First segment
    straight_segment(segment_length, pipe_radius);
    
    // First bend
    translate([-2*bend_radius, 0, segment_length])
    quarter_torus(bend_radius, pipe_radius);

    // Second segment
    translate([-bend_radius-segment_length, 0, segment_length + bend_radius ])
    rotate([0, 90, 0])
    straight_segment(segment_length, pipe_radius);

    }
}

// Santorini Game Base with Edges and Configurable Size
n = 4; // Number of squares per side (set to 1 for test print)
square_size = 40; // Size of each square in mm
board_size = n * square_size; // Total board size
thickness = 2; // Base thickness in mm
ridge_height = 4; // Ridge height in mm
ridge_width = 1; // Ridge width in mm

module square_tile() {
    // Base square
    cube([square_size-4*pipe_radius, square_size-4*pipe_radius, thickness+2*pipe_radius], center = false);
    // Top ridge (left and bottom sides)
    //translate([0, 0, thickness])
        //cube([square_size, ridge_width, ridge_height], center = false); // Bottom ridge
    //translate([0, 0, thickness])
        //cube([ridge_width, square_size, ridge_height], center = false); // Left ridge
}

module edge() {
    // Add edges to complete the board (on the right and top)
    // Right edge
    translate([board_size - ridge_width, 0-4*pipe_radius, thickness])
        cube([ridge_width, board_size+4*pipe_radius, ridge_height], center = false);
    translate([-4*pipe_radius, -4*pipe_radius, thickness])
        cube([ridge_width, board_size+4*pipe_radius, ridge_height], center = false);
    // Top edge
    translate([-4*pipe_radius, board_size - ridge_width, thickness])
        cube([board_size+4*pipe_radius, ridge_width, ridge_height], center = false);
    translate([-4*pipe_radius, -4*pipe_radius, thickness])
        cube([board_size+4*pipe_radius, ridge_width, ridge_height], center = false);
}

module board() {
    // Generate the grid of square tiles
    for (x = [0:n-1]) {
        for (y = [0:n-1]) {
            translate([x * square_size, y * square_size, 0])
                square_tile();
        }
    }
    
    translate([-4*pipe_radius, -4*pipe_radius, 0])
    cube([board_size+2*pipe_radius*2, board_size+2*pipe_radius*2, thickness], center = false);

    edge(); // Add edges after tiles
}



module pieceP() {
union() {

rotate([0,180,0])
translate([segment_length*2 + 2*bend_radius,0,0])
bend(pipe_radius,segment_length,bend_radius);

rotate([0,0,180])
translate([segment_length*2 + 2*bend_radius,0,0])
bend(pipe_radius,segment_length,bend_radius);

bend(pipe_radius,segment_length,bend_radius);
    
 translate([0,0,-segment_length*2])
 straight_segment(segment_length*2, pipe_radius);
    
 rotate([90,0,90])
 translate([0,-segment_length - bend_radius,-2*segment_length])
 straight_segment(segment_length*5.5, pipe_radius);

    
    
}
}

module pieceG() {
union() {

rotate([0,180,0])
translate([segment_length*2 + 2*bend_radius,0,0])
bend(pipe_radius,segment_length,bend_radius);

rotate([0,0,180])
translate([segment_length*2 + 2*bend_radius,0,0])
bend(pipe_radius,segment_length,bend_radius);

rotate([0,180,180])
translate([segment_length*2 + 2*bend_radius,0,0])
bend(pipe_radius,segment_length,bend_radius);

rotate([0,0,90])
 translate([0,-2*segment_length -2*bend_radius,0*segment_length])
 straight_segment(segment_length+pipe_radius, pipe_radius);

    
 rotate([90,0,90])
 translate([0,-segment_length - bend_radius,-2*segment_length])
 straight_segment(segment_length*5, pipe_radius);

 rotate([90,0,90])
 translate([0,+segment_length + bend_radius,-2*segment_length])
 straight_segment(segment_length+pipe_radius, pipe_radius);

    
    
}
}

module pieceL() {
union() {

rotate([0,180,0])
translate([segment_length*2 + 2*bend_radius,0,0])
bend(pipe_radius,segment_length,bend_radius);

    
 rotate([90,0,90])
 translate([0,-segment_length - bend_radius,-2*segment_length])
 straight_segment(segment_length*5.5, pipe_radius);  
    
 rotate([0,0,90])
 translate([0,+2*segment_length +2* bend_radius,-0*segment_length])
 straight_segment(segment_length*9.5, pipe_radius);

 

    
    
}
}
module pieceC() {
union() {

rotate([0,180,0])
translate([segment_length*2 + 2*bend_radius,0,0])
bend(pipe_radius,segment_length,bend_radius);
    
rotate([0,-90,0])
translate([segment_length*5 + 5*bend_radius,0,segment_length*1 + 1*bend_radius])
bend(pipe_radius,segment_length,bend_radius);

    
 rotate([90,0,90])
 translate([0,-segment_length - bend_radius,-2*segment_length])
 straight_segment(segment_length+pipe_radius, pipe_radius);  
    
 rotate([90,0,90])
 translate([0,+5*segment_length + 5*bend_radius,-2*segment_length])
 straight_segment(segment_length+pipe_radius, pipe_radius);  
    
 rotate([0,0,90])
 translate([0,+2*segment_length +2* bend_radius,-0*segment_length])
 straight_segment(segment_length*8, pipe_radius);

 

    
    
}
}


module pieceS() {
union() {
    
    rotate([0,0,90])
 translate([0,0,-segment_length])
 straight_segment(segment_length+pipe_radius, pipe_radius);

    rotate([0,0,90])
 translate([0,8*segment_length,0])
 straight_segment(segment_length+pipe_radius, pipe_radius);


rotate([0,180,0])
translate([+segment_length*4 + 4*bend_radius,0,0])
bend(pipe_radius,segment_length,bend_radius);

rotate([0,180,180])
translate([-segment_length*2 - 2*bend_radius,0,0])
bend(pipe_radius,segment_length,bend_radius);

rotate([0,0,180])
translate([segment_length*2 + 2*bend_radius,0,0])
bend(pipe_radius,segment_length,bend_radius);

bend(pipe_radius,segment_length,bend_radius);
    


    
    
}
}
module pieceU() {
union() {
    
    rotate([90,0,90])
 translate([0,+segment_length + bend_radius,-2*segment_length])
 straight_segment(segment_length+pipe_radius, pipe_radius);

    rotate([90,0,90])
 translate([0,+segment_length + bend_radius,-11*segment_length])
 straight_segment(segment_length+pipe_radius, pipe_radius);

translate([-segment_length*4 - 4*bend_radius,0,0])
bend(pipe_radius,segment_length,bend_radius);


rotate([0,180,0])
translate([+segment_length*4 + 4*bend_radius,0,0])
bend(pipe_radius,segment_length,bend_radius);

rotate([0,180,180])
translate([-segment_length*2 - 2*bend_radius,0,0])
bend(pipe_radius,segment_length,bend_radius);

rotate([0,0,180])
translate([segment_length*2 + 2*bend_radius,0,0])
bend(pipe_radius,segment_length,bend_radius);

    


    
    
}
}

module pieceY() {
union() {
    
rotate([0,0,0])
 translate([-segment_length*2 - 2*bend_radius,0,-0*segment_length])
 straight_segment(1.5*segment_length, pipe_radius);
    
rotate([0,0,0])
 translate([-segment_length*6 - 6*bend_radius,0,4*segment_length])
 straight_segment(1.5*segment_length, pipe_radius);

translate([-segment_length*4 - 4*bend_radius,0,0])
bend(pipe_radius,segment_length,bend_radius);


rotate([0,180,0])
translate([+segment_length*4 + 4*bend_radius,0,0])
bend(pipe_radius,segment_length,bend_radius);

rotate([0,180,180])
translate([-segment_length*2 - 2*bend_radius,0,0])
bend(pipe_radius,segment_length,bend_radius);

rotate([0,180,0])
translate([segment_length*6 + 6*bend_radius,0,-segment_length*2 - 2*bend_radius])
bend(pipe_radius,segment_length,bend_radius);

    


    
    
}
}

module pieceW() {
union() {
    
rotate([0,0,0])
 translate([-segment_length*2 - 2*bend_radius,0,-5.5*segment_length])
 straight_segment(1.5*segment_length, pipe_radius);
    
rotate([0,0,0])
 translate([-segment_length*6 - 6*bend_radius,0,4*segment_length])
 straight_segment(1.5*segment_length, pipe_radius);

translate([-segment_length*4 - 4*bend_radius,0,0])
bend(pipe_radius,segment_length,bend_radius);


rotate([0,180,0])
translate([+segment_length*4 + 4*bend_radius,0,0])
bend(pipe_radius,segment_length,bend_radius);

rotate([0,0,0])
translate([-segment_length*2 - 2*bend_radius,0,-segment_length*2 - 2*bend_radius])
bend(pipe_radius,segment_length,bend_radius);

rotate([0,180,0])
translate([segment_length*6 + 6*bend_radius,0,-segment_length*2 - 2*bend_radius])
bend(pipe_radius,segment_length,bend_radius);

    


    
    
}
}

pieceP();
pieceW();
translate([0,20,0])
pieceG();
translate([0,40,0])
pieceC();
translate([0,60,0])
pieceY();
translate([0,80,0])
pieceS();
translate([0,100,0])
pieceL();
translate([0,120,0])
pieceU();

translate([60,0,0])
board();

