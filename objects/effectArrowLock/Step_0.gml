/// @desc Update
_counter += 1 / _time * 120;
_counterRotation += _spinDir * 1;

if _lockerAimAlpha < 1 and not _trigger
{
	_lockerAimAlpha += 1 / _time;
}

if _lockerAimOffset > _lockerAimOffsetEnd
{
	_lockerAimOffset += (_lockerAimOffsetEnd - _lockerAimOffsetStart) / _time;
}