/// @desc Init
event_inherited();

depth = DEPTH_UI.PANEL - 50;

_target		= noone;
_name		= "";
_valueMin	= 0;
_valueMax	= 0;

Update = function () {};

Init = function (paraTarget, paraName, paraMin, paraMax, paraMethod) {
	_target = paraTarget;
	_name	= paraName;
	_valueMin = paraMin;
	_valueMax = paraMax;
	Update = paraMethod;
}