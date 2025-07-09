var one = sys.one;
image_alpha -= one * 0.02;

var decel = 0.1;
if (spd > 0) {
	spd -= one * decel / 2;
}
else {
	spd = 0;
}

x += dcos(image_angle) * spd * one;
y -= dsin(image_angle) * spd * one;

if (spd > 0) {
	spd -= one * decel / 2;
}

if (image_index >= sprite_get_number(sprite_index) - 1) {
	image_speed = 0;
	image_index = sprite_get_number(sprite_index) - 1;
}
