/// @desc
if (not _created) then exit;

for (var INDEX = 0; INDEX < array_length(_boneLst); INDEX ++) {
	if (not instance_exists(_boneLst[INDEX])) {
		array_delete(_boneLst, INDEX, 1);
		INDEX --;
	}
}

if (array_length(_boneLst) == 0) {
	instance_destroy();
	exit;
}

var BONE_ANGLE	= image_angle;
var SIDES	= _boneNum;
var DES = (_binding) ? _isBoneAutoDestroy : true;

for (var i = 0; i < array_length(_boneLst); i ++) {
	var CUR_BONE = _boneLst[i];
	
	if (_binding) {
		CUR_BONE._starIndex = i;
	}
	
	var CUR_ANGLE = BONE_ANGLE + CUR_BONE._starIndex * 360 / SIDES;
	
	with (CUR_BONE) {
		image_angle = CUR_ANGLE + 90;
		direction = image_angle;
		depth = other.depth;
		_isBoneAutoDestroy = DES;
	}
}

if (not _binding) {
	exit;
}

var BONE_CENTER = [x, y];
var BONE_ANGLE	= image_angle;
var SIDES	= _boneNum;
var SIZE	= _boneSize;
var ANGLE_ANGLE = 180 - 720 / SIDES;
var ANGLE_HALF = degtorad(ANGLE_ANGLE / 2);
var LEN_SIDE = cos(ANGLE_HALF) * SIZE;
var LEN_DIST = sin(ANGLE_HALF) * SIZE;

for (var i = 0; i < SIDES; i ++) {
	var CUR_ANGLE = BONE_ANGLE + i * 360 / SIDES;
	
	if (i >= array_length(_boneLst)) {
		if (i == 0) {
			exit;
		}
		break;
	}
	var CUR_BONE = _boneLst[i]
	with (CUR_BONE) {
		x = BONE_CENTER[0] + lengthdir_x(LEN_DIST, CUR_ANGLE);
		y = BONE_CENTER[1] + lengthdir_y(LEN_DIST, CUR_ANGLE);
		image_angle = CUR_ANGLE + 90;
		_boneSize = LEN_SIDE * 2;
	}
	
	CUR_BONE._isBoneOut = true;
}

