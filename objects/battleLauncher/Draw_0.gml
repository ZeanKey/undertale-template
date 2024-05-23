/// @desc
var ORI = frac(_timer / 100) * 32;
draw_clear_alpha(c_black, 1);
draw_set_alpha(0.5);
draw_set_color(c_green);
for (var INDEX = 0; (INDEX < room_width) || (INDEX < room_height); INDEX += 32) {
	draw_line(ORI + INDEX, -10, ORI + INDEX, room_height + 20);
	draw_line(-10, ORI + INDEX, room_width + 20, ORI + INDEX);
}
draw_set_alpha(1);
draw_set_color(c_white);