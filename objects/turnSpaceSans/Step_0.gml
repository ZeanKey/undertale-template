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

if (_timer == 2) {
	battle.Soul.Change(SOUL_MODE.BLUE);
}

if (_timer == 10) {
	// Enemy - Gravity Impact Down
	_entitySans.HandDown();
	
	// Attack - Crossbone
	_bone[0] = bone.CreateCross(320, 400, 90, 30, 2, BULLET_TYPE.BLUE);
	with (_bone[0]) {
		image_angle -= 15;
		direction = 90;
		speed = 6;
		_spdY = 0;
	
		Events.Step.AddCallback(-1, function (bullet) {
			with (bullet) {
				image_angle += 3;
				speed += _spdY;
				_spdY -= 0.02;
			}
		});
	}
	
	// Attack - Rolling Bonewall Init
	_boneMid = 120;
	
	_flag[0] = _timer + 40;
	_duration[0] = [_timer + 20, _timer + 9999];
}

if (_timer == _flag[0]) {
	// Box - Resize
	Anim_Target(battleBoard.Figs, "Up", 60, 60, ANIM_TWEEN.CUBIC, ANIM_EASE.IN_OUT);
	Anim_Target(battleBoard.Figs, "Down", 60, 60, ANIM_TWEEN.CUBIC, ANIM_EASE.IN_OUT);
	
	_flag[1] = _timer + 30;
}

if (_TurnInDuration(0)) {
	// Attack - Rolling Bonewall Up & Down
	if (_timer % 6 == 0) {
		with (bone.CreateRegular(10, battleBoard.BoxGetCenter()[1] - _boneMid / 2, 90, 10)) {
			direction = 0;
			speed = 6;
			Turn = other;
			Events.Step.AddCallback(-1, function (bullet) { 
				if (Turn._TurnInDuration(2)) {
					bullet.y = battleBoard.BoxGetCenter()[1] - Turn._boneMid / 2 - Turn._deltaBoneY;
				}
			})
		}
		
		with (bone.CreateRegular(630, battleBoard.BoxGetCenter()[1] + _boneMid / 2, 90, 10)) {
			direction = 180;
			speed = 6;
			Turn = other;
			Events.Step.AddCallback(-1, function (bullet) { 
				if (Turn._TurnInDuration(2)) {
					bullet.y = battleBoard.BoxGetCenter()[1] + Turn._boneMid / 2 + Turn._deltaBoneY;
				}
			})
		}
	}
}

if (_timer == _flag[1]) {
	_plate[0] = instance_create_depth(320, 500, 0, battlePlateGreen);
	_plate[0].image_xscale = 15;
	
	Anim_Target(_plate[0], "y", 350, 60, ANIM_TWEEN.CUBIC, ANIM_EASE.IN_OUT);
	
	_flag[2] = _timer + 60;
}

if (_timer == _flag[2]) {
	// Attack - Gaster Blaster
	blaster.Create(-100, 330, 200, 330, 0, 10, 2, 1);
	
	// Box - Resize & Motion
	Anim_Target(battleBoard.Figs, "X", 500, 120, ANIM_TWEEN.CUBIC, ANIM_EASE.IN_OUT);
	Anim_Target(battlePlateGreen, "x", 500, 120, ANIM_TWEEN.CUBIC, ANIM_EASE.IN_OUT);
	
	_flag[3] = _timer + 120;
}

if (_timer == _flag[3]) {
	Anim_Target(battleBoard.Figs, "Left", 60, 60, ANIM_TWEEN.CUBIC, ANIM_EASE.IN_OUT);
	Anim_Target(battleBoard.Figs, "Right", 60, 60, ANIM_TWEEN.CUBIC, ANIM_EASE.IN_OUT);
	Anim_Target(battleBoard.Figs, "X", 100, 480, ANIM_TWEEN.SINE, ANIM_EASE.IN_OUT);
	
	_duration[1] = [_timer, _timer + 480];
	_duration[0][1] = _duration[1][1] + 100;
	_flag[4] = _timer + 0;
	_flag[5] = _duration[1][1];
	_flag[6] = _timer + 460;
}

if (_TurnInDuration(1)) {
	if (_timer < _duration[1][0] + 60) {
		if (_timer % 30 == 0) then _MakeBoneTwoV(_boardMidX() + 100, 320, -3, 20);
	}
	
	if (_timer == _duration[1][0] + 120) {
		_bone[1] = bone.CreateCross(_boardMidX() - 100, 500, 0, 20, 2, BULLET_TYPE.BLUE);
		_bone[1].direction = 90;
		_bone[1].speed = 3;
		_bone[1].Events.Step.AddCallback(-1, function (bullet) { bullet.image_angle -= 2; });
	}
	
	if (_timer % 40 == 0) {
		with (bone.CreateRegular(320, 200, 90, 20, 0)) { image_angle = -90; speed = 2 };
		with (bone.CreateRegular(270, 450, 90, 20, 0)) { image_angle = -90; speed = 2 };
		with (bone.CreateRegular(370, 450, 90, 20, 0)) { image_angle = -90; speed = 2 };
	}
}

if (_timer == _flag[4]) {
	Anim_Target(battlePlateGreen, "x", 100, 480, ANIM_TWEEN.SINE, ANIM_EASE.IN_OUT);
}

if (_timer == _flag[5]) {
	_deltaBoneY = 0;
	Anim_Target(id, "_deltaBoneY", 200, 120, ANIM_TWEEN.CUBIC, ANIM_EASE.IN_OUT);
	_boneLst = boneWall.Create(20, boneWall.PosConfigGenFill(40, 320, 130, 90, 1), 0, BULLET_TYPE.WHITE, true, boneWall.Configs.Regular);
	_boneLst.WarningExpand(20, 5);

	_duration[2] = [_timer, _timer + 200];
}

if (_timer == _flag[7]) {
	Anim_Target(battlePlateGreen, "x", 200, 50, ANIM_TWEEN.LINEAR, ANIM_EASE.IN);
	Anim_Target(battlePlateGreen, "y", 700, 50, ANIM_TWEEN.EXPO, ANIM_EASE.IN);
	Anim_Target(battlePlateGreen, "image_angle", 700, 50, ANIM_TWEEN.EXPO, ANIM_EASE.IN);
	
}

if (_timer == _flag[6]) {
	_entitySans.HandLeft();
	_flag[7] = _timer + 10;
	_flag[8] = _timer + 70;
	_flag[9] = _timer + 80;
}

if (_timer == _flag[9]) {
	_boneLst.Collapse(10);
	Anim_Target(battleBoard.Figs, "X", 320, 240, ANIM_TWEEN.CUBIC, ANIM_EASE.IN_OUT);
	battleSoul.image_angle = 0;
	audio_play_sound(sndDing, 0, 0);
}

if (_timer == _flag[8]) {
	blaster.Create(700, 320, 500, 320, 180, 10, 2, 2);
	_flag[10] = _timer + 90;
}

if (_timer == _flag[10]) {
	_MakeBoneSide(DIR.DOWN, 440, 70, 180, 2, BULLET_TYPE.BLUE);
	_MakeBoneSide(DIR.DOWN, 540, 20, 180, 2, BULLET_TYPE.WHITE);
	
	_flag[11] = _timer + 240;
}

if (_timer == _flag[11]) {
	instance_destroy(battleSoul);
	_BoardHelper.SetInEase(283, 283, 65, 65, 60);
	
	_flag[12] = _flag[11] + 90;
}

if (_timer == _flag[12]) then instance_destroy();

#endregion