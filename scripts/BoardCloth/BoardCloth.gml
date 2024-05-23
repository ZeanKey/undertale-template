function battleBoardClothSetPointAnim(paraRow, paraCol, paraX, paraY, paraTween = ANIM_TWEEN.CUBIC, paraEase = ANIM_EASE.OUT, paraTime = 30, paraDelay = 0)
{
	var tmpPoint = battleBoardCloth.clothFindPoint(paraRow, paraCol);
	Anim_New(tmpPoint, "xx", paraTween, paraEase, tmpPoint.xx, paraX - tmpPoint.xx, paraTime, paraDelay);
	Anim_New(tmpPoint, "yy", paraTween, paraEase, tmpPoint.yy, paraY - tmpPoint.yy, paraTime, paraDelay);
}