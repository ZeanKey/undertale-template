/// @desc Init
depth	= DEPTH.UI;
x		= 30;
y		= 400;

Color = {
	BarFront	: make_color_rgb(255, 255, 0),
	BarBack		: make_color_rgb(192, 0, 0)
};

Render = {
	InstUI : other,
	Bar : function (paraValue, paraColor, paraStart = 0) {
		with (InstUI) draw_sprite_ext(sprPixel, 0, x + 245 + paraStart * 1.25, y, paraValue * 1.25, 21, 0, paraColor, 1);
	}
};