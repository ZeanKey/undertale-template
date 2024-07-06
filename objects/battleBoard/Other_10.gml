/// @desc
if (not battleBoard.IsOnScreen) then exit;
// Spin Solution - The real spin, but it's complex

var box_size	= BoxGetSize();
var box_pos	= BoxGetPos();

// Pre - Evaluate position figures
#region Evaluate Depth Angle
var ANGLE_LIMIT = 60;
var ANGLE_DYING_RATE = 1.05;

// Limit
if (BoardDepthAngle > ANGLE_LIMIT) {
	BoardDepthAngle = ANGLE_LIMIT;
}
		
if (BoardDepthAngle != 0) {
	if (is_undefined(BoardTowardAngle)) {
		BoardTowardAngle = 0;
	}
	// Decrease the Depth Angle
	BoardDepthAngle /= ANGLE_DYING_RATE;
	if (BoardDepthAngle < 1) {
		BoardDepthAngle = 0;
		BoardTowardAngle = undefined;
	}
}
else {
	BoardTowardAngle = undefined;
}
#endregion

#region Pre - Build Matrix
var mat_world =DefaultMatWorld;
if (BoardDepthAngle != 0) {
	var vec_r = [[lengthdir_x(1, BoardTowardAngle + 90), lengthdir_y(1, BoardTowardAngle + 90), 0]];
	var vec_theta = BoardDepthAngle;
	mat_world = matrix_build(-box_pos.X, -box_pos.Y, 0, 0, 0, 0, 1, 1, 1);
	mat_world = matrix_multiply(mat_world, matrix_normalize(rodrigues_rotation(vec_r, vec_theta)));
	mat_world = matrix_multiply(mat_world, matrix_build(box_pos.X, box_pos.Y, 0, 0, 0, 0, 1, 1, 1));
}

matrix_set(matrix_view,				matrix_build_lookat(320, 240, -240*sqrt(3), 320, 240, 0, 0, 1, 0));
matrix_set(matrix_projection,	matrix_build_projection_perspective_fov(-60, -4/3, 1.0, 32000.0));
matrix_set(matrix_world,			mat_world);

// Render start
vertex_submit(BoardVBuffer, pr_trianglestrip, surface_get_texture(global.TempSurface));
// Render end
		
matrix_set(matrix_view,				DefaultMatView);
matrix_set(matrix_projection,	DefaultMatProj);
matrix_set(matrix_world,			DefaultMatWorld);
#endregion