/// @desc
depth = DEPTH.BULLET_OUTSIDE_LOW;

_counter = 0;
_limit = 0;
_finished = false;

_initLineColors = [c_red, c_aqua, c_yellow];
_initLineAlpha = 0;

var timePulse = 100;

_timeFin = timePulse + 20;
animexecutor_create(id, "_initLineAlpha", SINE_FUNCTION, [1, 0, pi / timePulse], timePulse);

FinFn = function () {
	var box = instance_create(x, y, battleBoardSubtractBox);
	box.image_angle = image_angle;
	box.Size.X = 1000;
	box.Size.Y = 15;
	screen.Shake(10, 8);
};

LineCastVLine = function (posX, coffK, coffB) {
	return new Vector2D(posX, coffK * posX + coffB);
};
LineCastHLine = function (posY, coffK, coffB) {
	if (coffK == 0) {
		return new Vector2D(coffB, posY);
	}
	return new Vector2D((posY - coffB) / coffK, posY);
};
LineCastRect = function (pos, size, coffK, coffB) {
	var vLn1 = pos.X;
	var vLn2 = pos.X + size.X;
	var hLn1 = pos.Y;
	var hLn2 = pos.Y + size.Y;
	var casts = [	LineCastVLine(vLn1, coffK, coffB), LineCastVLine(vLn2, coffK, coffB),
					LineCastHLine(vLn1, coffK, coffB), LineCastHLine(vLn2, coffK, coffB)];
	var result = [];
	array_foreach(casts, method({ Output : result, X1 : vLn1, X2 : vLn2, Y1 : hLn1, Y2: hLn2 }, function (pnt, _) {
		if (pnt.X >= X1 and pnt.X <= X2 and pnt.Y >= Y1 and pnt.Y <= Y2) {
			array_push(Output, pnt);
		}
	}));
	return result;
};

DrawCutline = function (posX, posY, rot, offset, limit = -1) {
	static LineLen = 10;
	static LineSpace = 6;
	static LinePeriod = LineLen + LineSpace;
	var coffK = lengthdir_y(1, rot) / lengthdir_x(1, rot); coffK = is_infinity(coffK) ? 0 : coffK;
	var coffB = posY - posX * coffK;
	var ends = LineCastRect(battleBoard.BoxGetPos(), battleBoard.BoxGetSize(), coffK, coffB);
	var times	= ceil(point_distance(ends[0].X, ends[0].Y, ends[1].X, ends[1].Y) / LinePeriod) + 1;
	var timesOri = times;
	var step	= global.Vector.Polar(rot, LinePeriod);
	var pos		= ends[0].Value();
	if (limit != -1) {
		times = limit + real((offset mod LinePeriod == 0));
	}
	pos.Sub(step);
	pos.Add(global.Vector.Polar(rot, offset mod LinePeriod));
	for (var i = 0; i <= times; i ++) {
		draw_sprite_ext(sprPixel2, 0, pos.X, pos.Y, LineLen, 2.5, rot, c_white, 1);
		pos.Add(step);
	}
	return { Finished : limit >= timesOri, OnUpdated : (offset mod LinePeriod) == 0 };
}
