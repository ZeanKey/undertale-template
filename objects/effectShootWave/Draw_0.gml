/// @desc
if _begin
{
	self._drawRing([x, y], _ringStart, _ringEnd, 1, 2, image_angle);

	gpu_set_blendmode(bm_add);
	draw_surface(global.TempSurface, 0, 0);
	gpu_set_blendmode(bm_normal);
}