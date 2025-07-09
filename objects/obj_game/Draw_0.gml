var separate = 3;
var chunk = size + separate * 2;
var total_slices = floor(((2 * pi * radius) / chunk) / (chunk / 2)) * (chunk / 2);
var back_slices = (2 * pi * (radius + size)) / size;
var angle_diff = radtodeg((2 * pi) / total_slices);
var back_angle_diff = radtodeg((2 * pi) / back_slices);

coin_scale += (coin_scale - 1)

var draw_open = function(i, angle_diff, radius, spd, x_center, y_center, scale, op, ind) {
	var ang = i * angle_diff + ((game_angle * spd) / 2);
	draw_sprite_ext(spr_open, ind, x + x_center + dcos(ang) * radius, y + y_center - dsin(ang) * radius, scale, scale, ang, c_white, op);
}

var whoo = 10;
var get_op = function(j, whoo) {
	 return power((j / whoo), clamp(200 / score, 0, 100));
}
for (var j = 1; j <= whoo; j ++) {
	var x_center = 4*(whoo - j) * dcos((game_angle + j * 2) );
	var y_center = 4*(whoo - j) * dsin((game_angle + j * 2) );
	var op = get_op(j, whoo);
	for (var i = 0; i < back_slices; i++) {
		
		draw_open(i, back_angle_diff, radius * j / whoo, whoo / j, x_center, -y_center, j / whoo, op, 1);
	}

	for (var i = 0; i < total_slices; i++) {
		draw_open(i, angle_diff, radius * j / whoo, whoo / j, x_center, -y_center, j / whoo, op, 0);
	}
}

draw_sprite_ext(spr_ojo, 0, x + 40 * dcos(game_angle), y - 40 * dsin(game_angle), 1, 1, 0, c_white, get_op(1, whoo));


draw_sprite_ext(spr_coin, 0, x + dcos(target_angle) * coin_radius, y - dsin(target_angle) * coin_radius, 1, 1, 0, c_yellow, 1);

draw_sprite_ext(spr_thing, 0, x + dcos(game_angle) * thing_radius, y - dsin(game_angle) * thing_radius, 1, 1, game_angle, c_white, 1);

draw_set_halign(fa_center);
draw_set_valign(fa_middle);

/*
draw_line(x, y, x + dcos(game_angle - angle_window) * 1000, y - dsin(game_angle - angle_window) * 1000)
draw_line(x, y, x + dcos(game_angle + angle_window) * 1000, y - dsin(game_angle + angle_window) * 1000)

draw_set_color(c_red);
draw_line(x, y, x + dcos(game_angle - min_angle_diff) * 1000, y - dsin(game_angle - min_angle_diff) * 1000)
draw_line(x, y, x + dcos(game_angle + min_angle_diff) * 1000, y - dsin(game_angle + min_angle_diff) * 1000)
draw_set_color(c_white);
*/
draw_text_transformed(x, y, score, 2, 2, 0);
draw_text_transformed(x, y-48, music_bpm(mus_lock), 2, 2, 0);

switch state {
	case st.game_over:
		draw_text_transformed(x, y + 32, "GAME OVER", 2, 2, 0);
}

draw_set_halign(fa_left);
draw_set_valign(fa_top);