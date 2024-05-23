///@desc Screen Render

// Pre - Clear GUI surface
draw_clear_alpha(c_black, 1);
// Pre - Warning
// Pre - Camera check
if (not instance_exists(camera)) then exit;
if (not variable_instance_exists(camera, "Camera")) then exit;

// Render
draw_surface_ext(	camera.Surface,
					RenderSettings.Offset.X , RenderSettings.Offset.Y,
					camera.ScaleX, camera.ScaleY, 0, -1, 1);

draw_set_font(fontMNC18);
draw_set_alpha(0.5);
draw_set_color(c_gray);
draw_set_halign(1);
draw_set_valign(1);
draw_text_transformed(320, 240, "SAMPLE", 2, 2, 0);