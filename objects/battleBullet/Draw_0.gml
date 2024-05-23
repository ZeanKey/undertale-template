/// @desc 
Events.Draw.Call(-1, self);

if (IsOnBoard) {
	surface_set_target(battleBoard.SurfaceBoard);
	__render__();
	surface_reset_target();
}
else {
	__render__();
}