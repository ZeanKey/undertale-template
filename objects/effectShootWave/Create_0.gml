/// @desc Init
_begin = false;
_counter = 0;
_alphaMax = 1;

_time = 30;

_ringIdeal	= 60;
_ringStart	= 0;
_ringEnd	= 0;

self._drawRing = function (paraPos, paraRadStart, paraRadEnd, paraXscale, paraYscale, paraRot)
{
	draw_reset();
	global.SurfaceSetTemporary();
	{
		draw_clear_alpha(c_black, 0);
		draw_set_alpha(image_alpha);
		draw_sprite_ext(sprCircle, 0, paraPos[0], paraPos[1], paraXscale * paraRadEnd / 1024, paraYscale * paraRadEnd / 1024, paraRot, c_white ,image_alpha);
		draw_sprite_ext(sprCircle, 0, paraPos[0], paraPos[1], paraXscale * paraRadStart / 1024, paraYscale * paraRadStart / 1024, paraRot, c_black ,1);
	}
	surface_reset_target();
}