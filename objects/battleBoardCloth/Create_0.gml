depth = DEPTH.BOARD;

debugDraw = false;

_glitch = true;

_counter = 0;

_colorLine = c_blue;

_blankColumn	= 15;
_blankRow		= 15;

_surfBox = -1;

_cornerPoints = [];

_initialized = false;
_load = false;

JOINTS_L = [];
JOINTS_D = [];
JOINTS_R = [];
JOINTS_U = [];

/// 0 ---- 3 ///
/// |      | ///
/// |      | ///
/// 1 ---- 2 ///

repeat 4
{
	array_push(_cornerPoints, []);
}

function MotionPoint(paraRow, paraCol, paraCloth) constructor
{
	self._row = paraRow;
	self._column = paraCol;
	self._cloth = paraCloth;
	
	self.PosLimit = function () {
		if _row > _cloth.h - 1
		{
			_row = _cloth.h - 1;
		}
		
		if _row < 0
		{
			_row = 0;
		}
		
		if _column > _cloth.w - 1
		{
			_column = _cloth.w - 1;
		}
		
		if _column < 0
		{
			_column = 0;
		}
	};
	
	self.InputMotion = function () {
		var SPD_W = 2 / _cloth.w;
		var SPD_H = 2 / _cloth.h;
		SPD_W = input_check(INPUT.CANCEL) ? SPD_W / 2 : SPD_W;
		SPD_H = input_check(INPUT.CANCEL) ? SPD_H / 2 : SPD_H;
	
		if input_check(INPUT.UP)
		{
			if round(self._column) != self._column
			{
				if input_check_pressed(INPUT.UP) self._row = ceil(self._row - 1);
			}
			else self._row -= SPD_W;
			self.PosLimit();
		}
		if input_check(INPUT.DOWN)
		{
			if round(self._column) != self._column
			{
				if input_check_pressed(INPUT.DOWN) self._row = floor(self._row + 1);
			}
			else self._row += SPD_W;
			self.PosLimit();
		}
		if input_check(INPUT.LEFT)
		{
			if round(self._row) != self._row
			{
				if input_check_pressed(INPUT.LEFT) self._column = ceil(self._column - 1);
			}
			else self._column -= SPD_H;
			self.PosLimit();
		}
		if input_check(INPUT.RIGHT)
		{
			if round(self._row) != self._row
			{
				if input_check_pressed(INPUT.RIGHT) self._column = floor(self._column + 1);
			}
			else self._column += SPD_H;
			self.PosLimit();
		}
	};
	
	self.GetPos = function () {
		var R_R = self._row - floor(self._row);
		var R_C = self._column - floor(self._column);
		var P1, P2;
		
		if round(self._row) == self._row
		{
			self._row = round(self._row);
			if round(self._column) == self._column
			{
				self._column = round(self._column);
				P1 = _cloth.clothFindPoint(self._row, self._column);
				P2 = _cloth.clothFindPoint(self._row, self._column);
			}
			else
			{
				P1 = _cloth.clothFindPoint(self._row, floor(self._column));
				P2 = _cloth.clothFindPoint(self._row, ceil(self._column));
			}
		}
		else
		{
			if round(self._column) == self._column
			{
				self._column = round(self._column);
				P1 = _cloth.clothFindPoint(floor(self._row), self._column);
				P2 = _cloth.clothFindPoint(ceil(self._row), self._column);
			}
			else
			{
				P1 = _cloth.clothFindPoint(floor(self._row), floor(self._column));
				P2 = _cloth.clothFindPoint(ceil(self._row), ceil(self._column));
			}
		}
		
		var R_F = R_R;
		
		if _row = round(_row)
		{
			R_F = R_C;
		}
		
		return [(P2.xx - P1.xx) * R_F + P1.xx,
				(P2.yy - P1.yy) * R_F + P1.yy]
	};
	
	self.Render = function () {
		var POS = self.GetPos();
		draw_circle(POS[0], POS[1], 5, false);
	};
}

function SimplePoint(paraX, paraY) constructor
{
	self._x = paraX;
	self._y = paraY;
	
	self.ToPoint = function (paraRow, paraCol, paraTime = 60, paraDelay = 0){
		var POINT = battleBoardCloth.clothEvalSimplePoint(paraRow, paraCol);
		Anim_New(self, "_x", ANIM_TWEEN.CUBIC, ANIM_EASE.OUT, self._x, POINT[0] - self._x, paraTime, paraDelay);
		Anim_New(self, "_y", ANIM_TWEEN.CUBIC, ANIM_EASE.OUT, self._y, POINT[1] - self._y, paraTime, paraDelay);
	};
}

function SimpleLine(paraPointS, paraPointE) constructor
{
	self._pointS = paraPointS;
	self._pointE = paraPointE;
	
	self.Render = function (){
		draw_line_color(self._pointS._x, self._pointS._y, self._pointE._x, self._pointE._y, battleBoardCloth._colorLine, battleBoardCloth._colorLine);
	};
}

function Point(xx, yy, locked = false) constructor {
	self.xx = xx;
	self.yy = yy;
	self.preX = xx;
	self.preY = yy;
	self.locked = locked;
	distanceToMouse = 0;
}

function Joint(pointA, pointB, ropeLength) constructor {
	self.pointA = pointA;
	self.pointB = pointB;
	self.ropeLength = ropeLength;
}

function clothFindPoint(paraRow, paraCol)
{
	var INDEX = paraCol * h + paraRow;
	
	return ds_list_find_value(points, INDEX);
}

function clothIsJointOutline(paraJoint)
{
	return paraJoint._outline;
}

function clothEvalSimplePoint(paraRow, paraCol)
{
	return [x + paraCol * _blankColumn, y + paraRow * _blankRow]
}

_bindingList = [];

function BindPoint(paraInst, paraVarNameX, paraVarNameY, paraRow, paraCol)
{
	array_push(_bindingList, [paraInst, [paraVarNameX, paraVarNameY], paraRow, paraCol]);
}

#region Banished
function tripointsEvaluateOutlineVertex(paraPA, paraPB, paraPC, paraWidth)
{
	draw_vertex_color(paraPB.xx, paraPB.yy, c_white, 1);
	
	var DIR_AB = point_direction(paraPA.xx, paraPA.yy, paraPB.xx, paraPB.yy) + 90;
	var DIR_BC = point_direction(paraPB.xx, paraPB.yy, paraPC.xx, paraPC.yy) + 90;
	
	var K_AB = (paraPB.yy - paraPA.yy) / (paraPB.xx - paraPA.xx);
	var K_BC = (paraPC.yy - paraPB.yy) / (paraPC.xx - paraPB.xx);
	
	var B_AB = paraPA.yy + lengthdir_y(paraWidth, DIR_AB) - (paraPA.xx + lengthdir_x(paraWidth, DIR_AB)) * K_AB;
	var B_BC = paraPC.yy + lengthdir_y(paraWidth, DIR_BC) - (paraPC.xx + lengthdir_x(paraWidth, DIR_BC)) * K_BC;
	
	var P_X = (B_BC - B_AB) / (K_AB - K_BC);
	var P_Y = K_AB * P_X + B_AB;
	
	if paraPA.xx == paraPB.xx and paraPB.xx == paraPC.xx
	{
		//return false;
	}
	else if paraPA.xx == paraPB.xx
	{
		if DIR_AB == 0
		{
			P_X = paraPA.xx + paraWidth;
		}
		else
		{
			P_X = paraPA.xx - paraWidth;
		}
		P_Y = K_BC * P_X + B_BC;
	}
	else if paraPB.xx == paraPC.xx
	{
		if DIR_BC == 0
		{
			P_X = paraPC.xx + paraWidth;
		}
		else
		{
			P_X = paraPC.xx - paraWidth;
		}
		P_Y = K_AB * P_X + B_AB;
	}
	else if K_AB = K_BC
	{
		var DIR_BOTH = point_direction(paraPA.xx, paraPA.yy, paraPB.xx, paraPB.yy);
		P_X = paraPB.xx + lengthdir_x(2 * paraWidth, DIR_BOTH);
		P_Y = paraPB.yy + lengthdir_y(2 * paraWidth, DIR_BOTH);
	}
	
	//show_message([B_AB, B_BC])
	if keyboard_check(ord("C"))
	{
		draw_circle(P_X, P_Y, 2, false);
	}
	var ON_DIST = point_distance(paraPB.xx, paraPB.yy, P_X, P_Y);
	var ON_DIR = point_direction(paraPB.xx, paraPB.yy, P_X, P_Y);
	
	if ON_DIST > paraWidth * 2
	{
		ON_DIST = paraWidth * 2;
		P_X = paraPB.xx + lengthdir_x(ON_DIST, ON_DIR);
		P_Y = paraPB.yy + lengthdir_y(ON_DIST, ON_DIR);
	}
	
	//draw_vertex_color(P_X, P_Y, c_white, 1);
}

function tripointsEvaluateOutlineVertexFixed(paraPnt, paraPntOpp, paraWidth)
{
	
}

function cornerEvaluateOutlineVertex(paraIndex, paraWidth)
{
	var P = _cornerPoints[paraIndex];

	tripointsEvaluateOutlineVertex(P[0], P[1], P[2], paraWidth);
}

function cornerEvaluateOutlineVertexSingle(paraIndex, paraWidth)
{
	var P = _cornerPoints[paraIndex];

	draw_vertex_color(P[1].xx, P[1].yy, c_white, 1)
}

function clothVertexsPairCorner(paraDirH, paraDirV)
{	
	if paraDirH == DIR.LEFT and paraDirV == DIR.UP
	{
		cornerEvaluateOutlineVertex(0, 5);
		#region Saved, may not use
		//draw_vertex_color(JL[0].pointB.xx, JL[0].pointB.yy, c_white, 1);
		//var DIR_L1 = point_direction(JL[0].pointB.xx, JL[0].pointB.yy, JL[0].pointA.xx, JL[0].pointA.yy) - 90;
		//var DIR_L2 = point_direction(JU[0].pointA.xx, JU[0].pointA.yy, JU[0].pointB.xx, JU[0].pointB.yy) - 90;
		//var K_1 = (JL[0].pointA.yy - JL[0].pointB.yy) / (JL[0].pointA.xx - JL[0].pointB.xx);
		//var K_2 = (JU[0].pointA.yy - JU[0].pointB.yy) / (JU[0].pointA.xx - JU[0].pointB.xx);
		//var B_1 = JL[0].pointA.yy + lengthdir_y(5, DIR_L1) - (JL[0].pointA.xx + lengthdir_x(5, DIR_L1)) * K_1;
		//var B_2 = JU[0].pointA.yy + lengthdir_y(5, DIR_L2) - (JU[0].pointA.xx + lengthdir_x(5, DIR_L2)) * K_2;
		
		//var P_X = (B_2 - B_1) / (K_1 - K_2);
		//var P_Y = K_2 * P_X + B_2;
		
		//draw_vertex_color(P_X, P_Y, c_white, 1);
		#endregion
	}
	else if paraDirH == DIR.LEFT and paraDirV == DIR.DOWN
	{
		cornerEvaluateOutlineVertex(1, 5);
	}
	else if paraDirH == DIR.RIGHT and paraDirV == DIR.DOWN
	{
		cornerEvaluateOutlineVertex(2, 5);
	}
	else if paraDirH == DIR.RIGHT and paraDirV == DIR.UP
	{
		cornerEvaluateOutlineVertex(3, 5);
	}
}

function clothVertexCorner(paraDirH, paraDirV)
{	
	if paraDirH == DIR.LEFT and paraDirV == DIR.UP
	{
		cornerEvaluateOutlineVertexSingle(0, 5);
	}
	else if paraDirH == DIR.LEFT and paraDirV == DIR.DOWN
	{
		cornerEvaluateOutlineVertexSingle(1, 5);
	}
	else if paraDirH == DIR.RIGHT and paraDirV == DIR.DOWN
	{
		cornerEvaluateOutlineVertexSingle(2, 5);
	}
	else if paraDirH == DIR.RIGHT and paraDirV == DIR.UP
	{
		cornerEvaluateOutlineVertexSingle(3, 5);
	}
}
#endregion

points = ds_list_create();
joints = ds_list_create();

grav = 0;

w = 9;
h = 9;

//ds_list_shuffle(points);
//ds_list_shuffle(joints);

nearestPoint = -1;
selectedPoint = -1;

//event_user(0);

_effEnd = false;
