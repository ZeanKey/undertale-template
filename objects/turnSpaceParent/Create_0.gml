/// @desc Init
_SpaceCreateStar = function (paraX, paraY, paraDir, paraTimes, paraAlarm, paraSpeed, paraDivAngle, paraDivNum)
{
	var STAR = instance_create(paraX, paraY, bulletDreamStar);
	with STAR
	{
		_divGrade = paraTimes;
		_divAngle = paraDivAngle;
		_divNum	  = paraDivNum;
		_divAlarm = paraAlarm;
		_trail	  = true;
		direction = paraDir;
		speed	  = 0;
		if (not paraAlarm <= 0) then event_user(1);
		Anim_Target(id, "speed", paraSpeed, paraAlarm);
	}
	
	return STAR;
}

_MakeBoneSide = function (side, posArg, length, dir = 0, spd = 0, mode = 0) {
	var posX = posArg;
	var posY = posArg;
	var rot  = 0;
	switch (side) {
		case DIR.LEFT:
		rot = 0;
		posX = battleBoard.Figs.X - battleBoard.Figs.Left;
		break;
		case DIR.RIGHT:
		rot = 180;
		posX = battleBoard.Figs.X + battleBoard.Figs.Right;
		break;
		case DIR.UP:
		rot = -90;
		posY = battleBoard.Figs.Y - battleBoard.Figs.Up;
		break;
		case DIR.DOWN:
		rot = 90;
		posY = battleBoard.Figs.Y + battleBoard.Figs.Down;
		break;
	}
	var inst = global.Bullet.Bone.CreateRegular(posX, posY, rot, length, mode, BONE_ORIGIN.SIDE, true);
	inst.direction = dir;
	inst.speed = spd;
	return inst;
}

_MakeBoneTwoV = function (posX, posY, spd, gap) {	
	_MakeBoneSide(DIR.UP,	posX, abs(posY - battleBoard.Figs.Y + battleBoard.Figs.Up - 2 - gap),	0, spd, 0);
	_MakeBoneSide(DIR.DOWN, posX, abs(battleBoard.Figs.Y + battleBoard.Figs.Down - 2 - gap - posY),	0, spd, 0);
}

_boardMidY = function () {
	return battleBoard.Figs.Center()[1];
}

_boardMidX = function () {
	return battleBoard.Figs.Center()[0];
}

_BoardHelper = {};
_BoardHelper._defaultAnimFormat = new AnimCurveFormat(0, 0);

_BoardHelper.Reset = function () {
	
};

_BoardHelper.ResetInEase = function () {
	
	
};

_BoardHelper.SetInEase = function (lenL, lenR, lenU, lenD, time, animformat = _BoardHelper._defaultAnimFormat) {
	Anim_Target(battleBoard.Figs, "Left",	lenL, time, animformat.Tween, animformat.Ease);
	Anim_Target(battleBoard.Figs, "Right",	lenR, time, animformat.Tween, animformat.Ease);
	Anim_Target(battleBoard.Figs, "Up",		lenU, time, animformat.Tween, animformat.Ease);
	Anim_Target(battleBoard.Figs, "Down",	lenD, time, animformat.Tween, animformat.Ease);
};

_TurnInDuration = function (durIdx) {
	return (_timer >= _duration[durIdx][0]) and (_timer <= _duration[durIdx][1])
}

// Inherit the parent event
event_inherited();
