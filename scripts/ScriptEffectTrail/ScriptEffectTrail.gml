function effectTrailCreate(paraWidth, paraAlarm, paraColor1, paraColor2, paraTex = sprite_get_texture(sprEffectTrailArrow, 0))
{
	var INST = instance_create_depth(0, 0, depth, effectTrail);
	INST.Init(paraWidth, paraAlarm, paraTex);	
	INST._color1 = paraColor1;
	INST._color2 = paraColor2;
	
	return INST;
}

function spaceShootArrow(paraXStart, paraYStart, paraXEnd, paraYEnd)
{
	var AIM = instance_create_depth(paraXEnd, paraYEnd, depth, effectArrowLock);
	AIM._posStart = [paraXStart, paraYStart];
}

function spaceShootQuickArrow(paraXStart, paraYStart, paraXEnd, paraYEnd, paraTime, paraAlarm)
{
	var INST = instance_create_depth(paraXEnd, paraYEnd, 0, effectArrowQuickLocker);
	INST._time = paraTime;
	INST._posStart = [paraXStart, paraYStart];
	INST._alarm = paraAlarm;
	
	with INST
	{
		event_user(0);
	}
}