if _phase == 0
{
	if image_alpha < 1
	{
		image_alpha += _alphaAdder;
	}
}

if _phase == 1
{
	if image_alpha > 0
	{
		image_alpha -= 0.1
	}
	else
	{
		instance_destroy();
	}
}