function angle_normalize_inpi(paraAngle){
	var tmpOut = paraAngle;
	if (tmpOut >= -180) and (tmpOut <= 180) then return paraAngle;
	if (tmpOut > 180) {
		if (tmpOut > 360) then tmpOut = tmpOut mod 360;
		if (tmpOut > 180) then tmpOut -= 360;
	}
	else {
		if (tmpOut < -360) then tmpOut = -abs(tmpOut) mod 360;
		if (tmpOut < -180) then tmpOut += 360
	}
	return tmpOut
}

function angle_normalize_innatural(paraAngle){
	var tmpOut = paraAngle;
	if (tmpOut >= 0) and (tmpOut <= 360) then return paraAngle;
	if (tmpOut > 360) {
		tmpOut = tmpOut mod 360
	}
	else {
		tmpOut += (abs(tmpOut) div 360 + 1) * 360;
	}
	return tmpOut;
}