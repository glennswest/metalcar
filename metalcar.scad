include <MCAD/motors.scad>

yspacing = 40.29;
xspacing = 52.75;
halfx = xspacing / 2;
halfy = yspacing / 2;
$fn=128;

magspacing = 50;
halfmag = magspacing / 2;
theheight = 4;

module theholes(extra=0)
{
    translate([0-halfx,0-halfy,0]) cylinder(r=2.5+extra,h=theheight);
    translate([0+halfx,0-halfy,0]) cylinder(r=2.5+extra,h=theheight);
    translate([6,0+halfy,0]) cylinder(r=3.625+extra,h=theheight);
    
    // Mags
    translate([-11,0-halfmag,0]) cylinder(r=1.55+extra,h=theheight);
    translate([-11,0+halfmag,0]) cylinder(r=1.55+extra,h=theheight);
    
    // Belt
   translate([-11,0+halfmag-15,0]) cylinder(r=1.55+extra,h=theheight);
    
   translate([0-halfx-4,0,0]) cylinder(r=1.55,h=theheight);
}

module body_stepper()
{
difference(){
        translate([-10,-75,0]) cube([40,40,theheight]);
        translate([10,-55,-.1]) linear_extrude(height=theheight+.2) stepper_motor_mount(17,mochup=false);
        }    
       translate([0,-40,0]) cube([15,20,theheight]);   
}

module body(stepper=0)
{
    if (stepper==1) body_stepper();
    
    translate([0-halfx-9,-5,0]) cube([20,10,theheight]);
    translate([0-halfx,0-halfy-5,0]) cube([xspacing,10,theheight]);
    translate([-11-5,0-halfmag,0]) cube([10,magspacing,theheight]);
    translate([20,0-halfmag,0]) rotate([0,0,25]) cube([10,magspacing,theheight]);
    translate([6-3,0+halfy-5,0]) rotate([0,0,70]) cube([10,20,theheight]); 
    theholes(5);  
}



module metalcar(extra,stepper)
{
    difference(){
        body(stepper);
        theholes(extra);
    }
}

translate([0,0,0]) metalcar(0,0);
translate([0,0,theheight]) metalcar(3,0);
