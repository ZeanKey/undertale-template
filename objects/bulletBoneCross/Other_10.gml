///@desc Calling for spawning bone
_isBoneSpawned = true;

var BONE_DEL_ANGLE = 180 / _boneNum;

for (var COUNTER = 0; COUNTER < _boneNum; COUNTER ++) {
	array_push(_boneLst, boneCreate(x, y, _boneColor, image_angle + COUNTER * BONE_DEL_ANGLE, _boneLen, 30));
}

alarm[0] = 30;