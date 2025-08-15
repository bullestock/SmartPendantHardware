$fn = 600;

SideButton(9.7, 5.6, 6.5); // 1
//SideButton(9, 5.4, 6.5); // 2

//Jig(9.2, 5.6, 6.5, 30);

// *******************************************************************
// ***   SideButton module   *****************************************
// *******************************************************************
module SideButton(L, DB, DL)
{
  // Total height
  BH = 6;
  skirt_height = 1.7;
  // Button
  hull()
  {
    translate([-(L-DB)/2, 0, 0]) cylinder(d=DB, h=BH);
    translate([+(L-DB)/2, 0, 0]) cylinder(d=DB, h=BH);
  }
  // Skirt
  hull()
  {
    translate([-(L-DB)/2, 0, 0]) cylinder(d=DL, h=skirt_height);
    translate([+(L-DB)/2, 0, 0]) cylinder(d=DL, h=skirt_height);
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