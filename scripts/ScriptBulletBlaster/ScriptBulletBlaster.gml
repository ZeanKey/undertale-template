if (not variable_global_exists("__script_initialized")) then return true;

Bullet.Blaster = {};
var Blaster = Bullet.Blaster;

Blaster.Create = function (oX, oY, tX, tY, tDir, pause, xscale, yscale, mode = BULLET_TYPE.WHITE) {
	var inst = instance_create(oX, oY, bulletBlaster);
	inst.Init(oX, oY, tX, tY, tDir, pause, xscale, yscale, mode);
	return inst;
};

