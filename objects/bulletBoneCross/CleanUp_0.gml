if (_isBoneSpawned) {
	for (var COUNTER = 0; COUNTER < array_length(_boneLst); COUNTER ++) {
		var CUR_BONE = _boneLst[COUNTER];
	
		if (instance_exists(CUR_BONE)) {
			instance_destroy(CUR_BONE);
		}
	}
}