for (var i=0; i<w; i++)
{
	for (var j=0; j<h; j++)
	{
		var point = new Point(x + i * _blankColumn, y + j * _blankRow);
		point._xIndex = i;
		point._yIndex = j;
		point._index = ds_list_size(points);
		if i == 0 or i == w - 1 or j == 0 or j == h - 1
		{
			if i == 1 and j == 0
			{
				_cornerPoints[0][0] = point;
			}
			else if i == 0 and j == 0
			{
				_cornerPoints[0][1] = point;
			}
			else if i == 0 and j == 1
			{
				_cornerPoints[0][2] = point;
			}
			else if i == 0 and j == h - 2
			{
				_cornerPoints[1][0] = point;
			}
			else if i == 0 and j == h - 1
			{
				_cornerPoints[1][1] = point;
			}
			else if i == 1 and j == h - 1
			{
				_cornerPoints[1][2] = point;
			}
			else if i == w - 2 and j == h - 1
			{
				_cornerPoints[2][0] = point;
			}
			else if i == w - 1 and j == h - 1
			{
				_cornerPoints[2][1] = point;
			}
			else if i == w - 1 and j == h - 2
			{
				_cornerPoints[2][2] = point;
			}
			else if i == w - 1 and j == 1
			{
				_cornerPoints[3][0] = point;
			}
			else if i == w - 1 and j == 0
			{
				_cornerPoints[3][1] = point;
			}
			else if i == w - 2 and j == 0
			{
				_cornerPoints[3][2] = point;
			}
			point._outline = true;
		}
		else
		{
			point._outline = false;
		}
		
		var joint;
		//if ((i % 4 == 0) && (j == 0))
		//	point.locked = true;
		ds_list_add(points, point);
		var pointId = ds_list_size(points) - 1;
		if (i > 0)
		{
			joint = new Joint(point, points[| pointId - h], 15);
			ds_list_add(joints, joint);
			joint._index = ds_list_size(joints) - 1;
			joint._outline = false;
			if j == 0
			{
				joint._dir = DIR.UP;
				joint._outline = true;
			}
			else if j == h - 1
			{
				joint._dir = DIR.DOWN;
				joint._outline = true;
			}
		}
		if (j > 0)
		{
			joint = new Joint(point, points[| pointId - 1], 15);
			ds_list_add(joints, joint);
			joint._index = ds_list_size(joints) - 1;
			joint._outline = false;
			if i == 0
			{
				joint._dir = DIR.LEFT;
				joint._outline = true;
			}
			else if i == w - 1
			{
				joint._dir = DIR.RIGHT;
				joint._outline = true;
			}
		}
	}
}

var pointCount = ds_list_size(points);
var jointCount = ds_list_size(joints);

for (var i=0; i<jointCount; i++)
{
	var joint = joints[| i];
	var width = 1;
	
	if clothIsJointOutline(joint)
	{
		switch joint._dir
		{
			case DIR.LEFT:
			array_push(JOINTS_L, joint);
			break;
			case DIR.DOWN:
			array_push(JOINTS_D, joint);
			break;
			case DIR.RIGHT:
			array_push(JOINTS_R, joint);
			break;
			case DIR.UP:
			array_push(JOINTS_U, joint);
			break;
		}
	}
}

_pointSoul = new MotionPoint(4, 4, self);

_initialized = true;