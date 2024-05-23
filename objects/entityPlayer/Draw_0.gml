/// @desc Render
Animations.Render(x, y);

/*
if (keyboard_check(ord("W"))) {
	draw_set_color(c_red);
	var SPR_GET = Animations.GetCurrentSprite();
	var SPR_WID = sprite_get_width(SPR_GET) * 1;
	var SPR_HEI = sprite_get_height(SPR_GET) * 1;
	switch (Direciton) {
		case DIR.UP:
		draw_rectangle(	x - SPR_WID / 2 + 5, y - 5,
						x + SPR_WID / 2 - 5, y - SPR_HEI + 5, true);
		break;
		case DIR.DOWN:
		draw_rectangle(	x - SPR_WID / 2 + 5, y - SPR_HEI + 20,
						x + SPR_WID / 2 - 5, y + 15, true);
		break;
		case DIR.LEFT:
		draw_rectangle(	x, y - SPR_HEI + 19,
						x - SPR_WID / 2 - 15, y - 1, true);
		break;
		case DIR.RIGHT:
		draw_rectangle(	x, y - SPR_HEI + 19,
						x + SPR_WID / 2 + 15, y - 1, true);
		break;
	}
}
*/