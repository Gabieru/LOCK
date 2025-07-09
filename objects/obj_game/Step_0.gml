var one = sys.one;
var click = keyboard_check_pressed(vk_space) or mouse_check_button_pressed(mb_left);

var lstate = state;
state_timer += one;

if (speaker != noone) {
	var interval = beat_second_interval(get_music_asset());
	var actual_beat = ceil(audio_sound_get_track_position(speaker) / interval);
	if (actual_beat != beat_index) {
		beat_index = actual_beat
		onBeat();
	}
}

var lose_game = function() {
	state = st.game_over;
	ini_open("record.ini");
	ini_write_real("record", "highscore", highscore);
	ini_close();
	window_mouse_set_locked(false);
	window_set_cursor(cr_arrow);
	if (speaker != noone) {
		if (pre_music) {
		audio_stop_sound(speaker);
		speaker = noone;
		}
		else {
			audio_sound_gain(speaker, 0, 3000);
		}
	}
}

var manage_music = function() {
	if (score >= checkpoint) {
		if (speaker == noone || pre_music) {
			audio_sound_pitch(speaker, 1);
			if (speaker != noone) audio_stop_sound(speaker);
			speaker = audio_play_sound(mus_lock, 1, true);
			pre_music = false;
		}
	}
	else {
		if (pre_music) {
			if (score == checkpoint - 1) audio_sound_gain(speaker, 0, 2000);
		}
	}
}

var speed_up = function(n = 1) {
	repeat n {
		if (speed_index % ((floor(speed_index / score_scale)) + 1) == 0) {
			game_speed += game_accel;
		}
		speed_index++;
	}
}

switch state {
	case st.wait:
		if (click) {
			state = st.play;
			window_mouse_set_locked(true);
			window_set_cursor(cr_none);
			
			var play_pre_music = function () {
				speaker = audio_play_sound(mus_happyland, 1, true);
				pre_music = true;
				audio_sound_pitch(speaker, pre_music_start_pitch);
			}
			
			if (speaker == noone) {
				play_pre_music();
			}
			else {
				if (audio_sound_get_gain(speaker) <= 0) {
					audio_stop_sound(speaker);
					speaker = noone;
					play_pre_music();
				}
				else {
					audio_sound_gain(speaker, 1, 1000);
				}
			}
		}
		break;
	case st.play:
		if (slowmo > 0) {
			slowmo -= one / 2;
		}
		var slowmo_factor = 1 - (slowmo / slowmo_time);
		
		var lgame_angle = game_angle;
		game_angle += game_speed * lock_direction * one * slowmo_factor * pass_multiplier;
		
		if (slowmo > 0) {
			slowmo -= one / 2;
		}
		
		var in_angle = abs(angle_difference(game_angle, target_angle)) < angle_window;
		if (in_angle) {
			if (!passing) passing = true;
		}
		else {
			if (passing) {
				//lose_game();
				if (speed_index < 999) {
					if (game_speed * pass_multiplier < 46) pass_multiplier ++;
				}
				passing = false;
			}
		}
		
		while (abs(angle_difference(afterimage_angle, game_angle)) > 8) {
			afterimage_angle += 8 * lock_direction;
			if (abs(angle_difference(target_angle, next_target)) < min_angle_diff * 2) {
				var ang = afterimage_angle;
				instance_create_layer(x + dcos(ang) * thing_radius, y - dsin(ang) * thing_radius, layer_get_id("afterimage"), obj_afterimage).image_angle = ang;
			}
		}
		
			
		if (click) {
			if (in_angle) {
				speed_up(1);
				score++;
				
				manage_music();
				
				if (score > highscore) highscore = score;
				passing = false;
				
				instance_create_layer(x + dcos(target_angle) * (coin_radius + size), y - dsin(target_angle) * (coin_radius + size), "afterimage", obj_coin, {image_angle: target_angle});
				advance_game_angles();
				
				if (abs(angle_difference(target_angle, last_angle)) < min_angle_diff * 2) {
					if (close_calls > 0) {
						with obj_afterimage {
							spd = 12;
						}
					}
					else close_calls++;
					
					slowmo = slowmo_time;
				}
				else {
					close_calls = 0;
				}
			}
			else {
				lose_game();
			}
			
		}
		
		break;
		
	case st.game_over:
		if (keyboard_check_pressed(ord("R")) or (state_timer > 10 and click)) {
			init_variables();
			if (speaker != noone) {
				if (audio_sound_get_gain(speaker) > 0) {
					score = checkpoint;
					speed_up(checkpoint);
				}
			}
		}
	break;
}

if (lstate != state) state_timer = 0;

