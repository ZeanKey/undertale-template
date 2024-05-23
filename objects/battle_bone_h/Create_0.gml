/// @description Insert description here
// You can write your code in this editor

// Inherit the parent event
event_inherited();

_boneHeadIndex = irandom_range(0, sprite_get_number(sprBattleBonepartZhaZha));
size = 50
destroy = 1
obj = battleSoul
mode = 0
out = 0
tween=ANIM_TWEEN.BACK
ease=ANIM_EASE.IN_OUT
if(out = 0){
	depth = DEPTH.BULLET-2;
}
else{
	depth = DEPTH.BULLET_OUTSIDE_HIGH;
}

alarm[0]=1;