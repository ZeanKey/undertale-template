// Macro defination
#macro print show_debug_message
#macro DELEGATE_EXIT "__delegate_exit"

#macro UT_WHITE #FFFFFF
#macro UT_BLUE #14C4FF
#macro UT_ORANGE #F8941D

#macro SAVE_FILE_PREFIX "save_file_"
#macro SAVE_FILE_POSTFIX ".json"
#macro NULL_SAVE undefined

#macro WORLD_OVERWORLD world.Overworld
#macro WORLD_ENCOUNTER world.Encounter
#macro WORLD_ITEM world.Item
#macro WORLD_TYPER global.TyperServer
#macro WORLD_PLAYER world.Player

#macro SND_NONE sndNone

#macro METHOD_DEFAULT global.__method_default__

enum LINE_FORM {
	LINE,
	SEG,
	RAY
}

enum DATA_TYPE {
	VAL,
	LIST,
	ARRAY,
	STRUCT
}

global.__method_default__ = function () {
	return false;
};

#region Vertex Format
vertex_format_begin();
vertex_format_add_colour();
vertex_format_add_position();
vertex_format_add_normal();
global.format_perspective = vertex_format_end();

vertex_format_begin();
vertex_format_add_position_3d();
vertex_format_add_normal();
vertex_format_add_colour();
vertex_format_add_texcoord();
global.format_general = vertex_format_end();

global.format_sealed = vertexize();
#endregion

DirectionToAngle = function (_dir) {
	switch (_dir) {
		case DIR.RIGHT:
		return 0;
		break;
		case DIR.UP:
		return 90;
		break;
		case DIR.LEFT:
		return 180;
		break;
		case DIR.DOWN:
		return 270;
		break;
	}
	return undefined;
};

VectorArrayToDirection = function (_vec) {
	if (_vec[0] == 0) and (_vec[1] == 1) {
		return DIR.DOWN;
	}
	if (_vec[0] == 0) and (_vec[1] == -1) {
		return DIR.UP;
	}
	if (_vec[0] == 1) and (_vec[1] == 0) {
		return DIR.RIGHT;
	}
	if (_vec[0] == -1) and (_vec[1] == 0) {
		return DIR.LEFT;
	}
};

#region Curve Function
global.func_linear = function (paraX, paraArgs = [1, 0]) {
	var ARG_K = paraArgs[0];
	var ARG_B = paraArgs[1];
	
	return ARG_K * paraX + ARG_B;
};

global.func_sine_ext = function (paraX, paraArgs = [1, 0, 1]) {
	var ARG_K = paraArgs[0];
	var ARG_B = paraArgs[1];
	var ARG_X = paraArgs[2];
	
	return ARG_K * sin(ARG_X * paraX) + ARG_B;
};

global.func_cosine_ext = function (paraX, paraArgs = [1, 0, 1]) {
	var ARG_K = paraArgs[0];
	var ARG_B = paraArgs[1];
	var ARG_X = paraArgs[2];
	
	return ARG_K * cos(ARG_X * paraX) + ARG_B;
};
#endregion

#region Temporary Surface
global.TempSurface			= -1;
global.SurfaceSetTemporary	= function () {
	if (not surface_exists(global.TempSurface)) {
		global.TempSurface = surface_create(room_width, room_height);
	}
	else if (surface_get_width(global.TempSurface) != room_width or surface_get_height(global.TempSurface) != room_height) {
		surface_resize(global.TempSurface, room_width, room_height);
	}
	surface_set_target(global.TempSurface);
};
#endregion

// Code from YAL
// Link: https://yal.cc/gamemaker-variable-references-2023/
// Reference : Variable references in GameMaker (2023 edition)
function array_ref_create(_array, _index) {
    with ({
        __array: _array,
        __index: _index,
    }) return function() {
        if (argument_count > 0) {
            __array[@ __index] = argument0;
        } else return __array[__index];
    }
}

function variable_ref_create(_inst, _varname) {
    with ({
        __inst: _inst,
        __varname: _varname,
    }) return function() {
        if (argument_count > 0) {
            variable_instance_set(__inst, __varname, argument[0]);
        } else return variable_instance_get(__inst, __varname);
    }
}

// Class defination
///@param *params...

function Event() constructor {
	_currIndex = 0;
	_callbacks = {};
	Generator = function () {
		_currIndex ++;
		return _currIndex;
	};
	/*	This method will copy all the callbacks from source to destination.
		Usually it will refresh the key into regular number index, but if your
		callback's key starts with '*', it won't change the key and will override
		the one originally with the same key.
	*/
	AddEvent = function (paraEvent) {
		var tmpNames = struct_get_names(paraEvent._callbacks);
		var tmpLen = array_length(tmpNames);
		var curName;
		for (var i = 0; i < tmpLen; i ++) {
			curName = tmpNames[i];
			if (is_string(curName)) {
				if (string_copy(curName, 1, 1) == "*") {
					AddCallback(curName, variable_struct_get(paraEvent._callbacks, curName));
					continue;
				}
			}
			AddCallback(-1, variable_struct_get(paraEvent._callbacks, curName));
		}
	};
	AddCallback = function (paraKey, paraMethod) {
		var tmpKey = (paraKey == -1) ? Generator() : paraKey;
		variable_struct_set(_callbacks, tmpKey, paraMethod);
	};
	RemoveCallback = function (paraKey) {
		if (variable_struct_exists(_callbacks, paraKey)) {
			struct_remove(_callbacks, paraKey);
		}
	};
	Call = function (paraKey = -1) {
		var tmpNames = struct_get_names(_callbacks);
		var tmpParams = [];
		for (var i = 1; i < argument_count; i ++) {
			array_push(tmpParams, argument[i]);
		}
		if (paraKey == -1) {
			for (var i = 0; i < array_length(tmpNames); i ++) {
				method_call(variable_struct_get(_callbacks, tmpNames[i]), tmpParams);
			}
		}
		else {
			if (variable_struct_exists(_callbacks, paraKey)) {
				method_call(_callbacks[paraKey], tmpParams);
			}
		}
	};
	// Add callback argument
	// If you use this way to add callback, you can't add custom index for it
	if (argument_count != 0) {
		for (var i = 0; i < argument_count; i ++) {
			AddCallback(-1, argument[i]);
		}
	}
};

function Delegates() constructor {
	__callbacks = [];
	Call = function () {
		var tmpParams = [];
		for (var i = 0; i < argument_count; i ++) {
			array_push(tmpParams, argument[i]);
		}
		array_foreach(__callbacks, method({params : tmpParams}, function (curCallback, index) {
			method_call(curCallback, params);
		}));
	};
	Add = function (paraCallback) {
		array_push(__callbacks, paraCallback)
	};
}

#region Vector
Vector = {};
// Consts
Vector.Zero = new Vector2D(0, 0);
Vector.One	= new Vector2D(1, 1);
// Operators
Vector.Result = {};
Vector.Result.Add = function (paraVec1, paraVec2) {
	return paraVec1.Value().Add(paraVec2);
};
Vector.Result.Sub = function (paraVec1, paraVec2) {
	return paraVec1.Value().Sub(paraVec2);
};
Vector.Result.Mul = function (paraVec, paraVal) {
	return paraVec.Value().Mul(paraVal);
};
Vector.Result.Div = function (paraVec, paraVal) {
	return paraVec.Value().Div(paraVal);
};
// Polar coordinate constructor
Vector.Polar = function (paraAngle, paraLen = 1) {
	return (new Vector2D(lengthdir_x(paraLen, paraAngle), lengthdir_y(paraLen, paraAngle)));
};
// Constructor
function Vector2D(paraX, paraY) constructor {
	X = paraX;
	Y = paraY;
	// Operators
	Add = function (paraVal) {
		if (is_struct(paraVal)) {
			if (is_instanceof(paraVal, Vector2D)) {
				self.X += paraVal.X;
				self.Y += paraVal.Y;
			}
		}
		return self;
	};
	Div = function (paraVal) {
		if (is_struct(paraVal)) {
			if (is_instanceof(paraVal, Vector2D)) {
				self.X /= paraVal.X;
				self.Y /= paraVal.Y;
			}
		}
		else if (is_real(paraVal)) {
			self.X /= paraVal;
			self.Y /= paraVal
		}
		return self;
	};
	Mul = function (paraVal) {
		if (is_struct(paraVal)) {
			if (is_instanceof(paraVal, Vector2D)) {
				self.X *= paraVal.X;
				self.Y *= paraVal.Y;
			}
		}
		else if (is_real(paraVal)) {
			self.X *= paraVal;
			self.Y *= paraVal;
		}
		return self;
	};
	Sub = function (paraVal) {
		if (is_struct(paraVal)) {
			if (is_instanceof(paraVal, Vector2D)) {
				self.X -= paraVal.X;
				self.Y -= paraVal.Y;
			}
		}
		return self;
	};
	// Methods
	Value = function () {
		return (new Vector2D(X, Y));
	};
	Angle = function () {
		return point_direction(0, 0, X, Y);
	};
	Length = function () {
		return point_distance(0, 0, X, Y);
	};
	Clamp = function (paraMin, paraMax) {
		
	};
	Zero = function () {
		X = 0;
		Y = 0;
	};
	Resize = function (paraLen) {
		
	};
	Normalize = function () {
		var dir = self.Angle();
		X = lengthdir_x(1, dir);
		Y = lengthdir_y(1, dir);
	};
	Normalized = function () {
		var newVec = self.Value();
		newVec.Normalize();
		return newVec;
	};
	Polarized = function () {
		return {
			Length : self.Length(),
			Angle : self.Angle()
		};
	};
	Rotated = function (deltaAngle) {
		var oriVec = self.Polarized();
		return global.Vector.Polar(oriVec.Angle + deltaAngle, oriVec.Length);
	};
}
#endregion

#region Time
TimeAdapter = {};
TimeAdapter.ToSeconds = function (paraMs) {
	return round(paraMs / 1000000);
};
TimeAdapter.GetSeconds = function (paraMs) {
	return (global.TimeAdapter.ToSeconds(paraMs) mod 60);
};
TimeAdapter.GetMinutes = function (paraMs) {
	return ((global.TimeAdapter.ToSeconds(paraMs) - global.TimeAdapter.GetSeconds(paraMs)) mod 60)
};
TimeAdapter.GetUTSeconds = function (paraMs) {
	var tmpVal = string(global.TimeAdapter.ToSeconds(paraMs) mod 60);
	while (string_length(tmpVal) < 2) {
		tmpVal = "0" + tmpVal;
	}
	return tmpVal;
};
TimeAdapter.GetUTMinutes = function (paraMs) {
	var tmpVal = string(global.TimeAdapter.ToSeconds(paraMs) div 60);
	while (string_length(tmpVal) < 2) {
		tmpVal = "0" + tmpVal;
	}
	return tmpVal;
};
TimeAdapter.GetHours = function (paraMs) {
	return (global.TimeAdapter.ToSeconds(paraMs) div 3600);
};
#endregion

// Functions
function struct_copy(paraSrc, paraDest = {}) {
	var tmpNames = struct_get_names(paraSrc);
	var tmpLen = array_length(tmpNames);
	var curName;
	for (var i = 0; i < tmpLen; i ++) {
		curName = tmpNames[i];
		struct_set(paraDest, curName, variable_struct_get(paraSrc, curName));
	}
	return paraDest;
}

function val_in_range(paraVal, paraMin, paraMax) {
	return clamp(paraVal, paraMin, paraMax) == paraVal;
}

#region Matrix Extension
function linear_get_result(paraX0, paraY0, paraX1, paraY1, paraNX)
{
	var A, B;
	A = (paraY1 - paraY0) / (paraX1 - paraX0);
	B = paraY0 - A * paraX0;
	
	return A * paraNX + B;
}

function array_copy_simplified(paraDest, paraSrc)
{
	array_copy(paraDest, 0, paraSrc, 0, array_length(paraSrc));
}

function matrix_normalize(paraMatrix)
{
	var MAT_OUT = array_create(12, 0);
	
	for (var CR = 0; CR < array_length(paraMatrix); CR ++)
	{
		for (var CC = 0; CC < array_length(paraMatrix[0]); CC ++)
		{
			MAT_OUT[CR * 4 + CC] = paraMatrix[CR][CC];
		}
	}
	
	return MAT_OUT;
}

function matrix_multiple(paraMatrix, paraNum)
{
	for (var CUR_ROW = 0; CUR_ROW < array_length(paraMatrix); CUR_ROW ++)
	{
		for (var CUR_COL = 0; CUR_COL < array_length(paraMatrix[0]); CUR_COL ++)
		{
			paraMatrix[CUR_ROW][CUR_COL] *= paraNum;
		}
	}
}

function matrix_multiply_transpose(paraMat31, paraMat13)
{
	var A = paraMat31;
	var B = paraMat13;
	var NEW_MAT = [
	[A[0][0] * B[0][0], A[0][0] * B[0][1], A[0][0] * B[0][2]],
	[A[1][0] * B[0][0], A[1][0] * B[0][1], A[1][0] * B[0][2]],
	[A[2][0] * B[0][0], A[2][0] * B[0][1], A[2][0] * B[0][2]],
	];

	return NEW_MAT;
}

function matrix_get_transpose(paraMatrix)
{
	var NEW_MAT = [];
	for (var I = 0; I < array_length(paraMatrix[0]); I ++)
	{
		for (var J = 0; J < array_length(paraMatrix); J ++)
		{
			NEW_MAT[I][J] = paraMatrix[J, I];
		}
	}
	
	return NEW_MAT;
}

function rodrigues_rotation(paraVector, paraTheta)
{
	var RX, RY, RZ;
	RX = paraVector[0][0];
	RY = paraVector[0][1];
	RZ = paraVector[0][2];
	
	var THETA = degtorad(paraTheta);
	
	var MAT_EYE3 = [
			[1, 0, 0],
			[0, 1, 0],
			[0, 0, 1]];
	
	var M = [
			[0,		-RZ,	RY	],
			[RZ,	0,		-RX	],
			[-RY,	RX,		0	]];
		
	var R = [
			[1, 0, 0, 0],
		    [0, 1, 0, 0],
		    [0, 0, 1, 0],
		    [0, 0, 0, 1]]
	
	var MAT1 = [];
	array_copy_simplified(MAT1, MAT_EYE3);
	matrix_multiple(MAT1, cos(THETA));
	
	var MAT2 = matrix_multiply_transpose(matrix_get_transpose(paraVector), paraVector);
	matrix_multiple(MAT2, 1 - cos(THETA));
	
	var MAT3 = [];
	array_copy_simplified(MAT3, M);
	matrix_multiple(MAT3, sin(THETA));
	
	for (var CUR_ROW = 0; CUR_ROW < 3; CUR_ROW ++)
	{
		for (var CUR_COL = 0; CUR_COL < 3; CUR_COL ++)
		{
			R[CUR_ROW][CUR_COL] = MAT1[CUR_ROW][CUR_COL] + MAT2[CUR_ROW][CUR_COL] + MAT3[CUR_ROW][CUR_COL];
		}
	}
				
   return R
}
#endregion

function direction_flip(paraDir) {
	switch (paraDir) {
		case DIR.UP:
		return DIR.DOWN;
		break;
		case DIR.DOWN:
		return DIR.UP;
		break;
		case DIR.LEFT:
		return DIR.RIGHT;
		break;
		case DIR.RIGHT:
		return DIR.LEFT;
		break;
	}
}

function clamp_loop(paraVal, paraMin, paraMax) {
	if (paraVal < paraMin) then return paraMax;
	if (paraVal > paraMax) then return paraMin;
	return paraVal;
}

function draw_debug_message(valText, valLine)
{
	var BLEND_ORI = draw_get_color();
	var VALI_ORI = draw_get_valign();
	var HALI_ORI = draw_get_valign();
	var FONT_ORI = draw_get_font();
	
	draw_set_valign(fa_bottom);
	draw_set_halign(fa_left);
	draw_set_color(c_white);
	draw_set_font(fontFzxs9);
	
	draw_text_transformed(20, 40 + 20 * valLine, valText, 640 / window_get_width(), 480 / window_get_height(), 0);
	
	draw_set_valign(VALI_ORI);
	draw_set_halign(HALI_ORI);
	draw_set_color(BLEND_ORI);
	draw_set_font(FONT_ORI);
}