/// @desc
if _begin
{
	_counter += pi / _time;

	image_alpha = clamp(_alphaMax * sin(_counter), 0, 1);

	if _counter >= pi
	{
		instance_destroy();
	}
}