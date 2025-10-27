$fn = 600;

// First parameter - corner radius. It can be less than original one for clearence.
// Second parameter - Radius for lock, it may be greater than original
// Third parameter - length reduction(added to clearence gained by smaller first parameter)
translate([-15, 0, 0]) FrontButton(2.5, 3.6, 0.3);
mirror([1, 0, 0]) translate([-15, 0, 0]) FrontButton(2.5, 3.6, 0.3);

//Jig(2.5, 3.6, 0.3, 30);

// *******************************************************************
// ***   Button Hole   ***********************************************
// *******************************************************************
module FrontButton(DB, DL, LR)
{
  // All parameters from Pendant
  DFG = 2.8;
  D = 3;
  SW = 55.3; // Screen width
  SH = 88.9; // Screen height
  BW = 60; // Board Width
  BL = 126; // Board Length(from center of encoder to top edge)
  ED = BL - BW/2 - SH - (BW - SW)/2;
  W = 60; // Width(encoder & board)
  T = 2.4; // Case thickness
  
  H = 3;
  R = W/2+H+D/2;

  Y1 = (W/2+ED-DFG) - ((W/2+ED-DFG)-28.3)*2 + D/2; // Find symmetrical bottom distance
  X1 = sqrt(abs(Y1*Y1 - R*R));
  X2 = SW/2 - (SW/2-23.4)*2;// + D/2;
  Y2 = sqrt(abs(X2*X2 - R*R));

  skirt_h = 5.4 - 0.8;
  BH = skirt_h + 4.6 + 0.8;
  difference()
  {
    hull()
    {
      translate([X1-0.8, Y1, -0.1]) cylinder(d=DB, h=BH);
      translate([X2, Y2-0.5, -0.1]) cylinder(d=DB, h=BH);
      translate([SW/2-D/2 - LR + 0.3, Y1, -0.1]) cylinder(d=DB, h=BH);
      translate([SW/2-D/2 - LR + 0.3, W/2+ED-DFG-D/2,-0.1]) cylinder(d=DB, h=BH);
      translate([X2, W/2+ED-DFG-D/2, -0.1]) cylinder(d=DB, h=BH);
    }
  }
  difference()
  {
    hull()
    {
      translate([X1 - 1, Y1, -0.1]) cylinder(d=DL, h=skirt_h);
      translate([X2, Y2 - 0.5, -0.1]) cylinder(d=DL, h=skirt_h);
      translate([SW/2-D/2 - LR + 0.5,Y1,-0.1]) cylinder(d=DL, h=skirt_h);
      translate([SW/2-D/2 - LR + 0.5, W/2+ED-DFG-D/2,-0.1]) cylinder(d=DL, h=skirt_h);
      translate([X2,W/2+ED-DFG-D/2,-0.1]) cylinder(d=DL, h=skirt_h);
    }
  }
}

// *******************************************************************
// ***   Button Hole   ***********************************************
// *******************************************************************
module Jig(DB, DL, LR, HEIGHT)
{
  // All parameters from Pendant
  DFG = 2.8;
  D = 3;
  SW = 55.3; // Screen width
  SH = 88.9; // Screen height
  BW = 60; // Board Width
  BL = 126; // Board Length(from center of encoder to top edge)
  ED = BL - BW/2 - SH - (BW - SW)/2;
  W = 60; // Width(encoder & board)
  T = 2.4; // Case thickness
  
  H = 3;
  R = W/2+H+D/2;

  Y1 = (W/2+ED-DFG) - ((W/2+ED-DFG)-28.3)*2 + D/2; // Find symmetrical bottom distance
  X1 = sqrt(abs(Y1*Y1 - R*R));
  X2 = SW/2 - (SW/2-23.4)*2;// + D/2;
  Y2 = sqrt(abs(X2*X2 - R*R));

  difference()
  {
    hull()
    {
      translate([X1,Y1,-0.1]) cylinder(d=DB, h=HEIGHT);
      translate([X2,Y2,-0.1]) cylinder(d=DB, h=HEIGHT);
      translate([SW/2-D/2 - LR,Y1,-0.1]) cylinder(d=DB, h=HEIGHT);
      translate([SW/2-D/2 - LR,W/2+ED-DFG-D/2,-0.1]) cylinder(d=DB, h=HEIGHT);
      translate([X2,W/2+ED-DFG-D/2,-0.1]) cylinder(d=DB, h=HEIGHT);
    }
    translate([0,0,-0.2]) cylinder(d=W+H*2+(D-DB), h=H+0.4);
  }
}