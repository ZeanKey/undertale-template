/// @description Insert description here
// You can write your code in this editor
if(mode = 0)
{
	player_callCollisionEvent();
}
if(mode = 1)
{
	if!(battleSoul.x = battleSoul.xprevious&&battleSoul.y = battleSoul.yprevious)player_callCollisionEvent();
}
if(mode = 2)
{
	if(battleSoul.x = battleSoul.xprevious&&battleSoul.y = battleSoul.yprevious)player_callCollisionEvent();
}