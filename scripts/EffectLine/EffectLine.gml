function effectLineShooterCreate(paraX, paraY, paraXTo, paraYTo, paraColor)
{
	var tmpInst = instance_create_depth(paraX, paraY, depth, effectLine);
	
	tmpInst.SetStartPoint(paraX, paraY);
	tmpInst.SetEndPoint(paraX, paraY);
	tmpInst.SetStartPointTarget(paraXTo, paraYTo);
	tmpInst.SetEndPointTarget(paraXTo, paraYTo, 30, 30);
	tmpInst.image_blend = paraColor;
	
	return tmpInst;
}

function effectLineExtendCreate(paraX, paraY, paraXTo, paraYTo, paraColor)
{
	var tmpInst = instance_create_depth(paraX, paraY, depth, effectLine);
	
	tmpInst.SetStartPoint(paraX, paraY);
	tmpInst.SetEndPoint(paraX, paraY);
	tmpInst.SetEndPointTarget(paraXTo, paraYTo, 30, 30);
	tmpInst.image_blend = paraColor;
	
	return tmpInst;
}

function effectLineAttractCreate(paraX, paraY, paraRow, paraCol, paraXTo, paraYTo, paraTime, paraDelay, paraTimeBack, paraColor)
{	
	var tmpInst = instance_create_depth(paraX, paraY, depth, effectLine);
	
	tmpInst.SetStartPoint(paraX, paraY);
	tmpInst.SetEndPoint(paraX, paraY);
	tmpInst.SetLockPoint(paraRow, paraCol, paraTime, ANIM_TWEEN.CUBIC, ANIM_EASE.OUT);
	tmpInst.alarm[1] = paraDelay + paraTime;
	tmpInst._xA = paraXTo;
	tmpInst._yA = paraYTo;
	tmpInst._tA = paraTimeBack
	tmpInst.image_blend = paraColor;
	
	return tmpInst;
}

function effectClothLineCreate(paraX, paraY, paraNum = 10, paraLen = 15, paraInst = noone)
{
	var instLine = instance_create_depth(paraX, paraY, depth, effectClothLine);
	instLine.Generate(paraNum, paraLen, paraInst);
	
	return instLine;
}