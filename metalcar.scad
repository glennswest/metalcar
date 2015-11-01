

yspacing = 40.29;
xspacing = 52.75;
halfx = xspacing / 2;
halfy = yspacing / 2;
$fn=128;

magspacing = 50;
halfmag = magspacing / 2;
theheight = 2;

module theholes(extra=0)
{
    translate([0-halfx,0-halfy,0]) cylinder(r=2.5+extra,h=theheight);
    translate([0+halfx,0-halfy,0]) cylinder(r=2.5+extra,h=theheight);
    translate([6,0+halfy,0]) cylinder(r=3.6+extra,h=theheight);
    
    // Mags
    translate([-11,0-halfmag,0]) cylinder(r=1.55+extra,h=theheight);
    translate([-11,0+halfmag,0]) cylinder(r=1.55+extra,h=theheight);
    
    // Belt
   translate([-11,0+halfmag-15,0]) cylinder(r=1.55+extra,h=theheight);
    
   translate([0-halfx-4,0,0]) cylinder(r=1.55,h=theheight);
}

module body()
{
    translate([0-halfx-9,-5,0]) cube([20,10,theheight]);
    translate([0-halfx,0-halfy-5,0]) cube([xspacing,10,theheight]);
    translate([-11-5,0-halfmag,0]) cube([10,magspacing+5,theheight]);
    translate([20,0-halfmag,0]) rotate([0,0,25]) cube([10,magspacing,theheight]);
    translate([6-3,0+halfy-5,0]) rotate([0,0,70]) cube([10,20,theheight]); 
    theholes(5);  
}

%theholes();

    
    difference(){
        body();
        theholes();
    }