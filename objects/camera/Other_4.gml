/// @desc Reinit
event_user(0);

view_enabled	= true;
view_visible[0]	= true;
view_camera[0]	= Camera;

view_set_surface_id(0, Surface);

// Force update the surface
if (surface_exists(Surface)) {
	surface_free(Surface);
}

