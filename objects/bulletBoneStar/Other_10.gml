/// @desc
var BONE_CENTER = [x, y];
var BONE_ANGLE	= image_angle;
var SIDES	= _boneNum;
var SIZE	= _boneSize;
var ANGLE_ANGLE = 180 - 720 / SIDES;
var ANGLE_HALF = degtorad(ANGLE_ANGLE / 2);
var LEN_SIDE = cos(ANGLE_HALF) * SIZE;
var LEN_DIST = sin(ANGLE_HALF) * SIZE;
	
var CUR_ANGLE, CUR_POS, CUR_BONE;
for (var i = 0; i < SIDES; i ++) {
	CUR_ANGLE = BONE_ANGLE + i * 360 / SIDES;
		
	CUR_BONE = boneCreate(BONE_CENTER[0] + lengthdir_x(LEN_DIST, CUR_ANGLE),
					BONE_CENTER[1] + lengthdir_y(LEN_DIST, CUR_ANGLE),
					_boneMode, CUR_ANGLE + 90, LEN_SIDE, -1);
	
	CUR_BONE.depth = DEPTH.BOARD + 10;
	CUR_BONE._isBoneOut = true;
	array_push(_boneLst, CUR_BONE);
	//_boneSpinize(CUR_BONE, 1);
}

_created = true;

