$fn=50;

module spacer()
{
    difference(){
        cylinder(r=4.5,h=22);
        translate([0,0,-.1]) cylinder(r=2,h=23);
    }
}
for (x = [-30:14:30]){
    for (y = [-30:14:30]) {
        translate([x,y,0]) spacer();
    }
}

