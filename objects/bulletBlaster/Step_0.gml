/// @desc
if (not _isInitialized) then exit;

_timer ++;

// Phase 0 - Navigating
if (_phase == 0) {
	image_alpha += (1 - image_alpha) / _speed;
	x += (_targetX - x) / _speed;
	y += (_targetY - y) / _speed;
	image_angle += angle_normalize_inpi(_targetRot - image_angle) / _speed;

	if (_timer >= 25) {
		x = _targetX;
		y = _targetY;
		image_alpha = 1;
		image_angle = _targetRot;
		
		_phase = 1;
		image_speed = 0.5;
	}
}

// Phase 1 - Animation - Preshoot
if (_phase == 1) {
	if (image_index == 3) {
		audio_play_sound(sndBlasterFire, 0, 0);
		screen.Shake(10, 10);
		_laser = instance_create(x, y, bulletLaser);
		_laser.image_angle	= image_angle;
		_laser.image_blend	= image_blend;
		_laser.SetSideSprite(sprBulletLaserBlasterSide);
		_laser._timer = 0;
		_laser.Scale = 0;
		_laser.Events.Step.AddCallback(-1, function (paraLaser) {
			paraLaser._timer += 1;
			
			var tmpTimer = _timer / 30;
			var tmpScale = sin(tmpTimer * pi) * image_yscale;
			
			if (tmpTimer == 1) {
				instance_destroy(paraLaser);
				exit;
			}
			paraLaser.image_alpha = tmpScale / 4 + 0.75;
			paraLaser.Scale = tmpScale;
		});
		
		_timer = 0;
		_phase = 2;
	}
}

// Phase 2 - Animation - Shoot
if (_phase == 2) {
	if (image_index == 6) {
		image_index = 4
	}
	
	if (_timer == 28) {
		_phase = 3;
	}
}

// Phase 3 - Animation - Postshoot
if (_phase == 3) {
	if (image_index == image_number - 1) {
		image_speed = 0;
	}
	
	if (image_speed == 0) {
		if (x > room_width + (60 * image_xscale) or (x < (-60 * image_xscale)) or (y > room_height + (60 * image_yscale)) or (y < (-60 * image_yscale))) {
			instance_destroy();
		}
	}
}

if (instance_exists(_laser)) {
	_laser.x = x;
	_laser.y = y;
	direction = _targetRot + 180;
	speed += 1;
}
	
	

