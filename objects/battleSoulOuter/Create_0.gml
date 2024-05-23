// Inherit the parent event
event_inherited();

EDGE = 480;

function Velocity() constructor {
	self.spdX = 0;
	self.spdY = 0;
	
	self.Zero = function () {
		self.spdX = 0;
		self.spdY = 0;
	};
	
	self.Length = function () {
		return point_distance(0, 0, self.spdX, self.spdY);
	}
	
	self.Polarize = function () {
		return [point_distance(0, 0, self.spdX, self.spdY),
				point_direction(0, 0, self.spdX, self.spdY)];
	};
	
	self.Add = function (paraX, paraY) {
		self.spdX += paraX;
		self.spdY += paraY;
	};
	
	self.AddArray = function (paraArray) {
		self.spdX += paraArray[0];
		self.spdY += paraArray[1];
	};
	
	self.AddPolar = function (paraLen, paraDir) {
		self.spdX += lengthdir_x(paraLen, paraDir);
		self.spdY += lengthdir_y(paraLen, paraDir);
	}
	
	self.AddPolarArray = function (paraArray) {
		self.spdX += lengthdir_x(paraArray[0], paraArray[1]);
		self.spdY += lengthdir_y(paraArray[0], paraArray[1]);
	}
	
	self.Normalize = function () {
		var CURRENT = self.Polarize();
		CURRENT[0] = 1;
		self.Zero();
		self.AddPolarArray(CURRENT);
	}
	
	self.NormalizeExt = function (paraLen) {
		var CURRENT = self.Polarize();
		CURRENT[0] = paraLen;
		self.Zero();
		self.AddPolarArray(CURRENT);
	}
	
	self.AddLen = function (paraLen) {
		var CURRENT = self.Polarize();
		CURRENT[0] = paraLen;
		self.AddPolarArray(CURRENT);
	}
}

SoulMode = SOUL_MODE.BLUE;

_vecPrint = [];
_spdJump = 3;
_velocity = new Velocity();
_pressure = false;

CONST_G = 5;
CONST_M = 1;

_planetMax = 0;
_planetCur = noone;

ApplyGravity = function (paraInst) {
	var RADIUS = point_distance(x, y, paraInst.x, paraInst.y);
	var DIRECT = point_direction(x, y, paraInst.x, paraInst.y);
	var ACCEL = other.CONST_G * CONST_G * CONST_M / sqr(RADIUS);
	
	if (ACCEL > _planetMax) {
		_planetMax = ACCEL;
		_planetCur = paraInst;
	}
	
	_velocity.AddPolarArray([ACCEL, DIRECT]);
}

SumGravity = function () {
	if (_velocity.Length() > 10) {
		_velocity.NormalizeExt(10);
	}
	
	if (_planetCur != noone) {
		image_angle = point_direction(x, y, _planetCur.x, _planetCur.y) + 90;
	}
	
	_planetCur = noone;
	_planetMax = 0;
}

PlanetLimit = function () {
	with (battleBoardOuter) {
		var CUR_DIR, CUR_LEN;
		CUR_DIR = point_direction(x, y, other.x, other.y);
		CUR_LEN = point_distance(x, y, other.x, other.y);
		
		if (CUR_LEN < image_xscale / 2 + other.sprite_width / 2) {
			other.x = x + lengthdir_x(image_xscale / 2 + other.sprite_width / 2, CUR_DIR);
			other.y = y + lengthdir_y(image_xscale / 2 + other.sprite_width / 2, CUR_DIR);
			other._velocity.Zero();
		}
	}
}

IsEdgeMeetingBoard = function (paraFaceDirEnum, paraEdge = 1) {
	var EDGE_X, EDGE_Y;
	switch (paraFaceDirEnum) {
		case DIR.LEFT:
		EDGE_X = x + lengthdir_x(sprite_width / 2 + paraEdge, 180 + image_angle);
		EDGE_Y = y + lengthdir_y(sprite_width / 2 + paraEdge, 180 + image_angle);
		break;
		case DIR.RIGHT:
		EDGE_X = x + lengthdir_x(sprite_width / 2 + paraEdge, image_angle);
		EDGE_Y = y + lengthdir_y(sprite_width / 2 + paraEdge, image_angle);
		break;
		case DIR.UP:
		EDGE_X = x + lengthdir_x(sprite_height / 2 + paraEdge, 90 + image_angle);
		EDGE_Y = y + lengthdir_y(sprite_height / 2 + paraEdge, 90 + image_angle);
		break;
		case DIR.DOWN:
		EDGE_X = x + lengthdir_x(sprite_height / 2 + paraEdge, 270 + image_angle);
		EDGE_Y = y + lengthdir_y(sprite_height / 2 + paraEdge, 270 + image_angle);
		break;
		default:
		return false;
	}
	
	if IsPositionCollideFrame(EDGE_X, EDGE_Y) return true;
	
	var RESULT = false;
	with (battleBoardOuter) {
		var CUR_LEN;
		CUR_LEN = point_distance(x, y, EDGE_X, EDGE_Y);
		
		if (CUR_LEN <= image_xscale / 2) {
			RESULT = true;
		}
	}
	
	if RESULT return RESULT;
	
	return false;
}

IsEdgeMeetingPlate = function (paraFaceDirEnum) {
	var EDGE_X, EDGE_Y;
	switch (paraFaceDirEnum) {
		case DIR.LEFT:
		EDGE_X = x + lengthdir_x(sprite_width / 2 + 1, 180 + image_angle);
		EDGE_Y = y + lengthdir_y(sprite_width / 2 + 1, 180 + image_angle);
		break;
		case DIR.RIGHT:
		EDGE_X = x + lengthdir_x(sprite_width / 2 + 1, image_angle);
		EDGE_Y = y + lengthdir_y(sprite_width / 2 + 1, image_angle);
		break;
		case DIR.UP:
		EDGE_X = x + lengthdir_x(sprite_height / 2 + 1, 90 + image_angle);
		EDGE_Y = y + lengthdir_y(sprite_height / 2 + 1, 90 + image_angle);
		break;
		case DIR.DOWN:
		EDGE_X = x + lengthdir_x(sprite_height / 2 + 1, 270 + image_angle);
		EDGE_Y = y + lengthdir_y(sprite_height / 2 + 1, 270 + image_angle);
		break;
		default:
		return false;
	}
	
	if position_meeting(EDGE_X, EDGE_Y, battlePlate) return true;
	
	return false;
}