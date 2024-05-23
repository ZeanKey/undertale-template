/// @desc Init
x				= 320;
y				= 320;
depth			= DEPTH.BOARD - 10;
image_xscale	= 0;

Index = -1;

Open = function () {
	image_alpha		= 1;
	Anim_New(self, "image_xscale", ANIM_TWEEN.SINE, ANIM_EASE.OUT, 0, 1, 30);
};

Close = function () {
	Anim_New(self, "image_xscale", 0, 0, 1, -0.7, 30);
	Anim_New(self, "image_alpha", 0, 0, 1, -1, 30);
	alarm[0] = 30;
};

Launch = function (paraIndex) {
	// Generate attack
	Index = paraIndex;
	WORLD_PLAYER.Weapon.Attack(Index);
};