if not _isGenerated exit;

var pointCount = ds_list_size(points);
var jointCount = ds_list_size(joints);

if _pointRenderEnable
{
	for (var i=0; i<pointCount; i++)
	{
		var point = points[| i];
		draw_circle(point.xx, point.yy, 3, false);
	}
}


for (var i=0; i<jointCount; i++)
{
	var joint = joints[| i];
	draw_line_color(joint.pointA.xx, joint.pointA.yy, joint.pointB.xx, joint.pointB.yy, image_blend, image_blend);
}

if _pointRenderEnable and debugDraw
{
	if (nearestPoint != -1)
	{
		draw_circle_color(nearestPoint.xx, nearestPoint.yy, 6, c_green, c_green, false);
	}

	if (selectedPoint != -1)
	{
		draw_circle_color(selectedPoint.xx, selectedPoint.yy, 6, c_red, c_red, false);
	}
}