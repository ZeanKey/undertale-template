/// @desc Update
if (!instance_exists(Target)) {
	camera_set_view_target(Camera, noone);
	camera_set_view_pos(Camera, x, y);
}
else{
	camera_set_view_target(Camera, Target);
	camera_set_view_border(Camera, Width / ScaleX / 2, Height / ScaleY / 2);
	x = camera_get_view_x(Camera);
	y = camera_get_view_y(Camera);
}

camera_set_view_size(Camera, Width / ScaleX, Height / ScaleY);
camera_set_view_angle(Camera, Angle);

if (!surface_exists(Surface)) {
	Surface = surface_create(Width / ScaleX, Height / ScaleY);
}

view_set_surface_id(0, Surface);