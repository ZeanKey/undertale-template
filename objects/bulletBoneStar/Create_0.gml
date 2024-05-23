/// @desc
depth = DEPTH.BOARD + 10;
_binding = true;

_created = false;

_boneMode = BULLET_TYPE.WHITE;
_boneLst = [];
_boneNum = 5;
_boneSize = 10;

_isBoneAutoDestroy = false;

_spinSpd = 0;

Generate = function (paraSize, paraMode = BULLET_TYPE.WHITE, paraNum = 5) {
	_boneMode = paraMode;
	_boneSize = paraSize;
	_boneNum = paraNum;
};

Spin = function (paraSpd) {
	_spinSpd = paraSpd;
	animexecutor_create(self, "image_angle", LINEAR_FUNCTION, [paraSpd, image_angle], TIME_LIMIT.CONTINUOUS);
};

AnimResize = function (paraVal, paraTime, paraTween = ANIM_TWEEN.CUBIC, paraEase = ANIM_EASE.IN_OUT, paraDelay = 0) {
	Anim_Target(id, "_boneSize", paraVal, paraTime, paraTween, paraEase, paraDelay);
};

Shoot = function (paraAcc = 0.5) {
	_binding = false;
	var CUR_BONE;
	
	for (var INDEX = 0; INDEX < array_length(_boneLst); INDEX ++) {
		CUR_BONE = _boneLst[INDEX];
		with (CUR_BONE) {
			_autoDestroy = true;
			direction = image_angle;
			speed = degtorad(other._spinSpd) * other._boneSize;//point_distance(xprevious, yprevious, x ,y);
			animexecutor_create(self, "speed", LINEAR_FUNCTION, [paraAcc, speed], TIME_LIMIT.CONTINUOUS);
		}
	}
}

FakeShoot = function (paraSpd = 1) {
	_binding = false;
	var CUR_BONE;
	
	for (var INDEX = 0; INDEX < array_length(_boneLst); INDEX ++) {
		CUR_BONE = _boneLst[INDEX];
		with (CUR_BONE) {
			_autoDestroy = true;
			direction = image_angle;
			speed = degtorad(other._spinSpd) * other._boneSize;//point_distance(xprevious, yprevious, x ,y);
			Anim_Target(id, "speed", 3, 60);
			//animexecutor_create(id, "speed", SINE_FUNCTION, [2, 2, other._spinSpd / 180], TIME_LIMIT.CONTINUOUS);
		}
	}
}
