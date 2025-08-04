$fn = 300;

SideButton(9.7, 5.6, 6.5); // 1
//SideButton(9, 5.4, 6.5); // 2

//Jig(9.2, 5.6, 6.5, 30);

// *******************************************************************
// ***   SideButton module   *****************************************
// *******************************************************************
module SideButton(L, DB, DL)
{
  BH = 6;
  // Button
  hull()
  {
    translate([-(L-DB)/2, 0, 0]) cylinder(d=DB, h=BH);
    translate([+(L-DB)/2, 0, 0]) cylinder(d=DB, h=BH);
  }
  // Button base
  hull()
  {
    translate([-(L-DB)/2, 0, 0]) cylinder(d=DL, h=1.2);
    translate([+(L-DB)/2, 0, 0]) cylinder(d=DL, h=1.2);
  }
}

// *******************************************************************
// ***   Jig module   ************************************************
// *******************************************************************
module Jig(L, DB, DL, H)
{
  // Button
  hull()
  {
    translate([-(L-DB)/2,0,0]) cylinder(d=DB, h=H);
    translate([+(L-DB)/2,0,0]) cylinder(d=DB, h=H);
  }
}