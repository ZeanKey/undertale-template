/// @desc 
if _isLockPoint
{
	var tPoint = GetLockPoint();
	_xE = tPoint.xx + _xD;
	_yE = tPoint.yy + _yD;
}

if _isBind
{
	SetInstToEndPoint(_bindInst);
}