var one = sys.one;
image_alpha -= one * 0.01;
if (image_alpha <= 0) instance_destroy();

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

image_blend = merge_color(c_yellow, c_white, clamp(spd / 2, 0, 1));

image_index += img_spd * one;
if (image_index >= sprite_get_number(sprite_index) - 1) {
	img_spd = 0;
	image_index = sprite_get_number(sprite_index) - 1;
}
