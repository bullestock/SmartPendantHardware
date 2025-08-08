//$fn=600;
$fn=60; // draft

//import("OBJ_PCB_Smart_Pendant.stl");

// Disable parts for fast update during development
FOR_PRINT = 1;
DRAW_BUTTON_HOLES = 1;
DEBUG_PORT = 0;

T = 2.4; // Case thickness
R = 2.6; // Case radius
W = 60; // Width(encoder & board)
L = 156+R*2; // Length(full length + two radiuses)
H = 20;

// Encoder tolerance
ENC_T = 0.4;

// Encoder rim height
ENC_RT = 6;

ENC_OFFSET = -5;
STANDOFF_C = 6;
BUTTON_OFFSET = -3;

BW = 60; // Board Width
BL = 126; // Board Length(from center of encoder to top edge)
BT = 1.6 + 2; // Board thickness
BZPOS = 4.4; // Board Z position if placed on table display face down

SW = 55.5; // Screen width
SH = 89.0; // Screen height
//SH = 88.8; // old
BZW = 51.5; // Bezel width
BZH = 78.0; // Bezel height
// DBL = 96; // Display Board Length

GLAND_W = 5.5;
GLAND_H = 5;

//ED = 4.2; // Distance betweeen encoder edge and screen glass
ED = BL - BW/2 - SH - (BW - SW)/2;

CP = 102.5; // MicroSD card placement

BOTTOM_H = 4; // Height of bottom piece
LOCK_H = 1.6; // Lock height


Top();
//Bottom();
//translate([75,0,0]) Bottom();
//translate([0, 0, H+BOTTOM_H]) rotate([0, 180, 0]) Bottom();

//Board();

// *******************************************************************
// ***   PCB   *******************************************************
// *******************************************************************
module PCB(H)
{
  color("purple") difference()
  {
    translate([0,0, BZPOS]) linear_extrude(height=H)
      polygon(points=[[-30,0],[-30,65],[-28.6,67.5],[-28.6,94],[-30,96.5],[-30,126],
                      [30,126],[30,96.5],[28.6,94],[28.6,67.5],[30,65],[30,0]]);
    translate([0,0,0]) cylinder(d=43, h=H);
  }
}

// *******************************************************************
// ***   Board   *****************************************************
// *******************************************************************
module Board()
{
  PCB(BT);
  translate([-57.2/2,73.2, BZPOS+BT+4]) rotate([0, 90, 0]) cylinder(d=3.5, h=57.2); // Down buttons
  translate([-57.2/2,88.3, BZPOS+BT+4]) rotate([0, 90, 0]) cylinder(d=3.5, h=57.2); // Up buttons
  // Top button
  translate([23.5,120,0])
  {
    color("black") translate([0,0.1, BZPOS+BT+4]) rotate([-90,0,0]) cylinder(d=3.5, h=5); // Up buttons
    color("silver") translate([-6.2/2,0, BZPOS+BT]) cube([6.2,4,6.2]);
  }
  // Face L buttons
  translate([23.4,28.3,0])
  {
    color("gold") translate([0,0, BZPOS-1.8]) cylinder(d=2, h=1.8); // Up buttons
    color("silver") translate([-5.08/2,-5.08/2, BZPOS-1.4]) cube([5.08,5.08,1.4]);
  }
  // Face R buttons
  translate([-23.5,28.4,0])
  {
    color("gold") translate([0,0, BZPOS-1.8]) cylinder(d=2, h=1.8); // Up buttons
    color("silver") translate([-5.08/2,-5.08/2, BZPOS-1.4]) cube([5.08,5.08,1.4]);
  }
}

// *******************************************************************
// ***   SideButtonRing   ********************************************
// *******************************************************************
module SideButtonRing(DO, DI, L, H)
{
  difference()
  {
    hull()
    {
      translate([-H/2,-L/2,0]) rotate([0, 90, 0]) cylinder(d=DO, h=H); // Up buttons
      translate([-H/2,+L/2,0]) rotate([0, 90, 0]) cylinder(d=DO, h=H); // Up buttons
    }
    hull()
    {
      translate([-H/2-1,-L/2,0]) rotate([0, 90, 0]) cylinder(d=DI, h=H+2); // Up buttons
      translate([-H/2-1,+L/2,0]) rotate([0, 90, 0]) cylinder(d=DI, h=H+2); // Up buttons
    }
  }
}

// *******************************************************************
// ***   Rotate functions   ******************************************
// *******************************************************************
function RotateX(X, Y, A) = X*cos(A) + Y*sin(A);
function RotateY(X, Y, A) = X*sin(A) + Y*cos(A);

// *******************************************************************
// ***   Button Hole   ***********************************************
// *******************************************************************
module ButtonHole(DFG, D)
{
    // Left button hole
    difference()
    {
        H = 3;
        R = W/2+H+D/2;

        BUTTON_LEN = 4.2;

        Y1 = (W/2+BUTTON_LEN-DFG) - ((W/2+BUTTON_LEN-DFG)-28.3)*2 + D/2; // Find symmetrical bottom distance
        X1 = sqrt(abs(Y1*Y1 - R*R));
        X2 = SW/2 - (SW/2-23.4)*2;// + D/2;
        Y2 = sqrt(abs(X2*X2 - R*R));
        
        hull()
        {
            // slanted corners
            translate([X1, Y1, -0.1]) cylinder(d=D, h=20);
            translate([X2, Y2, -0.1]) cylinder(d=D, h=20);
            // top right angle corner
            translate([SW/2-D/2, Y1, -0.1]) cylinder(d=D, h=20);
            // bottom corners
            translate([SW/2-D/2, W/2+BUTTON_LEN-DFG-D/2 + 0.8, -0.1]) cylinder(d=D, h=20);
            translate([X2, W/2+BUTTON_LEN-DFG-D/2 + 0.8, -0.1]) cylinder(d=D, h=20);
        }
        translate([0,0,-0.2]) cylinder(d=W+H*2, h=20);
    }
}

// *******************************************************************
// ***   Top module   ************************************************
// *******************************************************************
module Top()
{
  difference() {
    union() {
      difference()
      {
        // half torus to support encoder
        translate([0, ENC_OFFSET, ENC_RT]) cylinder(d=W+ENC_T, h=3);
        translate([0, ENC_OFFSET, 2]) cylinder(d=43+ENC_T, h=BZPOS+5);
        translate([-80/2, ENC_OFFSET + 5, -1]) cube([80, 40, H+T*2+1]);
      }
      // Case shell
      difference()
      {
        union()
        {
          difference()
          {
            // Case profile
            Case(W+R*2, L - ENC_OFFSET, H, R);
            // Make shell
            translate([0, 0, T]) Case(W+R*2-T*2, L - T*2 - ENC_OFFSET, H, R-T);
          }
          // Central support (between encoder and display hole)
          translate([-16-3*ED, W/2+ED/2 - 14.5, 0]) cube([3*ED, 15, BZPOS]);
          translate([16, W/2+ED/2 - 14.5, 0]) cube([3*ED, 15, BZPOS]);
          //translate([-BW/2-(R-T), W/2+ED-1.2, T]) cube([W+(R-T)*2, 1.2, BZPOS-T-0.6]);
          // PCB side support
          translate([-BW/2-(R-T), W/2+ED/2, T]) cube([2+(R-T), BL-W/2-ED, BZPOS-T]);
          translate([BW/2-2, W/2+ED/2, T]) cube([2+(R-T), BL-W/2-ED, BZPOS-T]);
          translate([-BW/2-(R-T), 2*W, T]) cube([2+(R-T), 5, H-T-11]);
          translate([BW/2-2, 2*W, T]) cube([2+(R-T), 5, H-T-11]);
          // Display support
          translate([-BW/2, BL-5, T]) cube([BW, 2+(R-T), 2]);
        }
        // Screw holes
        // - top button
        translate([BW/2-13-6, BL+R-0.4, BZPOS+BT+(H-BZPOS-BT)/2]) rotate([90, 0, 0]) ScrewHoleUp(15);
        // - USB
        translate([-BW/2+13+6/2, BL+R-0.4, BZPOS+BT+(H-BZPOS-BT)/2]) rotate([90, 0, 0]) ScrewHoleUp(15);
        // - left
        translate([-W/2-R+0.4, 55.8, BZPOS+BT+(H-BZPOS-BT)/2]) rotate([0, 90, 0]) ScrewHoleUp(15);
        // - right
        translate([W/2+R-0.4, 55.8, BZPOS+BT+(H-BZPOS-BT)/2]) rotate([0, -90, 0]) ScrewHoleUp(15);
        // Encoder hole
        translate([0, ENC_OFFSET, -1]) cylinder(d=W+ENC_T, h=H);
        // Display
        translate([-SW/2, ED+W/2 - 4, -1]) cube([SW, SH, H]);
        //translate([-SW/2, BL-6, 1.4]) cube([SW, 6, H]);
        // Down side buttons
        hull()
        {
          translate([-50, 73.2-2, BZPOS+BT+6]) rotate([0, 90, 0]) cylinder(d=6, h=100);
          translate([-50, 73.2+2, BZPOS+BT+6]) rotate([0, 90, 0]) cylinder(d=6, h=100);
        }
        // Up side buttons
        hull()
        {
          translate([-50, 88.3-2, BZPOS+BT+6]) rotate([0, 90, 0]) cylinder(d=6, h=100);
          translate([-50, 88.3+2, BZPOS+BT+6]) rotate([0, 90, 0]) cylinder(d=6, h=100);
        }
        // Top button
        hull()
        {
          translate([20.5-2, 120, BZPOS+BT+6]) rotate([-90,0,0]) cylinder(d=6, h=300);
          translate([20.5+2, 120, BZPOS+BT+6]) rotate([-90,0,0]) cylinder(d=6, h=30);
        }
        // SD Card cutout
        translate([-W, CP, BZPOS+BT+1.8]) cube([W, 12, 1.8]);
        if(DEBUG_PORT)
        {
          // Debug port cutout(full port)
          //#translate([W/2-9,CP, BZPOS+BT]) cube([13,20,9]);
          // Debug port cutout(connector only)
          translate([W/2-9,106.3-18.2/2, BZPOS+BT+1.2]) cube([15,18.2,8.4]);
          //translate([W/2-9,106.3-4.8/2, BZPOS+BT+1.2+6.4]) cube([15,4.8,0.6]);
        }
        // USB-C 
        translate([0, BL, BZPOS+BT+6-2.7/2-0.4])
        {
          // Connector hole
          translate([0,-1,0]) rotate([-90,0,0]) hull()
          {
            translate([-8.4/2+2.5/2,0,0]) cylinder(d=2.7, h=17);
            translate([+8.4/2-2.5/2,0,0]) cylinder(d=2.7, h=17);
          }
          // Connector place
          translate([0,1.6+0.2,0]) rotate([-90,0,0]) hull()
          {
            translate([-8.4/2+2.5/2,0,0]) cylinder(d=7, h=17);
            translate([+8.4/2-2.5/2,0,0]) cylinder(d=7, h=17);
          }
        }
        // Cable hole
        translate([-BW/2+(13-8)/2, BL-2, H-GLAND_H-1.5]) cube([GLAND_W, 10, H]);
        translate([-BW/2+0.25, BL, H-GLAND_H-1.5]) cube([10, 1, H]);
        //translate([-W/4,BL-20,6+3]) rotate([-90,0,0]) cylinder(d=3.5, h=100);
      }
      // Encoder
      difference()
      {
        // PCB support
        translate([-(W+R*2-T*2)/2, 0, T]) cube([W+R*2-T*2, W/2, H-T-11]);
        // Cutout for encoder rim
        translate([0, ENC_OFFSET, 0]) cylinder(d=W+ENC_T, h=BZPOS);
        // Cutout for encoder terminals
        translate([0, ENC_OFFSET, 0]) cylinder(d=43+ENC_T, h=H);
        // Board holder near encoder
        difference()
        {
          translate([0, 0, 0]) cylinder(d=W+ENC_T, h=H);
          translate([-80/2, -40, -1]) cube([80, 40, H+T*2+1]);
        }
        // Cutout for front buttons
        translate([-80/2, 18, -5]) cube([80, 40, H+T*2+1]);
      }
    }
    // Encoder screw hole
    translate([0, -50.5/2 + ENC_OFFSET, 0]) cylinder(d=3.5, h=H);
    // Right front button hole
    translate([0, -5, 0]) ButtonHole(2.8, 2.2);
    // Left button hole
    translate([0, -5, 0]) mirror([1,0,0]) ButtonHole(2.8, 2.2);
  }
}

// *******************************************************************
// ***   Bottom module   *********************************************
// *******************************************************************
module Bottom()
{
  difference()
  {
    union()
    {
      // Case shell
      difference()
      {
        union()
        {
          Case(W+R*2, L - ENC_OFFSET, BOTTOM_H, R);
          translate([0, 0, LOCK_H]) Case(W+R*2-T*2-0.4, L - ENC_OFFSET - T*2 - 0.2, BOTTOM_H, R-T);
        }
        translate([0, 2.5, T])  Case(W+R*2-T*3, L-T*3, BOTTOM_H+T, R-T);
        // Gland cutout
        translate([17, L-W/2-13.2, T+1.6]) cube([12, 6, 5]);
      }
    }
    // Debug port cutout(connector only)
    translate([-W/2-T-1,106.3-22/2,BOTTOM_H]) cube([15,22,8.4]);
    // Button holes
    translate([0, 90.5, -1]) 
    {
      // RESET/BOOT
      translate([+2.325, -15,0]) cylinder(d=3, h=10);
      translate([-2.325, -15,0]) cylinder(d=3, h=10);
      //translate([+2.325,-40.7,0]) cylinder(d=3, h=10);
      // LEDs
      //translate([+5,-41.7,0]) cylinder(d=1.5, h=10);
      //translate([-5,-41.7,0]) cylinder(d=1.5, h=10);
    }
    // Recess for encoder
    translate([0,0,1.2]) hull()
    {
      cylinder(d=44, h=10);
      translate([-(44-5)/2,W/2,0]) cylinder(d=5, h=10);
      translate([+(44-5)/2,W/2,0]) cylinder(d=5, h=10);
    }
    // Recess
    translate([0,0,1.2]) hull()
    {
      translate([-(44-5)/2,70,0]) cylinder(d=5, h=10);
      translate([+(44-5)/2,70,0]) cylinder(d=5, h=10);
      translate([-(44-5)/2,BL-12,0]) cylinder(d=5, h=10);
      translate([+(44-5)/2,BL-12,0]) cylinder(d=5, h=10);
    }
    // Nut hole
    //translate([0,-50.5/2,-1]) cylinder(d=3.2, h=100);
    translate([0, -50.5/2 + ENC_OFFSET, -1]) cylinder(d=8, h=BZPOS+6+1);
    //translate([0,-50.5/2,0]) cylinder(d=7.7, h=H);
  }
  // Debug port cutout(connector only)
  translate([-W/2,106.3-26/2,1.2]) cube([8,26,BOTTOM_H-1.2]);
  //translate([-W/2-R,106.3-26/2,BOTTOM_H]) cube([T,26,1.2]);
  // Standoff for encoder
  difference()
  {
    // Basic standoff shape
    translate([0,-50.5/2 + ENC_OFFSET, 0]) cylinder(d=11.2, h=BOTTOM_H+H-(T+BZPOS) - STANDOFF_C);
    // Screw hole
    translate([0, -50.5/2 + ENC_OFFSET, 0]) cylinder(d=3.2, h=100);
    // Cut off part of top
    translate([0, ENC_OFFSET, BOTTOM_H+H-(BZPOS+6)-1 - STANDOFF_C]) cylinder(d=43, h=H - STANDOFF_C);
    translate([0, -50.5/2 + ENC_OFFSET, -1]) cylinder(d=8, h=BOTTOM_H+H-(BZPOS+6)+1+1 - STANDOFF_C);
    // Cut off bottom
    difference()
    {
      translate([0, ENC_OFFSET, -1]) cylinder(d=W+2*R, h=H - STANDOFF_C);
      translate([0, ENC_OFFSET, -1]) cylinder(d=W, h=H - STANDOFF_C);
    }
  }
  // Top locks
  difference()
  {
    translate([BW/2-6-13,BL-3.5,0]) cube([6, 3.5+(R-T), BOTTOM_H + 11 - 1.25]);
    translate([BW/2-6-13+6/2, 0, BOTTOM_H+(H-BZPOS-BT)/2]) rotate([-90, 0, 0]) cylinder(d=2.6, h=200);
  }
  difference()
  {
    translate([-BW/2+16, BL-3.5, 0]) cube([6, 3.5+(R-T), BOTTOM_H + 11 - 1.25]);
    translate([-BW/2+16+6/2, 0, BOTTOM_H+(H-BZPOS-BT)/2]) rotate([-90, 0, 0]) cylinder(d=2.6, h=200);
  }
  // Middle locks
  difference()
  {
    union()
    {
      translate([-BW/2,55.8-6/2,0]) cube([3.5,6,BOTTOM_H + 11 - 1.25]);
      difference()
      {
        translate([BW/2-3.5, 55.8-6/2, 0]) cube([3.5, 6, BOTTOM_H + 11 - 1.25]);
        //translate([BW/2-3.5-2, 55.8-7/2, BOTTOM_H+H-BZPOS-BT-2]) cube([3.5, 7, BOTTOM_H+H-BZPOS-BT]);
      }
    }
    translate([-100, 55.8, BOTTOM_H+(H-BZPOS-BT)/2]) rotate([0, 90, 0]) cylinder(d=2.6, h=200);
  }
}

// *******************************************************************
// ***   Case module   ***********************************************
// *******************************************************************
module Case(W, L, H, R)
difference()
{
  translate([0, ENC_OFFSET, R]) minkowski()
  {
    hull()
    {
      translate([-W/2+R, L-W/2-R-10, 0]) cube([W-R*2, 10, H-R]);
      cylinder(d=W-R*2, h=H-R);
    }
    sphere(r=R);
  }
  // Make top flat
  translate([-W/2, -W/2 + ENC_OFFSET, H]) cube([W, L, H]);
}

// *******************************************************************
// ***   Case module   ***********************************************
// *******************************************************************
module CubeR(W, L, H, R)
{
  hull()
  {
    translate([W/2,L/2,0]) cylinder(d=R, h=H);
    translate([-W/2,L/2,0]) cylinder(d=R, h=H);
    translate([W/2,-L/2,0]) cylinder(d=R, h=H);
    translate([-W/2,-L/2,0]) cylinder(d=R, h=H);
  }
}

module ScrewHole(h)
{
 translate([0,0,-1]) cylinder(d=3, h = h+2);
 translate([0,0,h-2.4]) cylinder(d2=6, d1=3, h = 2);
 translate([0,0,h-0.401]) cylinder(d=6, h = h);
}

module ScrewHoleUp(h)
{
 translate([0,0,2-0.001]) cylinder(d=3, h = h+2);
 translate([0,0,0]) cylinder(d2=3, d1=6, h = 2);
 translate([0,0,-h+0.001]) cylinder(d=6, h = h);
}
