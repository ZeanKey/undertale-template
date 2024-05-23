function draw_reset() {
	draw_set_alpha(1);
	draw_set_blend_mode(bm_normal);
	draw_set_colour(c_white);
	draw_set_halign(fa_left);
	draw_set_valign(fa_top);
	gpu_set_blendmode(bm_normal);
}
