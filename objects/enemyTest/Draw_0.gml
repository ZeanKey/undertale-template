/// @desc Render
if (Info.IsSpared) {
	draw_sprite_ext(sprEnemyTest, 0, x, y, 1, 1, 0, c_gray, 1);
	exit;
}

draw_sprite_ext(sprEnemyTest, 0, x, y, 1, 1, 0, -1 , 1);
