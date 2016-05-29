include <MCAD/motors.scad>
extra_radius = 0.1;

// OD = outside diameter, corner to corner.
m3_nut_od = 6.1;
m3_nut_radius = m3_nut_od/2 + 0.2 + extra_radius;

// Major diameter of metric 3mm thread.
m3_major = 2.85;
m3_radius = m3_major/2 + extra_radius;
m3_wide_radius = m3_major/2 + extra_radius + 0.2;

// OD = outside diameter, corner to corner.
m5_nut_od = 8.1;
m5_nut_radius = m5_nut_od/2 + 0.2 + extra_radius;

m5_head_od = 10.5;
m5_head_radius = m5_head_od/2 + 0.2 + extra_radius;

// Major diameter of metric 5mm thread.
m5_major = 4.85;
m5_radius = m5_major/2 + extra_radius;
m5_wide_radius = m5_major/2 + extra_radius + 0.2;

// NEMA17 stepper motors.
motor_shaft_diameter = 5;
motor_shaft_radius = motor_shaft_diameter/2 + extra_radius;

// Frame brackets. M3x8mm screws work best with 3.6 mm brackets.
thickness = 3.6;

// OpenBeam or Misumi. Currently only 15x15 mm, but there is a plan
// to make models more parametric and allow 20x20 mm in the future.
extrusion = 15;
extra_radius = 0.1;

// Belt parameters
belt_width_clamp = 6;              // width of the belt, typically 6 (mm)
belt_thickness = 1.0 - 0.05;       // slightly less than actual belt thickness for compression fit (mm)           
belt_pitch = 2.0;                  // tooth pitch on the belt, 2 for GT2 (mm)
tooth_radius = 0.8;                // belt tooth radius, 0.8 for GT2 (mm)

separation = 40;
thickness = 6;

horn_thickness = 13;
horn_x = 8;

belt_width = 5;
belt_x = 5.6;
belt_z = 7;
corner_radius = 3.5;


yspacing = 60.29;
xspacing = 52.75;
halfx = xspacing / 2;
halfy = yspacing / 2;
$fn=128;

magspacing = 50;
halfmag = magspacing / 2;
theheight = 2.5;

module theholes(extra=0)
{
    translate([0-halfx,0-halfy,0]) cylinder(r=2.5+extra,h=theheight);
    translate([0+halfx,0-halfy,0]) cylinder(r=2.5+extra,h=theheight);
    translate([6,0+halfy,0]) cylinder(r=3.7+extra,h=theheight);
    
    
   
   //if (extra == 0) translate([0-halfx,0,theheight+1]) rotate([0,90,0]) cylinder(r=3,h=10); 
}



module endstop()
{
    
    difference(){
      translate([0-halfx,0,theheight+.5]) rotate([0,90,0]) cylinder(r=3.6,h=10);
      translate([0-halfx-.2,0,theheight+.5]) rotate([0,90,0]) cylinder(r=2.5,h=15);
    }
      
}
module plate()
{
    translate([0-halfx,0-halfy,0]) cube([xspacing-3,yspacing,theheight]);
    
    
}
module body(stepper=0)
{
    difference(){
      plate();
      translate([0-halfx-10,halfy,-0.1]) cylinder(r=31,h=theheight+.2);
      translate([halfx-26,0-halfy-20,-0.1]) cylinder(r=25,h=theheight+.2);
      }
  //  translate([0-halfx-9,-5,0]) cube([20,10,theheight]);
  //  translate([0-halfx,0-halfy-5,0]) cube([xspacing,10,theheight]);
  //  translate([-11-5,0-halfmag,0]) cube([10,magspacing,theheight]);
  //  translate([20,0-halfmag,0]) rotate([0,0,25]) cube([10,magspacing,theheight]);
  //  translate([6-3,0+halfy-5,0]) rotate([0,0,70]) cube([10,20,theheight]); 
    theholes(5);  
}



module metalcar(extra,stepper)
{
    difference(){
        body(stepper);
        theholes(extra);
    }
}

module carriage() {
  // Timing belt (up and down).
  translate([-belt_x, 0, belt_z + belt_width/2]) %
    cube([1.7, 100, belt_width], center=true);
  translate([belt_x+1.23, 0, belt_z + belt_width/2]) %
    cube([2.3, 100, belt_width], center=true);
  difference() {
    union() {
      // Main body.
      translate([0, 4, thickness/2])
        cube([27, 40, thickness], center=true);
      // Ball joint mount horns.
      for (x = [-1, 1]) {
        scale([x, 1, 1]) intersection() {
          translate([0, 15, horn_thickness/2])
            # cube([separation, 18, horn_thickness], center=true);
          translate([horn_x, 16, horn_thickness/2]) rotate([0, 90, 0])
            cylinder(r1=14, r2=2.5, h=separation/2-horn_x);
        }
      }
      
      // Avoid touching diagonal push rods (carbon tube).
      difference() {
        translate([10.75, 2.5, horn_thickness/2+1])
          cube([5.5, 37, horn_thickness-2], center=true);

        translate([23, -12, 12.5]) rotate([30, 40, 30])
          cube([40, 40, 20], center=true);
       

      }

      // Belt clamps
      for (y = [[9, -1], [-1, 1]]) {
        translate([2.20, y[0], horn_thickness/2+1])
            hull() {
            translate([ corner_radius-1,  -y[1] * corner_radius + y[1], 0]) cube([2, 2, horn_thickness-2], center=true);
            cylinder(h=horn_thickness-2, r=corner_radius, $fn=12, center=true);
          }
      }

      // top cube
      translate([2.20, 19, horn_thickness/2+1])
         difference() {
          cube([7, 10, horn_thickness-2], center=true);
          translate([2.8, -3,1])
            cube([1.6, 7.6, 10], center=true);
			translate([-1.5,-5,-1.5]) {
	       cube([belt_thickness,10,10]);
    		 for (mult = [0:5]) {
			     translate([1,belt_pitch*mult,0]) cylinder(r=tooth_radius, h=10);
			  		}
			  } 
        }

      // bottom cube
      translate([2.20, -11, horn_thickness/2+1])
           difference() {
			 cube([7, 10, horn_thickness-2], center=true);
          translate([-1.5,-5,-1.5]) {
	       cube([belt_thickness,10,10]);
    		 for (mult = [0:5]) {
			     translate([1,belt_pitch*mult,0]) cylinder(r=tooth_radius, h=10);
			  		}
			  } }
    }

    // Screws for ball joints.
    translate([0, 16, horn_thickness/2]) rotate([0, 90, 0]) #
      cylinder(r=m3_wide_radius, h=60, center=true, $fn=12);
    // Lock nuts for ball joints.
    for (x = [-1, 1]) {
      scale([x, 1, 1]) intersection() {
        translate([horn_x, 16, horn_thickness/2]) rotate([90, 0, -90])
          cylinder(r1=m3_nut_radius, r2=m3_nut_radius+0.5, h=8,
                   center=true, $fn=6);
      }
    }
  }
}
translate([0,0,theheight+2]) endstop();
translate([0,0,0]) metalcar(0,0);   
translate([0,0,theheight]) metalcar(3,0);
difference(){
  translate([7,0,theheight+theheight]) rotate([0,0,90]) carriage();
  translate([0-halfx-.2,0,theheight+theheight+2.5]) rotate([0,90,0]) cylinder(r=2.5,h=25);
}  