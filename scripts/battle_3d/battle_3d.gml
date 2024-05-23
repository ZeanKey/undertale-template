function draw_debug_message(valText, valLine)
{
	var BLEND_ORI = draw_get_color();
	var VALI_ORI = draw_get_valign();
	var HALI_ORI = draw_get_valign();
	var FONT_ORI = draw_get_font();
	
	draw_set_valign(fa_bottom);
	draw_set_halign(fa_left);
	draw_set_color(c_white);
	draw_set_font(fontFzxs9);
	
	draw_text_transformed(20, 40 + 20 * valLine, valText, 640 / window_get_width(), 480 / window_get_height(), 0);
	
	draw_set_valign(VALI_ORI);
	draw_set_halign(HALI_ORI);
	draw_set_color(BLEND_ORI);
	draw_set_font(FONT_ORI);
}


