draw_text_transformed(8, 8, "highscore: " + string(highscore), 2, 2, 0);
draw_set_halign(fa_right);
draw_text(display_get_gui_width() - 8, 8, string(floor(60 / sys.one)) + " fps");
draw_set_halign(fa_left);