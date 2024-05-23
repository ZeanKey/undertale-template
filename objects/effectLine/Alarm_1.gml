
var tPoint = GetLockPoint();

tPoint.locked = true;

if _release
{
	alarm[2] = _tA;
}

battleBoardClothSetPointAnim(_row, _col, _xA, _yA, ANIM_TWEEN.CUBIC, ANIM_EASE.OUT, _tA, 0);
SetEndPointTarget(_xA, _yA, _tA, 0);