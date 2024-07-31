/// @desc Update
// Inherit the parent event
event_inherited();

if (SubPhases._index != 1) return;

if (_timer == 0) {
	var boardCenter = battleBoard.Figs.Center();
	with (battleSoul) {
		x = boardCenter[0];
		y = boardCenter[1];
	}
}

if (_timer == 30) {
	battleBoard.Figs.Y = -1000;
	instance_destroy(battleSoul);
	
	box = instance_create_depth(0, 0, 0, battleBoardExpandoBox3D);
	box.BoardSize = new Vector3D(other.boxSize * sqrt(2), other.boxSize, other.boxSize * sqrt(2));
	box.Transform.Position = new Vector3D(320, 320, 0);
	box.Transform.Rotation.Y -= 45;
	box.SoulInst = instance_create(0, 0, battleSoul3D);
	battle.Soul.Movenable = true;
	
	AnimTarget(boxColor, "R", 128, 30);
	AnimTarget(boxColor, "G", 0, 30);
	AnimTarget(boxColor, "B", 255, 30);
	AnimTarget(box, "AxisLineLength", 1200, 120, ANIM_TWEEN.CUBIC, ANIM_EASE.IN_OUT);
}

if (_timer >= 30 && _timer <= 150)
{
	box.BoardColor = make_color_rgb(boxColor.R, boxColor.G, boxColor.B);
}

if (_timer == 150)
{
	AnimTarget(box.SoulInst, "image_index", 5, 120);
	Anim_New(box.Transform.Rotation, "X", ANIM_TWEEN.CUBIC, ANIM_EASE.IN_OUT, 0, 36, 120);
	AnimTarget(box.BoardSize, "X", boxSize * 1 / cos(degtorad(36)), 120, ANIM_TWEEN.CUBIC, ANIM_EASE.IN_OUT);
	AnimTarget(box.BoardSize, "Y", boxSize * 1 / cos(degtorad(36)), 120, ANIM_TWEEN.CUBIC, ANIM_EASE.IN_OUT);
	AnimTarget(box.BoardSize, "Z", boxSize * 1 / cos(degtorad(36)), 120, ANIM_TWEEN.CUBIC, ANIM_EASE.IN_OUT);
}

if (_timer == 150)
{
	for (var i = 0; i < 3; i ++) {
		bones[i] = instance_create(0, 0, bulletBone3D);
		bones[i].Position = new Vector3D(0, 0, 0);
	}
		
	bones[0].Rotation = new Vector3D(0, 0, 0);
	bones[1].Rotation = new Vector3D(90, 0, 0);
	bones[2].Rotation = new Vector3D(0, 0, 90);

	AnimTarget(bones[0], "Size", 100, 120);
	AnimTarget(bones[1], "Size", 100, 120);
	AnimTarget(bones[2], "Size", 100, 120);

}

if (_timer >= 150)
{
	for (var i = 0; i < 3; i ++) {
		bones[i].ParentTransform = matrix_build(0, 0, 0, _timer, _timer / 2, _timer / 3, 1, 1, 1);
	}
}

if (_timer >= 1)
{
	//box.Transform.Rotation.Y ++;
}
