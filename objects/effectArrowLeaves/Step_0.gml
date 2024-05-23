/// @desc
image_angle += _spinSpd;
image_alpha -= _fadeSpd;

if image_alpha <= 0
{
	instance_destroy();
}