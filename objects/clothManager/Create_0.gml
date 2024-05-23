debugDraw = true;

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

points = ds_list_create();
joints = ds_list_create();

grav = 0.2;

w = 10;
h = 10;


for (var i=0; i<w; i++)
{
	for (var j=0; j<h; j++)
	{
		var point = new Point(180 + i * 15, 64 + j * 15);
		if ((i % 3 == 0) && (j == 0))
			point.locked = true;
		ds_list_add(points, point);
		var pointId = ds_list_size(points) - 1;
		if (i > 0)
		{
			ds_list_add(joints, new Joint(point, points[| pointId - h], 15));
		}
		if (j > 0)
		{
			ds_list_add(joints, new Joint(point, points[| pointId - 1], 15));
		}
	}
}

//ds_list_shuffle(points);
//ds_list_shuffle(joints);

nearestPoint = -1;
selectedPoint = -1;