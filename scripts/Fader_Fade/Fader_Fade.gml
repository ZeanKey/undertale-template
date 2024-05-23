function Fader_Fade(alpBegin, alpEnd, time, color, persist) {
	var tmpFader = instance_create_depth(0, 0, DEPTH.CAMERA, fader);
	
	tmpFader._color	= color;
	tmpFader._alpha	= alpBegin;
	tmpFader._target = alpEnd;
	tmpFader._persist = persist;
	Anim_New(tmpFader, "_alpha", 0, 0, alpBegin, alpEnd - alpBegin, time);
	
	return tmpFader;
}
