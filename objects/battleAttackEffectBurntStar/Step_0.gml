/// @desc Update
image_alpha -= _dyingSpd;
image_angle += speed;

if (image_alpha <= 0) {
	instance_destroy();
	exit;
}




