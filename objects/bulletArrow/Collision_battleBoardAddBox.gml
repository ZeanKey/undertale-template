/// @desc
if _firstCollided == false
{
	//if other.object_index = battleBoxUp.object_index
	//{
	//	boxStrike(DIR.UP);
	//}
	//else if other.object_index = battleBoxDown.object_index
	//{
	//	boxStrike(DIR.DOWN);
	//}
	//else if other.object_index = battleBoxLeft.object_index
	//{
	//	boxStrike(DIR.LEFT);
	//}
	//else if other.object_index = battleBoxRight.object_index
	//{
	//	boxStrike(DIR.RIGHT);
	//}
	battleBoard.BoxStrike(x, y, speed * 5);
	screen.Shake(5, 20);

	_firstCollided = true;
}