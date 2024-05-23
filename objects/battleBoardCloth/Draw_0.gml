if _initialized
{
	#region Init
	// Init - Render settings
	draw_reset();
	
	// Init - Cloth values
	var pointCount = ds_list_size(points);
	var jointCount = ds_list_size(joints);
	var FACE_W = w - 1;
	var FACE_H = h - 1;
	var CLOTH_W = FACE_W * _blankColumn;
	var CLOTH_H = FACE_H * _blankRow;
	
	#region Banished
	/*
	for (var i=0; i<pointCount; i++)
	{
		var point = points[| i];
	
		if not point._outline
		{
			draw_circle(point.xx, point.yy, 3, false);
		}
	}
	*/
	#endregion
	#region Banished
	/*
	draw_primitive_begin(pr_trianglestrip);

	var FRAME = 5;

	var L_START = 0;
	var L_END = array_length(JOINTS_L);

	for (var INDEX = L_START; INDEX < L_END; INDEX ++)
	{
		var joint = JOINTS_L[INDEX];
		var X_MID = (joint.pointA.xx + joint.pointB.xx) / 2;
		var Y_MID = (joint.pointA.yy + joint.pointB.yy) / 2;
		var DIREC = point_direction(joint.pointA.xx, joint.pointA.yy, joint.pointB.xx, joint.pointB.yy) - 90;
		if INDEX != 0
		{
			draw_vertex_color(joint.pointB.xx, joint.pointB.yy, c_white, 1);
			draw_vertex_color(joint.pointB.xx + lengthdir_x(FRAME, DIREC), joint.pointB.yy + lengthdir_y(FRAME, DIREC), c_white, 1);
		}
		if INDEX != L_END - 1
		{
			draw_vertex_color(joint.pointA.xx, joint.pointA.yy, c_white, 1);
			draw_vertex_color(joint.pointA.xx + lengthdir_x(FRAME, DIREC), joint.pointA.yy + lengthdir_y(FRAME, DIREC), c_white, 1);
		}
	}

	clothVertexsPairCorner(DIR.LEFT, DIR.DOWN);
	//clothVertexCorner(DIR.LEFT, DIR.DOWN);

	var D_START = 0;
	var D_END = array_length(JOINTS_D);

	for (var INDEX = D_START; INDEX < D_END; INDEX ++)
	{
		var joint = JOINTS_D[INDEX];
		var X_MID = (joint.pointA.xx + joint.pointB.xx) / 2;
		var Y_MID = (joint.pointA.yy + joint.pointB.yy) / 2;
		var DIREC = point_direction(joint.pointA.xx, joint.pointA.yy, joint.pointB.xx, joint.pointB.yy) - 90;
		if INDEX != 0
		{
			draw_vertex_color(joint.pointB.xx, joint.pointB.yy, c_white, 1);
			draw_vertex_color(joint.pointB.xx + lengthdir_x(FRAME, DIREC), joint.pointB.yy + lengthdir_y(FRAME, DIREC), c_white, 1);
		}
		if INDEX != D_END - 1
		{
			draw_vertex_color(joint.pointA.xx, joint.pointA.yy, c_white, 1);
			draw_vertex_color(joint.pointA.xx + lengthdir_x(FRAME, DIREC), joint.pointA.yy + lengthdir_y(FRAME, DIREC), c_white, 1);
		}
	}

	clothVertexsPairCorner(DIR.RIGHT, DIR.DOWN);
	//clothVertexCorner(DIR.RIGHT, DIR.DOWN);

	var R_START = array_length(JOINTS_R) - 1;
	var R_END = 0;

	for (var INDEX = R_START; INDEX >= R_END; INDEX --)
	{
		var joint = JOINTS_R[INDEX];
		var X_MID = (joint.pointA.xx + joint.pointB.xx) / 2;
		var Y_MID = (joint.pointA.yy + joint.pointB.yy) / 2;
		var DIREC = point_direction(joint.pointA.xx, joint.pointA.yy, joint.pointB.xx, joint.pointB.yy) + 90;
		if INDEX != R_START
		{
			draw_vertex_color(joint.pointA.xx, joint.pointA.yy, c_white, 1);
			draw_vertex_color(joint.pointA.xx + lengthdir_x(FRAME, DIREC), joint.pointA.yy + lengthdir_y(FRAME, DIREC), c_white, 1);
		}
		if INDEX != 0
		{
			draw_vertex_color(joint.pointB.xx, joint.pointB.yy, c_white, 1);
			draw_vertex_color(joint.pointB.xx + lengthdir_x(FRAME, DIREC), joint.pointB.yy + lengthdir_y(FRAME, DIREC), c_white, 1);
		}
	}

	clothVertexsPairCorner(DIR.RIGHT, DIR.UP);
	//clothVertexCorner(DIR.RIGHT, DIR.UP);

	var U_START = array_length(JOINTS_U) - 1;
	var U_END = 0;

	for (var INDEX = U_START; INDEX >= U_END; INDEX --)
	{
		var joint = JOINTS_U[INDEX];
		var X_MID = (joint.pointA.xx + joint.pointB.xx) / 2;
		var Y_MID = (joint.pointA.yy + joint.pointB.yy) / 2;
		var DIREC = point_direction(joint.pointA.xx, joint.pointA.yy, joint.pointB.xx, joint.pointB.yy) + 90;
		if INDEX != U_START
		{
			draw_vertex_color(joint.pointA.xx, joint.pointA.yy, c_white, 1);
			draw_vertex_color(joint.pointA.xx + lengthdir_x(FRAME, DIREC), joint.pointA.yy + lengthdir_y(FRAME, DIREC), c_white, 1);
		}
		if INDEX != 0
		{
			draw_vertex_color(joint.pointB.xx, joint.pointB.yy, c_white, 1);
			draw_vertex_color(joint.pointB.xx + lengthdir_x(FRAME, DIREC), joint.pointB.yy + lengthdir_y(FRAME, DIREC), c_white, 1);
		}
	}

	clothVertexsPairCorner(DIR.LEFT, DIR.UP);
	//clothVertexCorner(DIR.LEFT, DIR.UP);

	var INDEX = 0;
	var joint = JOINTS_L[INDEX];
	var X_MID = (joint.pointA.xx + joint.pointB.xx) / 2;
	var Y_MID = (joint.pointA.yy + joint.pointB.yy) / 2;
	var DIREC = point_direction(joint.pointA.xx, joint.pointA.yy, joint.pointB.xx, joint.pointB.yy) - 90;
	draw_vertex_color(joint.pointA.xx, joint.pointA.yy, c_white, 1);
	draw_vertex_color(joint.pointA.xx + lengthdir_x(FRAME, DIREC), joint.pointA.yy + lengthdir_y(FRAME, DIREC), c_white, 1);

	draw_primitive_end();
	*/
	#endregion
	
	// Init - Surface
	if not surface_exists(_surfBox)
	{
		_surfBox = surface_create(CLOTH_W, CLOTH_H);
	}
	#endregion
	
	// Render - Draw texture surface
	surface_set_target(_surfBox);
	{
		draw_clear_alpha(c_black, 0);
		var X_SCALE = CLOTH_W / sprite_get_width(sprBoardBoxMask);
		var Y_SCALE = CLOTH_H / sprite_get_height(sprBoardBoxMask);
		draw_sprite_ext(sprBoardBoxFrame, 0, CLOTH_W / 2, CLOTH_H / 2, X_SCALE, Y_SCALE, 0, -1, 1);
	}
	surface_reset_target();
	
	global.SurfaceSetTemporary();
	draw_clear_alpha(c_black, 0);
	// Render - Cloth vertexes
	#region Cloth
	draw_primitive_begin_texture(pr_trianglelist, surface_get_texture(_surfBox));
	{
		for (var C_R = 0; C_R < FACE_H; C_R ++)
		{
			for (var C_C = 0; C_C < FACE_W; C_C ++)
			{
				var P_LU, P_LD, P_RD, P_RU;
				P_LU = clothFindPoint(C_R, C_C);
				P_LD = clothFindPoint(C_R + 1, C_C);
				P_RD = clothFindPoint(C_R + 1, C_C + 1);
				P_RU = clothFindPoint(C_R, C_C + 1);
				draw_vertex_texture(P_LU.xx, P_LU.yy, C_C / FACE_W, C_R / FACE_H);
				draw_vertex_texture(P_LD.xx, P_LD.yy, C_C / FACE_W, (C_R + 1) / FACE_H);
				draw_vertex_texture(P_RU.xx, P_RU.yy, (C_C + 1) / FACE_W, C_R / FACE_H);
		
				draw_vertex_texture(P_LD.xx, P_LD.yy, C_C / FACE_W, (C_R + 1) / FACE_H);
				draw_vertex_texture(P_RU.xx, P_RU.yy, (C_C + 1) / FACE_W, C_R / FACE_H);
				draw_vertex_texture(P_RD.xx, P_RD.yy, (C_C + 1) / FACE_W, (C_R + 1) / FACE_H);
		
			}
		}
	}
	draw_primitive_end();
	#endregion
	
	// Render - Joints
	draw_set_color(_colorLine);
	
	for (var i=0; i<jointCount; i++)
	{
		var joint = joints[| i];
		var width = 1;
	
		if clothIsJointOutline(joint)
		{
			continue;
		}
		
		draw_line_width(joint.pointA.xx, joint.pointA.yy, joint.pointB.xx, joint.pointB.yy, width);
	}
	
	surface_reset_target();
	draw_set_color(c_white);
	
	// Render - Debug
	if debugDraw
	{
		if nearestPoint != -1
		{
			draw_circle_color(nearestPoint.xx, nearestPoint.yy, 6, c_green, c_green, false);
		}

		if selectedPoint != -1
		{
			draw_circle_color(selectedPoint.xx, selectedPoint.yy, 6, c_red, c_red, false);
		}

		_pointSoul.Render();
	}
	
	#region Shader - Init
	// Activating the shader
	bktglitch_activate();

	// Quickly setting all parameters at once using a preset
	bktglitch_config_preset(BktGlitchPreset.B);

	// Additional tweaking
	bktglitch_set_jumbleness(0.5);
	bktglitch_set_jumble_speed(10);
	bktglitch_set_jumble_resolution(random_range(0.2, 0.6));
	bktglitch_set_jumble_shift(random_range(0.2, 0.6));
	bktglitch_set_channel_shift(0.01);
	bktglitch_set_channel_dispersion(.01);

	// Setting the overall intensity of the effect, adding a bit when the ball bounces.
	bktglitch_set_intensity(0.025 + bounceIntensity);
	#endregion
	
	draw_surface(global.TempSurface, 0, 0);
	// Done with the shader (this is really just shader_reset)!
	bktglitch_deactivate();
}
else
{
	var FACE_W = w - 1;
	var FACE_H = h - 1;
	var CLOTH_W = FACE_W * _blankColumn;
	var CLOTH_H = FACE_H * _blankRow;

	if not surface_exists(_surfBox)
	{
		_surfBox = surface_create(CLOTH_W, CLOTH_H);
	}

	surface_set_target(_surfBox);
	{
		draw_clear_alpha(c_black, 0);
		var X_SCALE = CLOTH_W / sprite_get_width(sprBoardBoxMask);
		var Y_SCALE = CLOTH_H / sprite_get_height(sprBoardBoxMask);
		draw_sprite_ext(sprBoardBoxFrame, 0, CLOTH_W / 2, CLOTH_H / 2, X_SCALE, Y_SCALE, 0, -1, 1);
	}
	surface_reset_target();
	
	draw_surface(_surfBox, x, y);
	
	if _load
	{
		for (var INDEX = 0; INDEX < w + h - 4; INDEX ++)
		{
			_effFakeLines[INDEX].Render();
		}
		
		if  _effClean
		{
			event_user(0);
			event_user(1);
		}
	}
}