/// @desc
var RETI	= instance_create_depth(x, y, depth, battleAttackBurntPanSingle);
var DIR_TO	= _dir;
var INDEX	= _bulletCounter;

with (RETI) {
	switch (DIR_TO) {
		case DIR.LEFT:
		Anim_New(id, "x", 0, 0, x, -sprite_get_width(sprBattleAimBar), _time);
		break;
	
		case DIR.RIGHT:
		Anim_New(id, "x", 0, 0, x, sprite_get_width(sprBattleAimBar), _time);
		break;
	}
	
	_start = x;
	
	_index = INDEX;
}

_bulletCounter ++;

if (_bulletCounter < _bulletNum) then alarm[0] = 10 + random(10);



