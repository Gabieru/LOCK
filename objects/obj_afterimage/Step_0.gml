var one = sys.one;
image_alpha -= one * 0.05;

var decel = 0.5;
if (spd > 0) {
	spd -= one * decel / 2;
	x += dcos(image_angle) * spd * one;
	y -= dsin(image_angle) * spd * one;
	spd -= one * decel / 2;
}
else {
	spd = 0;
}