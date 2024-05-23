draw_self();

if (global.battleButtonChoose == _slot) && (battle_getStep() == BATTLE_STEP.TURN_MAIN_CHOICE)
{
	matrix_set(matrix_world,matrix_build(	_xOri - 36, 
											_yOri,
											screen._boardButtonZ + _zEdit,
											-90,
											_aEdit,
											0, 1, 1, 1));
	draw_sprite(battle_getSoulSprite(), 0, 0, 0)
}
