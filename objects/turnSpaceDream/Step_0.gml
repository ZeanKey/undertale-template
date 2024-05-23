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

var Bone = global.Bullet.Bone;
var BoneWall = global.Bullet.BoneWall;

if (_timer == 1) {
	battle.Soul.Change(SOUL_MODE.BLUE);
	_entitySans.HandDown();
	_flag[0] = _timer + 60;
	_flag[1] = _timer + 10;
	_flag[2] = _timer + 40;
	_flag[3] = _timer + 120;
	_sign = 1;
	_flag[4] = _timer + 10;
	_flag[5] = _timer + 70;
}

if (_timer == _flag[4]) {
	_bone[0] = BoneWall.Create(20, BoneWall.PosConfigGenFill(320, 320 - 65, 130, 0, 1), -90, BULLET_TYPE.WHITE, true, BoneWall.Configs.Regular);
	_bone[1] = BoneWall.Create(20, BoneWall.PosConfigGenFill(320, 320 + 65, 130, 0, 1), +90, BULLET_TYPE.WHITE, true, BoneWall.Configs.Regular);
	_bone[0].WarningExpand(20, 5);
	_bone[1].WarningExpand(20, 5);
	_boneX0 = 500;
	Anim_Target(id, "_boneX0", 0, 500, ANIM_TWEEN.LINEAR, ANIM_EASE.IN);
	
	_flag[5] = _timer + 60;
	_duration[0] = [_timer, _timer + 9999];
}

if (_timer == _flag[5]) {
	battle.Soul.Change(SOUL_MODE.RED);
	var blaster = instance_create(-100, 300, bulletBlaster);
	blaster.Init(-100, 300, 200, 300, 0, 30, 2, 2);

	_boneX1 = 640;
	_boneX2 = 0;
	
	_duration[1] = [_timer, _timer + 9999];
	_duration[2] = [_timer, _timer + 9999];
	_duration[3] = [_timer + 100, _timer + 9999];
	_flag[6] = _duration[2][0];
	_flag[7] = _duration[3][0];
}

if (_timer == _flag[6]) {
	Anim_Target(id, "_boneX1", 0, 480, ANIM_TWEEN.LINEAR, ANIM_EASE.IN);
}

if (_timer == _flag[7]) {
	Anim_Target(id, "_boneX2", 640, 640, ANIM_TWEEN.LINEAR, ANIM_EASE.IN);
	
	_flag[8] = _timer + 400;
	_duration[1][1] = _timer + 300;
}

if (_timer == _flag[8]) {
	_bone[0].Collapse(10);
	_bone[1].Collapse(10);
	
	_flag[9] = _timer + 30;
	_BoardHelper.SetInEase(120, 120, 65, 65, 30);
}

if (_timer == _flag[9]) {
	battle.Soul.Change(SOUL_MODE.BLUE);
	//spaceAnimLeft();
	_plate[0] = instance_create_depth(240, 200, 0, battlePlatePurple);
	with (_plate[0]) {
		image_xscale = 8;
		image_angle = 0;
		Anim_Target(id, "y", 320, 30);
		_isShoot = false;
	}
	
	_plate[1] = instance_create_depth(320, 200, 0, battlePlatePurple);
	with (_plate[1]) {
		image_xscale = 8;
		image_angle = 0;
		Anim_Target(id, "y", 320, 30);
		_isShoot = false;
	}
	
	_plate[2] = instance_create_depth(400, 200, 0, battlePlatePurple);
	with (_plate[2]) {
		image_xscale = 8;
		image_angle = 0;
		Anim_Target(id, "y", 320, 30);
		_isShoot = false;
	}
	
	_boneDeltaY = 0;
	
	_flag[10] = _timer + 60;
	_duration[4] = [_timer, _timer + 9999];
}

#region Plate Crush Collision Code
// Why we can't add delegates to original GML event.()
if (instance_exists(_plate[1])) {
	with (_plate[1]) {
		if (_isShoot == false) {
			if (place_meeting(x, y, bulletArrow)) {
				direction = -90;
				speed = 0;
				_isShoot = true;
				_dir = choose(-1, 1);
			}
			
		}
		else {
			speed += 0.5;
			image_angle += speed * _dir;
			image_alpha -= 0.01;
			if (image_alpha < 0) {
				image_alpha = 0;
			}
		}
		
		if (y > 740) or (y < -100) {
			instance_destroy();
		}
	}
}

if (instance_exists(_plate[2])) {
	with (_plate[2]) {
		if (_isShoot == false) {
			if (place_meeting(x, y, bulletArrow)) {
				direction = -90;
				speed = -5;
				_isShoot = true;
				_dir = choose(-1, 1);
			}
			
		}
		else {
			speed += 0.5;
			image_angle += speed * _dir;
			image_alpha -= 0.01;
			if (image_alpha < 0) {
				image_alpha = 0;
			}
		}
		
		if (y > 740) or (y < -100) {
			instance_destroy();
		}
	}
}

if (instance_exists(_plate[0])) {
	with (_plate[0]) {
		if (_isShoot == false) {
			if (place_meeting(x, y, bulletArrow)) {
				direction = -90;
				speed = -5;
				_isShoot = true;
				_dir = choose(-1, 1);
			}
			
		}
		else {
			speed += 0.5;
			image_angle += speed * _dir;
			image_alpha -= 0.01;
			if (image_alpha < 0) {
				image_alpha = 0;
			}
		}
		
		if (y > 740) or (y < -100) {
			instance_destroy();
		}
	}
}
#endregion

if (_timer == _flag[10]) {
	_bone[2] = Bone.CreateCross(150, 340, 45, 80, 2);
	with (_bone[2])
	{
		direction = 0;
		speed = 2;
		
		Anim_New(id, "image_angle", ANIM_TWEEN.LINEAR, ANIM_EASE.IN, 45, -3000, 1000);
	}
	
	spaceShootQuickArrow(320, 0, 320, 320, 90, 30);
	
	_flag[11] = _timer + 120;
}

if _timer == _flag[11]
{
	spaceShootQuickArrow(240, 480, 240, 320, 90, 30);
	spaceShootQuickArrow(400, 480, 400, 320, 90, 30);
	
	_duration[4][1] = _timer + 240;
	_flag[12] = _timer + 90;
}

if _timer == _flag[12]
{
	Anim_Target(id, "_boneDeltaY", 50, 60, ANIM_TWEEN.CUBIC, ANIM_EASE.IN_OUT);
	
	_flag[13] = _timer + 90;
}

if (_TurnInDuration(1)) {
	if (_timer % 60 == 0) {
		for (var COUNTER = 10; COUNTER < 100; COUNTER += 49) {
			_SpaceCreateStar(320 - (50 + 320) * _sign, 320 + irandom_range(-1, 1) * 45, 0, 1, 30, 5 * _sign, 80, 4);
			_sign *= -1;
		}
	}
	
	if (_timer % 120 == 0) {
		spaceShootArrow(room_width / 2 + choose(-1, 1) * room_width / 2, battleSoul.y, battleSoul.x, battleSoul.y);
	}
}

if (_TurnInDuration(4)) {
	if _timer % 4 == 0
	{
		var B_U = Bone.CreateRegular(_boardMidX() - 200, 320 - 65, 90, 20);
		
		B_U.direction = 0;
		B_U.speed = 5;
	
		B_U._mark = "3_U"
		
		var B_D = Bone.CreateRegular(_boardMidX() + 200, 320 - 65, 90, 20);
	
		B_D.direction = 180;
		B_D.speed = 5;
	
		B_D._mark = "3_D"
	}
}

//Mark Bone Create

with (battlePlate) {
	_edge = 100;
	if (x < -_edge) or (x > room_width + _edge) or (y < -_edge) or (y > room_height + _edge) {
		instance_destroy();
	}
}

if _timer == _flag[13]
{
	instance_destroy(battleSoul);
	
	_BoardHelper.SetInEase(283, 283, 65, 65, 60);
	_flag[14] = _timer + 90;
}

if _timer == _flag[14]
{
	instance_destroy();
}

#endregion

#region Permenent

if _TurnInDuration(0)
{
	if _timer % 40 == 0
	{
		var B = Bone.CreateRegular(120, 500, 0, 10);
	
		B.direction = 0;
		B.speed = 2;
	
		B._mark = "0"
		B._isBoneAutoDestroy = true;
	}
}

if _TurnInDuration(1)
{
	if _timer % 40 == 0
	{
		var B = Bone.CreateRegular(640, 100, 90, 10);
		
		B.direction = -90;
		B.speed = 2;
	
		B._mark = "1"
	}
}

if _TurnInDuration(2)
{
	if _timer % 40 == 0
	{
		var B = Bone.CreateRegular(0, 100, 90, 10);
		
		B.direction = -90;
		B.speed = 2;
	
		B._mark = "2"
	}
}

var TURN_INST = self;
	
with (bulletBone) {
	if variable_instance_exists(id, "_mark")
	{
		if _mark == "0"
		{
			y = TURN_INST._boneX0;
		}
		else if _mark == "1"
		{
			x = TURN_INST._boneX1;
		}
		else if _mark == "2"
		{
			x = TURN_INST._boneX2;
		}
		else if _mark == "3_U"
		{
			y = 320 - 65 - TURN_INST._boneDeltaY;
		}
		else if _mark == "3_D"
		{
			y = 320 + 65 + TURN_INST._boneDeltaY;
		}
	}
}

#endregion