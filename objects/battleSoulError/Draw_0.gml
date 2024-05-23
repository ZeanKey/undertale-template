var COL = c_blue;

draw_reset();
draw_set_color(COL);

var pointCount = ds_list_size(points);
var jointCount = ds_list_size(joints);

for (var i=0; i<pointCount; i++)
{
	var point = points[| i];
	draw_circle(point.xx, point.yy, 3, false);
}


for (var i=0; i<jointCount; i++)
{
	var joint = joints[| i];
	draw_line(joint.pointA.xx, joint.pointA.yy, joint.pointB.xx, joint.pointB.yy);
}

draw_self();