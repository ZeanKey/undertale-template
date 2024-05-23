/// @desc
draw_set_color(image_blend);
draw_set_alpha(1);
for (var i = 0; i < 4; i ++) {
	var ni = ((i + 1) > 3) ? 0 : (i + 1);
	draw_line(	Points[i].X, Points[i].Y,
				Points[ni].X,
				Points[ni].Y);
}
draw_set_color(c_white);

