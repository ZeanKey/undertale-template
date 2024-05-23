/// @desc
var _input = new Vector2D(0, 0);
_input.X += input_check(INPUT.RIGHT) - input_check(INPUT.LEFT);
_input.Y += input_check(INPUT.DOWN) - input_check(INPUT.UP);

var _spd = 2;
var _xStep, _yStep;
_xStep = _input.X;
_yStep = _input.Y;

repeat (_spd) {
	if (not place_meeting(x + _xStep, y, oCollider)) then x += _xStep;
	if (not place_meeting(x, y + _yStep, oCollider)) then y += _yStep;
}
