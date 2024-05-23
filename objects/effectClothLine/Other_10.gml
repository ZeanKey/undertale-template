/// @desc
for (var i=0; i<w; i++)
{
	for (var j=0; j<h; j++)
	{
		var point = new Point(x + i * _len, y + j * _len);
		if ((i % 3 == 0) && (j == 0))
			point.locked = true;
		ds_list_add(points, point);
		var pointId = ds_list_size(points) - 1;
		if (i > 0)
		{
			ds_list_add(joints, new Joint(point, points[| pointId - h], _len));
		}
		if (j > 0)
		{
			ds_list_add(joints, new Joint(point, points[| pointId - 1], _len));
		}
	}
}
