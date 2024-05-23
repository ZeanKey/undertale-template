// Inherit the parent event
event_inherited();

var pointCount = ds_list_size(points);
var jointCount = ds_list_size(joints);

var shortestDist = 9999;

for (var i=0; i<pointCount; i++)
{
	var point = points[| i];
	if (point.locked)
		continue;
		
	var preX = point.xx;
	var preY = point.yy;
	
	point.xx += point.xx - point.preX;
	point.yy += point.yy - point.preY;
	point.yy += grav;
	
	point.preX = preX;
	point.preY = preY;
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

x = _pointSoul.xx;
y = _pointSoul.yy;