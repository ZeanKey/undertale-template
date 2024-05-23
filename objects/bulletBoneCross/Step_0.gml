_speedY += _accY;
_speedX += _accX;

x += _speedX;
y += _speedY;

image_angle += _spinSpd;

var PARENT = self;

if (_isBoneSpawned) {
	var INST_COUNTER = array_length(_boneLst);
	var BONE_DEL_ANG = 180 / INST_COUNTER;

	for (var COUNTER = 0; COUNTER < array_length(_boneLst); COUNTER ++) {
		var CUR_BONE = _boneLst[COUNTER];
	
		if (not instance_exists(CUR_BONE)) {
			INST_COUNTER -= 1;
		}
		
		var CUR_ANGLE = BONE_DEL_ANG * COUNTER + image_angle;
		
		CUR_BONE.image_angle = CUR_ANGLE;
		CUR_BONE.x = x;
		CUR_BONE.y = y;
		CUR_BONE._isBoneOut = _isBoneOut;
		//show_debug_message(x);
		
		if (PARENT._isBoneLengthed) {
			CUR_BONE._boneSize = PARENT._boneLen * 2 + 10;
		}
	
	}
	
	if (INST_COUNTER == 0) {
		instance_destroy();
	}
}