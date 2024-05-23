/// @desc Render
draw_reset();

if (not surface_exists(SurfaceMask)) then SurfaceMask = surface_create(room_width, room_height);
if (not surface_exists(SurfaceFrame)) then SurfaceFrame = surface_create(room_width, room_height);
if (not surface_exists(SurfaceBoard)) then SurfaceBoard = surface_create(room_width, room_height);

#region Collect Frame
surface_set_target(SurfaceFrame);
draw_clear_alpha(c_black, 0);
// FrameAdd - InnerAdd - FrameSubtract - InnerSubtract
with (battleBoardAdd) {
	Render.Frame();
}
gpu_set_blendmode_ext(bm_inv_src_alpha, bm_inv_src_alpha);
with (battleBoardAdd) {
	Render.Inner();
}
gpu_set_blendmode(bm_normal);
with (battleBoardSubtract) {
	Render.Frame();
}
gpu_set_blendmode_ext(bm_inv_src_alpha, bm_inv_src_alpha);
with (battleBoardSubtract) {
	Render.Inner();
}
gpu_set_blendmode(bm_normal);
surface_reset_target();
#endregion

#region Collect Mask
surface_set_target(SurfaceMask)
draw_clear_alpha(c_black, 0);
with (battleBoardAdd) {
	Render.Mask();
}
gpu_set_blendmode_ext(bm_inv_src_alpha, bm_inv_src_alpha);
with (battleBoardSubtract) {
	Render.Inner();
}
gpu_set_blendmode(bm_normal);
surface_reset_target();
#endregion

#region Dynamic Mask
global.SurfaceSetTemporary();
draw_clear_alpha(c_black, 0);
gpu_set_colorwriteenable(false, false, false, true);
draw_surface(SurfaceMask, 0, 0);
gpu_set_colorwriteenable(true, true, true, false);
draw_surface(SurfaceBoard, 0, 0);
draw_surface(SurfaceFrame, 0, 0);
gpu_set_colorwriteenable(true, true, true, true);
surface_reset_target();
#endregion

if (IsOnScreen) then event_user(0) else draw_surface(global.TempSurface, 0, 0);

surface_set_target(SurfaceBoard);
draw_clear_alpha(c_black, 0);
surface_reset_target();