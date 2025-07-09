one = 0.1;
last_one = 0.1;

big_font = font_add_sprite_ext(spr_big_font, "abcdefghijklmnopqrstuvwxyz1234567890*/'\",.:", true, -1);
big_font_mono = font_add_sprite_ext(spr_big_font, "abcdefghijklmnopqrstuvwxyz1234567890*/'\",.:", false, -1);

shake_index = {};
shake_ids = [];
shake_timer = 0;
shake = function(shake_id) {
	if (struct_exists(shake_index, shake_id)) {
		return shake_index[$ shake_id];
	}
	return {angle: 0, intensity: 0, slow_factor: 0};
}

shake_init = function(shake_id, intensity, slow_factor) {
	if (!struct_exists(shake_index, shake_id)) {
		shake_index[$ shake_id] = {angle: 0, intensity: intensity, slow_factor: slow_factor};
		array_push(shake_ids, shake_id);
	}
}

shake_step_all = function() {
	for (var i = 0; i < array_length(shake_ids); i++) {
		shake_step(shake_ids[i]);
	}
}

shake_step = function(shake_id) {
	var shk = shake(shake_id);
	var ang = random(360);
	while (abs(angle_difference(ang, shk.angle)) <= 45) ang = random(360);
	shk.angle = ang;
	shk.intensity -= shk.slow_factor;
	if (shk.intensity < 0) shk.intensity = 0;
}


shakeX = function(shake_id) {
	var shk = shake(shake_id);
	return dcos(shk.angle) * shk.intensity;
}

shakeY = function(shake_id) {
	var shk = shake(shake_id);
	return dsin(shk.angle) * shk.intensity;
}

shake_set = function(shake_id, intensity) {
	var shk = shake(shake_id);
	shk.intensity = intensity;
}
randomize();