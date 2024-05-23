/// @desc
if (not battleBoard.IsOnScreen) then exit;
// Spin Solution - The real spin, but it's complex

_matViewOri = matrix_get(matrix_view);
_matProjOri = matrix_get(matrix_projection);
_matWorldOri = matrix_get(matrix_world);

// Pre - Evaluate position figures
var BOX_W = BoxGetWidth();
var BOX_H = BoxGetHeight();
var BOX_X = Main.x;
var BOX_Y = Main.y;
		
#region Validize Depth Angle
var ANGLE_LIMIT = 60;
var ANGLE_DYING_RATE = 1.05;

// Not accepted check
if (BoardDepthAngle > ANGLE_LIMIT) {
	BoardDepthAngle = ANGLE_LIMIT;
}
		
if (BoardDepthAngle != 0) {
	// Avoid Error Occurance
	if ((BoardTowardAngle) == "N/A") {
		BoardTowardAngle = 0;
	}
			
	// Decrease the Depth Angle
	BoardDepthAngle /= ANGLE_DYING_RATE;
	if (BoardDepthAngle < 1) {
		BoardDepthAngle = 0;
		BoardTowardAngle = "N/A";
	}
}
else {
	BoardTowardAngle = "N/A";
}
#endregion
		
#region Pre - Evaluate Outer Surface Size
// Pre - Evaluate position figures
var SURF_WIDTH = 640;
var SURF_HEIGHT = 480;
var SURF_SAVE = 640;
		
// Constant sides evaluate - using the least size
if (BOX_W / 4 > BOX_H / 3) {
	SURF_SAVE = 480;
}
		
if (SURF_SAVE == 640) {
	SURF_HEIGHT = 640 / BOX_W * BOX_H;
}
else {
	SURF_WIDTH = 480 / BOX_H * BOX_W;
}
#endregion
		
#region Pre - Evaluate Depth On Corners
var VEC0, VEC1, VEC2, VEC3;
		
// Pre - Evaluate position figures
var H_W = SURF_WIDTH / 2;
var H_H = SURF_HEIGHT / 2;
		
// Corner position vector init
for (var INDEX = 0; INDEX < 4; INDEX ++) {
	VEC0 = [- H_W, - H_H, 0];
	VEC1 = [+ H_W, - H_H, 0];
	VEC2 = [+ H_W, + H_H, 0];
	VEC3 = [- H_W, + H_H, 0];
}
		
// Check if the towards angle is accepted
// Evaluate the rotatry matrix and the oringinal imaginary surface corners' vector
if (BoardDepthAngle != 0) {
	var VECTOR_R = [[
					lengthdir_x(1, BoardTowardAngle + 90),
					lengthdir_y(1, BoardTowardAngle + 90),
					0]];
	var VECTOR_THETA = BoardDepthAngle;
			
			
	var MAT = matrix_normalize(rodrigues_rotation(VECTOR_R, VECTOR_THETA));
	VEC0 = matrix_transform_vertex(MAT, - H_W, - H_H, 0);
	VEC1 = matrix_transform_vertex(MAT, + H_W, - H_H, 0);
	VEC2 = matrix_transform_vertex(MAT, + H_W, + H_H, 0);
	VEC3 = matrix_transform_vertex(MAT, - H_W, + H_H, 0);
}
		
/// The corners' index order belike this.
/// 0 --- 1 ///
/// |     | ///
/// |     | ///
/// 3 --- 2 ///
// The actual surface corners position init
var POS = [];
// Using the linear function to evaluate the points on the actual surface
POS[0] = [	linear_get_result(-H_W, VEC0[0], +H_W, VEC1[0], - BOX_X) + BOX_X,
			linear_get_result(-H_H, VEC0[1], +H_H, VEC3[1], - BOX_Y) + BOX_Y,
			linear_get_result(-H_H, VEC0[2], +H_H, VEC3[2], - BOX_Y)];
POS[1] = [	linear_get_result(-H_W, VEC0[0], +H_W, VEC1[0], 640 - BOX_X) + BOX_X,
			linear_get_result(-H_H, VEC1[1], +H_H, VEC2[1], - BOX_Y) + BOX_Y,
			linear_get_result(-H_H, VEC1[2], +H_H, VEC2[2], - BOX_Y)];
POS[2] = [	linear_get_result(-H_W, VEC3[0], +H_W, VEC2[0], 640 - BOX_X) + BOX_X,
			linear_get_result(-H_H, VEC1[1], +H_H, VEC2[1], 480 - BOX_Y) + BOX_Y,
			linear_get_result(-H_H, VEC1[2], +H_H, VEC2[2], 480 - BOX_Y)];
POS[3] = [	linear_get_result(-H_W, VEC3[0], +H_W, VEC2[0], - BOX_X) + BOX_X,
			linear_get_result(-H_H, VEC0[1], +H_H, VEC3[1], 480 - BOX_Y) + BOX_Y,
			linear_get_result(-H_H, VEC0[2], +H_H, VEC3[2], 480 - BOX_Y)];
		
// TODO
var DEP = 600;
matrix_set(matrix_view,			matrix_build_lookat(0, 0, -DEP, 0, 0, 0, 0, 1, 0));
matrix_set(matrix_projection,	matrix_build_projection_perspective(640, 480, DEP, 10000));
matrix_set(matrix_world,		matrix_build(-320, -240, 0, 0, 0, 0, 1, 1, 1));
		
// Render start
var V_BUFFER = vertex_create_buffer();
vertex_begin(V_BUFFER, global.format_general);
		  
vertex_position_3d(V_BUFFER, POS[0][0], POS[0][1], POS[0][2]);
vertex_texcoord(V_BUFFER, 0, 0);
vertex_color(V_BUFFER, -1, 1);
vertex_normal(V_BUFFER, 0, 0, -1);
		  
vertex_position_3d(V_BUFFER, POS[1][0], POS[1][1], POS[1][2]);
vertex_texcoord(V_BUFFER, 1, 0);
vertex_color(V_BUFFER, -1, 1);
vertex_normal(V_BUFFER, 0, 0, -1);
		
vertex_position_3d(V_BUFFER, POS[2][0], POS[2][1], POS[2][2]);
vertex_texcoord(V_BUFFER, 1, 1);
vertex_color(V_BUFFER, -1, 1);
vertex_normal(V_BUFFER, 0, 0, -1);
		
/// ----- ///
		
vertex_position_3d(V_BUFFER, POS[0][0], POS[0][1], POS[0][2]);
vertex_texcoord(V_BUFFER, 0, 0);
vertex_color(V_BUFFER, -1, 1);
vertex_normal(V_BUFFER, 0, 0, -1);
		
vertex_position_3d(V_BUFFER, POS[2][0], POS[2][1], POS[2][2]);
vertex_texcoord(V_BUFFER, 1, 1);
vertex_color(V_BUFFER, -1, 1);
vertex_normal(V_BUFFER, 0, 0, -1);

vertex_position_3d(V_BUFFER, POS[3][0], POS[3][1], POS[3][2]);
vertex_texcoord(V_BUFFER, 0, 1);
vertex_color(V_BUFFER, -1, 1);
vertex_normal(V_BUFFER, 0, 0, -1);

vertex_end(V_BUFFER);
vertex_submit(V_BUFFER, pr_trianglelist, surface_get_texture(global.TempSurface));
vertex_delete_buffer(V_BUFFER);
// Render end
		
matrix_set(matrix_view,			_matViewOri);
matrix_set(matrix_projection,	_matProjOri);
matrix_set(matrix_world,		_matWorldOri);
#endregion