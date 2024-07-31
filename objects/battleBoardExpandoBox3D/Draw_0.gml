/// @description Insert description here
// You can write your code in this editor
var boxTransform = matrix_build(0, 0, 0, 0, 0, 0, BoardSize.X / 2, BoardSize.Y / 2, BoardSize.Z / 2);
var containerTransform = GetTransform();

ValidateBoxSpace();
draw_surface(BoxSpace, 0, 0);
surface_set_target(BoxSpace);
{
	draw_clear_alpha(c_black, 0);
}
surface_reset_target();

shader_set(shdrModelRecolor);
{
	var playerTransform;
	if (instance_exists(SoulInst))
	{
		playerTransform = matrix_build(SoulInst.x, SoulInst.y, SoulInst.ZIndex, 0, 0, 0, 1, 1, 1);
	}
	if (!surface_exists(BoardSurface)) BoardSurface = surface_create(640, 480);
	surface_set_target(BoardSurface)
	{	
		draw_clear_alpha(c_black, 0);
		// Decorations
		if (instance_exists(SoulInst))
		{
			// Layer
			shader_set_uniform_f_array(shdrParamColor, [0.25, 0, 0.5, 1]);
			shader_set_uniform_f(shdrParamWidth, 0.0);
			matrix_set(matrix_world, matrix_multiply(matrix_build(0, SoulInst.y, 0, 0, 0, 0, BoardSize.X / 2, BoardSize.Y / 2, BoardSize.Z / 2), containerTransform));
			vertex_submit(ModelLayer, pr_linestrip, sprite_get_texture(sprPixel, 0));
	
			// Axis line
			shader_set_uniform_f_array(shdrParamColor, [1, 1, 1, 1]);
			shader_set_uniform_f(shdrParamWidth, 0.0);
			matrix_set(matrix_world, matrix_multiply(matrix_multiply(matrix_build(0, 0, 0, 0, 0, 0, AxisLineLength, AxisLineLength, AxisLineLength), playerTransform), containerTransform));
			vertex_submit(ModelAxisLineBuffer, pr_linelist, sprite_get_texture(sprPixel, 0));
		}
		// Soul
		shader_set_uniform_f_array(shdrParamColor, [1, 1, 1, 1]);
		shader_set_uniform_f(shdrParamWidth, 0.0);
		matrix_set(matrix_world, containerTransform);
		if (instance_exists(SoulInst))
		{
			SoulInst.DrawSelf(matrix_get(matrix_world));
		}
		
		gpu_set_ztestenable(true);
		shader_set_uniform_f_array(shdrParamColor, [0, 0, 0, 0]);
		shader_set_uniform_f(shdrParamWidth, 0.0);
		matrix_set(matrix_world, matrix_multiply(boxTransform, containerTransform));
		vertex_submit(ModelBuffer, pr_trianglelist, sprite_get_texture(sprPixel, 0));
		gpu_set_ztestenable(false);
	}
	surface_reset_target();
	
	shader_set_uniform_f_array(shdrParamColor, [color_get_red(BoardColor) / 255, color_get_green(BoardColor) / 255, color_get_blue(BoardColor) / 255, BoardAlpha]);
	shader_set_uniform_f(shdrParamWidth, 5.0);
	matrix_set(matrix_world, matrix_multiply(boxTransform, containerTransform));

	global.SurfaceSetTemporary();
	{
		draw_clear_alpha(c_black, 0);
		vertex_submit(ModelBuffer, pr_trianglelist, sprite_get_texture(sprPixel, 0));
	}
	surface_reset_target();
}
shader_reset();

matrix_set(matrix_world, matrix_build_identity());

gpu_set_ztestenable(true);
gpu_set_depth(Transform.Position.Z + 1000);
surface_set_target(BoardSurface)
{
	outline_start_surface(5, BoardColor, global.TempSurface);
	{
		draw_surface(global.TempSurface, 0, 0);
	}
}
surface_reset_target();
outline_end();
gpu_set_depth(depth);
gpu_set_ztestenable(false);

draw_surface(BoardSurface, 0, 0);
