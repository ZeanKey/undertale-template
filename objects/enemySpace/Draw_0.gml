/// @desc Render
if (Info.IsSpared) {
	exit;
}

draw_sprite_ext(sprEnemySansLeg, 0, x, y, 2, 2, 0, -1, 1);
AnimSpriteBody.Render(x, y);
AnimSpriteHead.Render(x, y);

