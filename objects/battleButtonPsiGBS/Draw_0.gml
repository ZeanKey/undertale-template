///@desc DRAW_CHOOSE_SOUL
draw_self();
if (global.battleButtonChoose==_slot) && (battle_getStep()==BATTLE_STEP.TURN_MAIN_CHOICE)
{
	draw_sprite(battle_getSoulSprite(),0,x-48,y+1)
}

