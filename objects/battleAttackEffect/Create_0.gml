/// @desc Init
depth = DEPTH.ENEMY - 50;

_index = -1;
_damage = -1;

Launch = function (paraIndex, paraVal) {
	_index	= paraIndex;
	_val	= paraVal;
};

CallEnemy = function () {
	battle.Enemies.Find(_index).TryHit(_val);
}

