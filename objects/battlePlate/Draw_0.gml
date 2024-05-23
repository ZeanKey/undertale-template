/// @description Insert description here
// You can write your code in this editor
if (IsOnBoard) {
	surface_set_target(battleBoard.SurfaceBoard);
	draw_self();
	surface_reset_target();
}
else draw_self();