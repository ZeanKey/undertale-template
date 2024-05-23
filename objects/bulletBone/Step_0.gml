/// @desc Collision Check
// Inherit the parent event
event_inherited();
evaluate_size();

if (collision_line(	x + lengthdir_x(-Size / 2, image_angle) + Offset.X,
					y + lengthdir_y(-Size / 2, image_angle) + Offset.X,
					x + lengthdir_x(Size / 2, image_angle) + Offset.X,
					y + lengthdir_y(Size / 2, image_angle) + Offset.X,
					battleSoul, 1, 0)) {
	Events.Collision.Call(-1, self);
}

