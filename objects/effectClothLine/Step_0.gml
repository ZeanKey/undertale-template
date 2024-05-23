if debugDraw
{
	if not _isGenerated
	{
		Generate(10, 15, noone);
	}
}

if not _isGenerated exit;

var pointCount = ds_list_size(points);
var jointCount = ds_list_size(joints);

var shortestDist = 9999;

var mouseX = mouse_x;
var mouseY = mouse_y;

for (var i=0; i<pointCount; i++)
{
	var point = points[| i];
	if (point.locked)
	{
		point.xx = x;
		point.yy = y;
		continue;
	}
		
	var preX = point.xx;
	var preY = point.yy;
	
	point.xx += point.xx - point.preX;
	point.yy += point.yy - point.preY;
	point.yy += grav;
	
	point.preX = preX;
	point.preY = preY;
	
	if debugDraw
	{
		var distToMouse = point_distance(point.xx, point.yy, mouseX, mouseY);
		if (distToMouse < shortestDist)
		{
			shortestDist = distToMouse;
			nearestPoint = point;
		}
	}
}

if debugDraw
{
	if nearestPoint != -1
	{
		if (mouse_check_button_pressed(mb_left))
		{
			var dist = point_distance(nearestPoint.xx, nearestPoint.yy, mouseX, mouseY);
			if (dist <= 20)
			{
				selectedPoint = nearestPoint;
			}
		}

		if (mouse_check_button_released(mb_left))
		{
			selectedPoint = -1;
		}
	}

	if (selectedPoint != -1)
	{
		var dist = point_distance(selectedPoint.xx, selectedPoint.yy, mouseX, mouseY);
		var dir = point_direction(selectedPoint.xx, selectedPoint.yy, mouseX, mouseY);
		selectedPoint.xx += lengthdir_x(dist * 0.1, dir);
		selectedPoint.yy += lengthdir_y(dist * 0.1, dir);
	}
	
	if keyboard_check_pressed(ord("R"))
	{
		_pointRenderEnable = !_pointRenderEnable;
	}
}

repeat 2
{
	for (var i=0; i<jointCount; i++)
	{
		var joint = joints[| i];
	
		var centreX = (joint.pointA.xx + joint.pointB.xx) * 0.5;
		var centreY = (joint.pointA.yy + joint.pointB.yy) * 0.5;
		var dirX = lengthdir_x(1, point_direction(joint.pointA.xx, joint.pointA.yy, joint.pointB.xx, joint.pointB.yy));
		var dirY = lengthdir_y(1, point_direction(joint.pointA.xx, joint.pointA.yy, joint.pointB.xx, joint.pointB.yy));
	
		if (! joint.pointA.locked)
		{
			joint.pointA.xx = centreX - dirX * joint.ropeLength * 0.5;
			joint.pointA.yy = centreY - dirY * joint.ropeLength * 0.5;
		}
		if (! joint.pointB.locked)
		{
			joint.pointB.xx = centreX + dirX * joint.ropeLength * 0.5;
			joint.pointB.yy = centreY + dirY * joint.ropeLength * 0.5;
		}
	}
}

var DIR_ARR = [];

for (var i=0; i<jointCount; i++)
{
	var joint = joints[| i];
	
	var dirX = lengthdir_x(1, point_direction(joint.pointA.xx, joint.pointA.yy, joint.pointB.xx, joint.pointB.yy));
	var dirY = lengthdir_y(1, point_direction(joint.pointA.xx, joint.pointA.yy, joint.pointB.xx, joint.pointB.yy));
	
	DIR_ARR[i] = [dirX, dirY];
}

for (var i=0; i<jointCount; i++)
{
	var joint = joints[| i];
	
	var CUR_DIR = DIR_ARR[i];
	
	var dirX = CUR_DIR[0];
	var dirY = CUR_DIR[1];
	
	if (! joint.pointA.locked)
	{
		if point_distance(joint.pointA.xx, joint.pointA.yy, joint.pointB.xx, joint.pointB.yy) > joint.ropeLength + _kLimit
		{
			joint.pointA.xx = joint.pointB.xx - dirX * (joint.ropeLength + _kLimit);
			joint.pointA.yy = joint.pointB.yy - dirY * (joint.ropeLength + _kLimit);
		}
	}
}

if _instBind != noone
{
	var END_POINT = points[| (ds_list_size(points) - 1)];
	
	_instBind.x = END_POINT.xx;
	_instBind.y = END_POINT.yy;
}