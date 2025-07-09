function music_bpm(music_index){
	switch music_index {
		case mus_lock: return 150.11;
		case mus_happyland: return 90;
	}
}

function beat_second_interval(music_index) {
	return 60 / music_bpm(music_index);
}
function beat_angle_interval(angle_speed, music_index) {
	return (angle_speed * 63 * beat_second_interval(music_index));
}