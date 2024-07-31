// Inherit the parent event
event_inherited();

if (!instance_exists(battleBoardExpandoBox3D)) exit;

var _spdIdeal = 2;
var _spd = (input_check(INPUT.CANCEL)) ? _spdIdeal / 2 : _spdIdeal;

var _input = GetInput3D();

if (battle.Soul.Movenable) {
	repeat (_spd) {
		x += _input[0] / battleBoardExpandoBox3D.Transform.Scale.X;
		y += _input[1] / battleBoardExpandoBox3D.Transform.Scale.Y;
		ZIndex += _input[2] / battleBoardExpandoBox3D.Transform.Scale.Z;
	}
}


