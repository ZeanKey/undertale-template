// Inherit the parent event
event_inherited();

var _spdIdeal = 2;
var _spd = (input_check(INPUT.CANCEL)) ? _spdIdeal / 2 : _spdIdeal;

var _input = GetInput();
var _inputHDir = global.VectorArrayToDirection([_input[0], 0]);
var _inputVDir = global.VectorArrayToDirection([0, _input[1]]);

if (battle.Soul.Movenable) {
	if (not is_undefined(_inputHDir)) then repeat (_spd) {
		if (not SideCollidedFrame(_inputHDir, 1)) then x += _input[0];
	}
	if (not is_undefined(_inputVDir)) then repeat (_spd) {
		if (not SideCollidedFrame(_inputVDir, 1)) then y += _input[1];
	}
}
