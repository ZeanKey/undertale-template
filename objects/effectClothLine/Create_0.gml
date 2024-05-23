image_blend = c_blue;

debugDraw = false;

_pointRenderEnable = false;
_isGenerated = false;
_instBind = noone;

_len = 15;

_kLimit = 15;

ToPointGeneral = function (paraX, paraY, paraTime = 30, paraDelay = 0, paraTween = ANIM_TWEEN.CUBIC, paraEase = ANIM_EASE.IN_OUT) {
	Anim_Target(id, "x", paraX, paraTime, paraTween, paraEase, paraDelay);
	Anim_Target(id, "y", paraY, paraTime, paraTween, paraEase, paraDelay);
}

Generate = function (paraNum, paraLen, paraInstBind) {
	h = paraNum;
	_len = paraLen;
	_instBind = paraInstBind;
	_isGenerated = true;
	event_user(0);
}

Bind = function (paraInstBind) {
	_instBind = paraInstBind;
}

function Point(xx, yy, locked = false) constructor {
	self.xx = xx;
	self.yy = yy;
	self.preX = xx;
	self.preY = yy;
	self.locked = locked;
	distanceToMouse = 0;
}

function Joint(pointA, pointB, ropeLength) constructor {
	self.pointA = pointA;
	self.pointB = pointB;
	self.ropeLength = ropeLength;
}

points = ds_list_create();
joints = ds_list_create();

grav = 0.4;

w = 1;
h = 10;

//ds_list_shuffle(points);
//ds_list_shuffle(joints);

nearestPoint = -1;
selectedPoint = -1;