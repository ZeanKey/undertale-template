/// @desc Init
depth	= DEPTH.BOARD;
x		= 320;
y		= 240;

Main = instance_create_depth(x, y, DEPTH.BOARD, battleBoardAddBox);

var MAIN_BOARD = Main;

Figs = {
	X		: 320,
	Y		: 320,
	Main	: MAIN_BOARD,
	Up		: 70,
	Down	: 70,
	Left	: 288,
	Right	: 288,
	Angle	: 0,
	Auto	: {
		Value : true,
		On : function () {
			// TODO
			Value = true;
		},
		Off : function () {
			Value = false;
		}
	},
	Center	: function () {
		return [X + (lengthdir_x(Left, Angle + 180) + lengthdir_x(Right, Angle) + lengthdir_x(Up, Angle + 90) + lengthdir_x(Down, Angle - 90) ) / 2,
				Y + (lengthdir_y(Left, Angle + 180) + lengthdir_y(Right, Angle) + lengthdir_y(Up, Angle + 90) + lengthdir_y(Down, Angle - 90)) / 2];
	},
	Apply	: function () {
		if (not Auto.Value) then return false;
		var CENTER = Center();
		Main.x = CENTER[0];
		Main.y = CENTER[1];
		Main.image_angle = Angle;
		Main.Size.X = Left + Right;
		Main.Size.Y = Up + Down;
		Main.Scale.Update();
	}
};

IsOnScreen = true;
SurfaceBoardOutput = -1;

Set = {
	_figs : other.Figs,
	Regular : function () { 
		with (_figs) {
			X = 320;
			Y = 320;
			Left = 240;
			Right = 240;
			Up = 30;
			Down = 30;
		}
	}
};

SurfaceFrame	= -1;
SurfaceMask		= -1;
SurfaceBoard	= -1;

BoardTowardAngle	= "N/A";
BoardDepthAngle		= 0;

BoxGetWidth = function () {
	return Figs.Left + Figs.Right;
};

BoxGetHeight = function () {
	return Figs.Up + Figs.Down;
};

BoxGetCenter = function ()
{
	return Figs.Center();
};

BoxGetPos = function () {
	return new Vector2D(Figs.X - Figs.Left, Figs.Y - Figs.Up);
};

BoxGetSize = function () {
	return new Vector2D(BoxGetWidth(), BoxGetHeight());
};

BoxStrike = function (paraX, paraY, paraPower)
{
	var CENTER = BoxGetCenter();
	var DIRECTION = point_direction(CENTER[0], CENTER[1], paraX, paraY) + 180;

	BoardTowardAngle = (BoardDepthAngle == 0) ? DIRECTION : (DIRECTION + BoardTowardAngle) / 2;
	BoardDepthAngle += paraPower;
}
