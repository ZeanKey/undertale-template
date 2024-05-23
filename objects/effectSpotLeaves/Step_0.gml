_counter -= _dyingSpd;
image_xscale = _counter;
image_yscale = _counter;

image_alpha -= _alphaFadingSpd;

if image_alpha == 0
{
	instance_destroy();
}

if _counter <= 0
{
	instance_destroy();
}