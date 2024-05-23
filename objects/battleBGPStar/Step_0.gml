///@desc Update & Destroy Check
image_angle +=1;
image_alpha = 0.75 * sin((y + 150) / 250 * pi);

y +=1;

if (image_alpha < 0 && y > 100) {
	instance_destroy();
}