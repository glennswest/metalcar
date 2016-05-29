
halfy = 10;
extra = 0;
theheight = 2.5;

difference(){
    translate([6,0+halfy,0]) cylinder(r=7.7+extra,h=theheight);
    translate([6,0+halfy,0]) cylinder(r=3.7+extra,h=theheight);
}