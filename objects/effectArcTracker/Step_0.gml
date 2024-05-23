///@desc
if _motionStart
{
	if not variable_instance_exists(_inst, "x")
	{
		instance_destroy();
		exit;
	}
	
	if _timerUpdate
	{
		_timer += _timerAdder;
	}
	
	if _timer >= 1
	{
		_timer = 1;
	}
	
	var ANG_START	= point_direction(_cirPosX, _cirPosY, _startX, _startY);
	var ANG_NEW		= ANG_START + _timer * _angTotal;
	
	var N_X = _cirPosX + lengthdir_x(_radius, ANG_NEW);
	var N_Y = _cirPosY + lengthdir_y(_radius, ANG_NEW);
	_inst.image_angle = ANG_NEW + 90;
	
	if _timer == 1
	{
		instance_destroy();
		
		_inst.direction = point_direction(_inst.xprevious, _inst.yprevious, N_X, N_Y);
		_inst.speed = point_distance(_inst.xprevious, _inst.yprevious, N_X, N_Y);
	}
	else
	{
		_inst.x = N_X;
		_inst.y = N_Y;
	}
}