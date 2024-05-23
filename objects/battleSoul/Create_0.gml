/// @desc Initialized & Functions
enum SIDE_MARK {
	INNER = 0,
	OUTER = 1
}

depth = DEPTH.SOUL;
image_speed = 0;

SoulMode = undefined;

_sideMark = SIDE_MARK.INNER;

GetInputVector = function () {
	return new Vector2D(
		input_check(INPUT.RIGHT) - input_check(INPUT.LEFT),
		input_check(INPUT.DOWN) - input_check(INPUT.UP)
	);
}

GetInput = function () {
	var VEC_INPUT = [0, 0];
	if (keyboard_check(vk_up)) {
		VEC_INPUT[1] += -1;
	}
	if (keyboard_check(vk_down)) {
		VEC_INPUT[1] += 1;
	}
	if (keyboard_check(vk_left)) {
		VEC_INPUT[0] += -1;
	}
	if (keyboard_check(vk_right)) {
		VEC_INPUT[0] += 1;
	}
	return VEC_INPUT;
};

GetInputPolar = function () {
	var VEC_INPUT = [0, 0];
	var POLAR_INPUT = [0, 0];
	if (keyboard_check(vk_up)) {
		VEC_INPUT[1] += -1;
	}
	if (keyboard_check(vk_down)) {
		VEC_INPUT[1] += 1;
	}
	if (keyboard_check(vk_left)) {
		VEC_INPUT[0] += -1;
	}
	if (keyboard_check(vk_right)) {
		VEC_INPUT[0] += 1;
	}
	POLAR_INPUT[0] = point_distance(0, 0, VEC_INPUT[0], VEC_INPUT[1]);
	POLAR_INPUT[1] = point_direction(0, 0, VEC_INPUT[0], VEC_INPUT[1]);
	return POLAR_INPUT;
};

PositionFix = function () {
	//x = round(x);
	//y = round(y);

	var STEP = 1;
	
	while (PointCollidesFrame(x + sprite_width / 2, y))
	{
		x -= STEP;
	}
	while (PointCollidesFrame(x - sprite_width / 2, y))
	{
		x += STEP;
	}
	while (PointCollidesFrame(x, y + sprite_height / 2))
	{
		y -= STEP;
	}
	while (PointCollidesFrame(x, y - sprite_height / 2 ))
	{
		y += STEP;
	}
};

GetPosSidePos = function (posX, posY, dir, capacity) {
	var detectX, detectY;
	detectX = posX + lengthdir_x(sprite_width / 2 + capacity, image_angle + global.DirectionToAngle(dir));
	detectY = posY + lengthdir_y(sprite_width / 2 + capacity, image_angle + global.DirectionToAngle(dir));
	return new Vector2D(detectX, detectY);
};

GetSidePos = function (dir, capacity) {
	var detectX, detectY;
	detectX = x + lengthdir_x(sprite_width / 2 + capacity, image_angle + global.DirectionToAngle(dir));
	detectY = y + lengthdir_y(sprite_width / 2 + capacity, image_angle + global.DirectionToAngle(dir));
	return new Vector2D(detectX, detectY);
};

PointCollidesFrame = function (posX, posY) {
	var result = false;
	if (collision_point(posX, posY, battleBoardSubtract, 1, 1)) {
		result = true;
	}
	else if (collision_point(posX, posY, battleBoardAdd, 1, 1)) {
		result = false;
	}
	else if (collision_point(posX, posY, battleBoardFrame, 1, 1)) {
		result = true;
	}
	return result;
};

SideCollidesFrame = function (posX, posY, dir, capacity = 0) {
	var detectX, detectY;
	detectX = posX + lengthdir_x(sprite_width / 2 + capacity, image_angle + global.DirectionToAngle(dir));
	detectY = posY + lengthdir_y(sprite_width / 2 + capacity, image_angle + global.DirectionToAngle(dir));
	
	var result = false;
	if (collision_point(detectX, detectY, battleBoardSubtract, 1, 1)) {
		result = true;
	}
	else if (collision_point(detectX, detectY, battleBoardAdd, 1, 1)) {
		result = false;
	}
	else if (collision_point(detectX, detectY, battleBoardFrame, 1, 1)) {
		result = true;
	}
	return result;
};

EdgeCollidesFrame = function (posX, posY, capacity = 0) {
	for (var i = 0; i < 4; i ++) if (SideCollidesFrame(posX, posY, i, capacity)) then return true;
	return false;
};

SideCollidedFrame = function (dir, capacity = 0) {
	return SideCollidesFrame(x, y, dir, capacity);
};

EdgeCollidedFrame = function (capacity = 0) {
	return EdgeCollidesFrame(x, y, capacity);
};

PointCollidesPlate = function (posX, posY) {
	return collision_point(posX, posY, battlePlate, 1, 1);
};

SideCollidesPlate = function (posX, posY, dir, capacity = 0) {
	var detectX, detectY;
	detectX = posX + lengthdir_x(sprite_width / 2 + capacity, image_angle + global.DirectionToAngle(dir));
	detectY = posY + lengthdir_y(sprite_width / 2 + capacity, image_angle + global.DirectionToAngle(dir));
	
	return collision_point(detectX, detectY, battlePlate, 1, 1);
};

EdgeCollidesPlate = function (posX, posY, capacity = 0) {
	for (var i = 0; i < 4; i ++) if (SideCollidesPlate(posX, posY, i, capacity)) then return true;
	return false;
};

SideCollidedPlate = function (dir, capacity = 0) {
	return SideCollidesPlate(x, y, dir, capacity);
};

EdgeCollidedPlate = function (capacity = 0) {
	return EdgeCollidesPlate(x, y, capacity);
}