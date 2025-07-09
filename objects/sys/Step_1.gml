last_one = one;
one = (delta_time / 1000000) / 0.016;

shake_timer += one;
var shake_frames = 3;
while (shake_timer > shake_frames) {
	shake_timer -= shake_frames;
	shake_step_all();
}