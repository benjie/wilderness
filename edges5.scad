hexagonWidth = (213.2 + 0.4)/6; /*106.6*2; 213.2; 35.5*/
fiddle = 0.2;
depth = 30;
height = 6;
seaHeight = 1.5;
dietMode = false;

// Image stuff
dataFile = "./edgepic2.dat";
imageWidth = 620;
embossDepth = 0.5;

/*
cah
c = a / h
h = a / c
hexWidth/2 / cos(30) = a = 20.5
*/

hexagonEdge = hexagonWidth/2 / cos(30);

bobbleRatio = 4;
bobbleOffset = 0.6;
bobbleTolerance = 1;

innerWidth =  5 * hexagonWidth + 2 * ((2*hexagonEdge * cos(30)) - hexagonEdge / (2 * cos(30)));
outerWidth = innerWidth + 2 * (tan(30) * depth);
imageScale = innerWidth/imageWidth;

echo("InnerWidth: ", innerWidth);
echo("OuterWidth: ", outerWidth);

if (!dietMode) {
difference() {
	translate([0, -outerWidth/2 / tan(30) + depth/2, seaHeight/2]) {
		cylinder(h=seaHeight, r=outerWidth, center=true, $fn=2000);
	}
	translate([0, -outerWidth, height/2]) {
		cube(size=[outerWidth*2,depth+outerWidth*2,height+2*fiddle], center=true);
	}
}
}


translate([0, 0, height/2]) {
difference() {
	cube(size=[outerWidth,depth,height], center=true);

	translate([-outerWidth/2 - depth/2 * tan(30),0,0]) {
		rotate(-60) {
			cube(size=[outerWidth*2,depth,height+2*fiddle], center=true);
		}
	}
	translate([outerWidth/2 + depth/2 * tan(30),0,0]) {
		rotate(60) {
			cube(size=[outerWidth*2,depth,height+2*fiddle], center=true);
		}
	}
	translate([-outerWidth/2 + depth/2*tan(30), 0, 0]) {
		rotate(30) {
			translate([bobbleOffset*depth/(bobbleRatio),0,0]) {
				cylinder(h= height+2*fiddle, r= depth/bobbleRatio, center=true, $fn=200);
			}
		}
	}
	for (i = [-3:3]) {
		translate([i*hexagonEdge*2*cos(30), -depth/2 - hexagonEdge/2, 0]) {
			rotate(30) {
				cylinder(h=height+2*fiddle, r=hexagonEdge, center=true, $fn=6)
;
			}
		}
	}
	if (dietMode) {
		translate([outerWidth*0.025, depth/4+fiddle, 0]) {
			cube(size=[outerWidth*0.85, depth*0.5, height+2*fiddle], center=true);
		}
	}


translate([0, depth/6, height/2+fiddle]) {
    scale([imageScale, -imageScale, -1/256 * height * embossDepth]) {
        surface(file = dataFile, center=true);
    }
}


}
}
	translate([outerWidth/2 - depth/2*tan(30), 0, height/2]) {
		rotate(-30) {
			translate([bobbleOffset*depth/(bobbleRatio),0,0]) {
				cylinder(h= height, r= depth/bobbleRatio - bobbleTolerance/2, center=true, $fn=200);
			}
		}
	}
