/*
if (keyboard_check(ord("B")))
{
	var INST= instance_create(0, 0, effectArcTracker);
	var BONE = boneCreate(mouse_x, mouse_y, BULLET_TYPE.WHITE, random(360), 10, 10);
	BONE._isBoneOut = true;
	
	INST._startX = BONE.x;
	INST._startY = BONE.y;
	INST._endX = room_width / 2;
	INST._endY = room_height / 2;
	INST._startAngle = random(360);
	INST._inst = BONE;
	BONE._trail = true;
	BONE._isBoneAutoDestroy = true;
	
	Anim_New(INST, "_timerAdder", ANIM_TWEEN.LINEAR, ANIM_EASE.IN, 0, 1, 360);

	with INST
	{
		event_user(0);
	}
}

if (keyboard_check_pressed(ord("C")))
{
	boneCreateCross(mouse_x, mouse_y, 4, 0);
}

if (keyboard_check_pressed(ord("S")))
{
	var STAR = instance_create(mouse_x, mouse_y, bulletStar);
	with STAR
	{
		_divGrade = 3;
		_divAngle = 135;
		_divNum	  = 4;
		_divAlarm = 60;
		_trail	  = true;
		direction = point_direction(x, y, battleSoul.x, battleSoul.y);
		speed	  = 0;
		event_user(1);
		Anim_Target(id, "speed", 2, 55);
	}
}

if (keyboard_check_pressed(ord("A")))
{
	//var ARROW = instance_create(mouse_x, mouse_y, bulletArrow);
	
	//with ARROW
	//{
	//	speed = 30;
	//	image_angle = point_direction(x, y, battleSoul.x, battleSoul.y);
	//	direction = point_direction(x, y, battleSoul.x, battleSoul.y);
	//}
	//spaceShootArrow(room_width / 2 + choose(-1, 1) * room_width / 2, mouse_y, mouse_x, mouse_y);
	spaceShootQuickArrow(room_width / 2 + choose(-1, 1) * room_width / 2, mouse_y, mouse_x, mouse_y, 30, 30);
}
*/