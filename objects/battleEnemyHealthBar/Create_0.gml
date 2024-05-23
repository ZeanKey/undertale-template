/// @desc Init
depth		= DEPTH.BOARD - 10;
alarm[0]	= 60;

_isLaunched = false;

_barCurrent		= 1;
_barMax			= 1;
_barWidth		= 100;
_barHeight		= 13;

Set = function (paraMax, paraCurrent, paraTarget) {
	_barMax		= paraMax;
	_barCurrent	= paraCurrent;
	Anim_Target(id, "_barCurrent", paraTarget, 30);
};

Launch = function () {
	_isLaunched = true;
};

Destroy = function () {
	instance_destroy();
};