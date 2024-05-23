/// @desc
if (not _isInitialized) then exit;

draw_sprite_ext(sprPixel, 0, x, y, image_xscale, image_yscale, 0, c_white, 1);
draw_sprite_ext(sprPixel, 0, x + _edge, y + _edge, 
				image_xscale - _edge * 2,
				image_yscale - _edge * 2, 0, c_black, 1);




