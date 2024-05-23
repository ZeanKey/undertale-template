_camCar = instance_create(320, 240, cameraCarrier);
camera.ScaleX = 2;
camera.ScaleY = 2;
camera.Target = _camCar;
Anim_New(_camCar, "y", ANIM_TWEEN.EXPO, ANIM_EASE.OUT, 480, 360, 180);

alarm[1] = 240;