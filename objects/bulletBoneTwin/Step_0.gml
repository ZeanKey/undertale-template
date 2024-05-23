if (_boneHasSpawned) {
	_attCounter += _attSpd;
	
	var INST_COUNTER = 2;

	var CUR_DIST	= _attCounter;
	var CUR_SWING	= sin(_attCounter * _attSwingTimerRate) * _attSwingLen;

	var CUR_VEC_DIST	= [	lengthdir_x(CUR_DIST, _attDir),
							lengthdir_y(CUR_DIST, _attDir)];
	var CUR_VEC_SWING	= [	lengthdir_x(CUR_SWING, _attDir - 90),
							lengthdir_y(CUR_SWING, _attDir - 90)];

	for (var B_IND = 0; B_IND <= 1; B_IND ++) {
		var CUR_SIGN = 1;
		if (B_IND == 0) {
			CUR_SIGN = -1;
		}
		
		var CUR_BONE = _boneLst[B_IND];
		
		if (not variable_instance_exists(CUR_BONE, "x")) {
			INST_COUNTER -= 1;
			break;
		}
		
		CUR_BONE.x = _attPos[0] + CUR_VEC_DIST[0] + CUR_SIGN * CUR_VEC_SWING[0];
		CUR_BONE.y = _attPos[1] + CUR_VEC_DIST[1] + CUR_SIGN * CUR_VEC_SWING[1];
		var CUR_ANGLE = arctan((CUR_BONE.y - CUR_BONE.yprevious) / (CUR_BONE.x - CUR_BONE.xprevious)) / pi * 180;
		var CUR_ANGLE_VEC = point_direction(CUR_BONE.xprevious, CUR_BONE.yprevious, CUR_BONE.x, CUR_BONE.y)
		CUR_BONE.image_angle = -CUR_ANGLE;
		
		var CUR_PART_VEC = [lengthdir_x(CUR_BONE._boneSize / 2, CUR_ANGLE_VEC + 180),
							lengthdir_y(CUR_BONE._boneSize / 2, CUR_ANGLE_VEC + 180)];
		
		var CUR_PART = instance_create_depth(CUR_BONE.x + CUR_PART_VEC[0],
						CUR_BONE.y + CUR_PART_VEC[1], CUR_BONE.depth,
						effectSpotLeaves)
		CUR_PART.image_angle	= CUR_ANGLE;
		CUR_PART._counter		= 4;
		CUR_PART._dyingSpd		= 0.2;
	}
	
	if (INST_COUNTER == 0) {
		instance_destroy();
	}
}

