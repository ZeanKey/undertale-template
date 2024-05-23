///@desc Init
_ringRad = 20;
_counter = 0;
_ringRate = 1;
_ringAlpha = 0.9;


self._drawAimTriangle = function (paraPos, paraRads, paraAngle, paraDurAngle)
{
	var RAD_S = paraRads[0];
	var RAD_E = paraRads[1];
	var ANGLE_OFFSET = paraDurAngle / 2;
	var RAD_D = RAD_E - RAD_S;
	var VEC_OFFSET = [	lengthdir_x(RAD_S, paraAngle),
						lengthdir_y(RAD_S, paraAngle)];
	var VEC_1 = [	lengthdir_x(RAD_D, paraAngle - ANGLE_OFFSET),
					lengthdir_y(RAD_D, paraAngle - ANGLE_OFFSET)];
	var VEC_2 = [	lengthdir_x(RAD_D, paraAngle + ANGLE_OFFSET),
					lengthdir_y(RAD_D, paraAngle + ANGLE_OFFSET)];
	
	var POS0_X = paraPos[0] + VEC_OFFSET[0];
	var POS0_Y = paraPos[1] + VEC_OFFSET[1];
	var POS1_X = POS0_X + VEC_1[0];
	var POS1_Y = POS0_Y + VEC_1[1];
	var POS2_X = POS0_X + VEC_2[0];
	var POS2_Y = POS0_Y + VEC_2[1];
	
	draw_triangle(POS0_X, POS0_Y, POS1_X, POS1_Y, POS2_X, POS2_Y, false);
}

self._drawTriangle = function (paraPos, paraRadEnd, paraStart, paraEnd)
{
	var POS1_X, POS1_Y, POS2_X, POS2_Y, POS3_X, POS3_Y;
	var paraBlankAngleStart, paraBlankAngleEnd
	
	if paraEnd > paraStart + 90 
	{
		var COUNTER_FINAL = (paraEnd - paraStart) div 90;
		for (var COUNTER = 0; COUNTER < (paraEnd - paraStart) div 90; COUNTER ++)
		{
			self._drawTriangleRaw(paraPos, paraRadEnd, paraStart + COUNTER * 90, paraStart + COUNTER * 90 + 90);
		}
		self._drawTriangleRaw(paraPos, paraRadEnd, paraStart + COUNTER_FINAL * 90, paraEnd);
	}
	else
	{
		self._drawTriangleRaw(paraPos, paraRadEnd, paraStart, paraEnd);
	}
}

self._drawTriangleRaw = function (paraPos, paraRadEnd, paraStart, paraEnd)
{
	var POS1_X, POS1_Y, POS2_X, POS2_Y, POS3_X, POS3_Y;
	var paraBlankAngleStart, paraBlankAngleEnd
	
	paraBlankAngleStart = paraStart;
	paraBlankAngleEnd	= paraEnd;
	POS1_X = paraPos[0];
	POS1_Y = paraPos[1];
	POS2_X = POS1_X + lengthdir_x(paraRadEnd * 2, paraBlankAngleStart);
	POS2_Y = POS1_Y + lengthdir_y(paraRadEnd * 2, paraBlankAngleStart);
	POS3_X = POS1_X + lengthdir_x(paraRadEnd * 2, paraBlankAngleEnd);
	POS3_Y = POS1_Y + lengthdir_y(paraRadEnd * 2, paraBlankAngleEnd);
		
	draw_triangle(POS1_X, POS1_Y, POS2_X, POS2_Y, POS3_X, POS3_Y, false);
}

self._drawRing = function (paraPos, paraRadStart, paraRadEnd, paraBlanks, paraAlpha, paraColor = c_white)
{
	draw_reset();
	global.SurfaceSetTemporary();
	{
		var ALPHA_ORI = image_alpha;
		draw_set_alpha(1);
		draw_clear_alpha(c_black, 0);
		draw_sprite_ext(sprCircle, 0, paraPos[0], paraPos[1], paraRadEnd / 512, paraRadEnd / 512, 0, paraColor, paraAlpha);
		draw_sprite_ext(sprCircle, 0, paraPos[0], paraPos[1], paraRadStart / 512, paraRadStart / 512, 0, c_black, 1);
		draw_set_color(c_black);
		
		var POS1_X, POS1_Y, POS2_X, POS2_Y, POS3_X, POS3_Y;
		var paraBlankAngleStart, paraBlankAngleEnd;
		
		//draw_set_alpha(1);
		for (var BLANK_COUNT = 0; BLANK_COUNT < array_length(paraBlanks); BLANK_COUNT ++) 
		{
			paraBlankAngleStart = paraBlanks[BLANK_COUNT][0];
			paraBlankAngleEnd	= paraBlanks[BLANK_COUNT][1];
			self._drawTriangle(paraPos, paraRadEnd, paraBlankAngleStart, paraBlankAngleEnd);
		}
		draw_set_alpha(ALPHA_ORI);
	}
	surface_reset_target()
	
	gpu_set_blendmode(bm_add);
	draw_surface_ext(global.TempSurface, 0, 0, 1, 1, 0, -1, paraAlpha);
	gpu_set_blendmode(bm_normal);
}
