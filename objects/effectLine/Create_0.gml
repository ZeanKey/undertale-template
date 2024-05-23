_xS = x;
_yS = y;
_xE = 320;
_yE = 240;

_isLockPoint = false;
_xD = 0;
_yD = 0;
_xA = 0;
_yA = 0;
_tA = 30;
_row = 0;
_col = 0;

_isBind = false;
_bindInst = noone;

_release = true;

SetLockPoint = function (paraRow, paraCol, paraTime, paraTween, paraEase) {
	var tPoint;
	_row = paraRow;
	_col = paraCol;
	
	tPoint = GetLockPoint();
	
	_xD = _xE - tPoint.xx;
	_yD = _yE - tPoint.yy;
	_isLockPoint = true;
	
	alarm[0] = paraTime;
	
	Anim_Target(id, "_xD", 0, paraTime, paraTween, paraEase);
	Anim_Target(id, "_yD", 0, paraTime, paraTween, paraEase);
};

GetLockPoint = function () {
	var tmpPoint;
	var tmpInst = self;
	with battleBoardCloth
	{
		tmpPoint = clothFindPoint(tmpInst._row, tmpInst._col);
	}
	return tmpPoint;
}

SetStartPoint = function (paramX, paramY) {
	_xS = paramX;
	_yS = paramY;
};

SetEndPoint = function (paramX, paramY) {
	_xE = paramX;
	_yE = paramY;
};

GetEndPoint = function () {
	return [_xE, _yE];
};

SetInstToEndPoint = function (paraInst) {
	paraInst.x = _xE;
	paraInst.y = _yE;
}

BindInstToEndPoint = function (paraInst) {
	_isBind = true;
	_bindInst = paraInst;
}

SetStartPointTarget = function (paramX, paramY, paraTime = 30, paraDelay = 0) {
	Anim_New(id, "_xS", ANIM_TWEEN.CUBIC, ANIM_EASE.OUT, _xS, paramX - _xS, paraTime, paraDelay);
	Anim_New(id, "_yS", ANIM_TWEEN.CUBIC, ANIM_EASE.OUT, _yS, paramY - _yS, paraTime, paraDelay);
};

SetEndPointTarget = function (paramX, paramY, paraTime = 30, paraDelay = 0) {
	Anim_New(id, "_xE", ANIM_TWEEN.CUBIC, ANIM_EASE.OUT, _xE, paramX - _xE, paraTime, paraDelay);
	Anim_New(id, "_yE", ANIM_TWEEN.CUBIC, ANIM_EASE.OUT, _yE, paramY - _yE, paraTime, paraDelay);
};

Destroy = function ()
{
	
	alarm[3] = 1;
	if point_distance(_xS, _yS, _xE, _yE) != 0
	{
		SetEndPointTarget(_xS, _yS, 30, 0);
		alarm[3] = 30;
	}
}