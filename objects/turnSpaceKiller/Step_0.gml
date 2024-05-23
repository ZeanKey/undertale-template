/// @desc Update
// Inherit the parent event
event_inherited();

if (SubPhases._index != 1) return;

if (_timer == 0) {
	var boardCenter = battleBoard.Figs.Center();
	with (battleSoul) {
		x = boardCenter[0];
		y = boardCenter[1];
	}
}

if (_timer == 1) then battle.Soul.Movenable = true;

#region Main
var bone		= global.Bullet.Bone;
var boneWall	= global.Bullet.BoneWall;
var blaster		= global.Bullet.Blaster;

if (_timer == 10) {
	var slash = instance_create_depth(320, 320, 0, bulletKillerSlash, { image_angle : 0 });
	slash.FinFn = function () {
		var box = instance_create(320, 355, battleBoardAddBox);
		box.Size = battleBoard.Main.Size.Value();
		box.Size.Y = 70;
		box.direction = -90;
		box.speed = -1;
		box._rotSpd = -1;
		battleBoard.Figs.Up = 35;
		battleBoard.Figs.Down = 35;
		battleBoard.Figs.Y = 285;
		_flag[0] = _timer + 20;
		var inst = instance_create(0, 0, battleBullet);
		inst._box = box;
		inst.Events.Step.AddCallback(-1, method(inst, function (inst) {
			if (not instance_exists(_box)) {
				instance_destroy();
				return;
			}
			_box.speed += 0.1;
			_box._rotSpd += 0.05;
			_box.image_angle += _box._rotSpd;
			if (_box.y > 600) {
				instance_destroy(_box);
			}
		}));
		screen.Shake(10, 8);
	}
}

if (_timer == _flag[0]) {
	_BoardHelper.SetInEase(50, 50, 50, 50, 30, new AnimCurveFormat(ANIM_TWEEN.CUBIC, ANIM_EASE.IN));
	Anim_Target(battleBoard.Figs, "Angle", 360, 100, ANIM_TWEEN.CUBIC, ANIM_EASE.IN_OUT, 20);
	Anim_Target(battleBoard.Figs, "Y", 320, 60, ANIM_TWEEN.CUBIC, ANIM_EASE.IN_OUT, 50);
}