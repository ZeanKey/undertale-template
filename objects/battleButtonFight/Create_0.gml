/// @desc Init
event_inherited();

BarColor = {
	Front	: #00ff00,
	Back	: c_red
};

BarRenderAbsFactory = function (paraTyper, paraEnemy, paraColBack, paraColFront) {
	var METHOD;
	paraTyper.Cache.Write("BBFEnemyChosen", paraEnemy);
	paraTyper.Cache.Write("BBFColorBack", paraColBack);
	paraTyper.Cache.Write("BBFColorFront", paraColFront);
	with (paraTyper) {
		METHOD = function () {
				static ENEMY_CHOSEN = self.Cache.Read("BBFEnemyChosen");
				static COLOR_BACK	= self.Cache.Read("BBFColorBack");
				static COLOR_FRONT	= self.Cache.Read("BBFColorFront");
				if (not instance_exists(ENEMY_CHOSEN)) return false;
				draw_sprite_ext(sprPixel, 0, x + 170, y + 9, 101, 17, 0, COLOR_BACK, 1);
				draw_sprite_ext(sprPixel, 0, x + 170, y + 9, 101 * ENEMY_CHOSEN.Info.HP / ENEMY_CHOSEN.Info.MaxHP, 17, 0, COLOR_FRONT, 1);
		};
	}
	return METHOD;
};
