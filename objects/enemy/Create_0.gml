/// @desc Init
depth = DEPTH.ENEMY;

Info = {
	Name	: "Default Name",
	MaxHP	: 1,
	HP		: 1,
	EXP		: 1,
	Gold	: 1,
	ATK		: 1,
	DEF		: 1,
	Spareable : true,
	Load : function (paraName, paraMaxHP, paraHP, paraEXP, paraGold, paraATK, paraDEF) {
		Name	= paraName;
		MaxHP	= paraMaxHP;
		HP		= paraHP;
		EXP		= paraEXP;
		Gold	= paraGold;
		ATK		= paraATK;
		DEF		= paraDEF;
	}
};

TyperInfo = {
	_enemy : other,
	Color	: "",
	Font	: "",
	Sep		: 0,
	Sound	: SND_NONE,
	Leading	: 0,
	GetX : function () {
		return _enemy.x;
	},
	GetY : function () {
		return _enemy.y;
	}
};

AimPos = new Vector2D(x, y);

ActChoices = {
	_content : ds_list_create(),
	Add : function (paraPos = -1, paraButtonTxt) {
		var POS = paraPos;
		if (paraPos == -1) then POS = ds_list_size(_content) - 1;
		ds_list_insert(_content, POS, paraButtonTxt);
	},
	Find : function (paraPos) {
		return _content[| paraPos];
	},
	Free : function () {
		ds_list_destroy(_content);
	}
};

ButtonCall = function (paraEnumButton, paraIndex) {
	switch (paraEnumButton) {
		case BATTLE_BUTTON.ACT:
		battle.Typer.Generate.ActText("* undefined text.");
		break;
	}
};

TryHit = function (paraVal) {
	Hit(paraVal);
};

Hit = function (paraVal) {
	//Create damage number
	var DMG_INFO = instance_create_depth(AimPos.X, AimPos.Y, 0, battleDamageInfo);
	DMG_INFO.Launch(paraVal);
	//Create enemy HP bar
	var BAR = instance_create_depth(AimPos.X, AimPos.Y, 0, battleEnemyHealthBar);
	BAR.Set(Info.MaxHP, Info.HP, clamp(Info.HP - paraVal, 0, Info.MaxHP));
	BAR.Launch();

	Info.HP = clamp(Info.HP - paraVal, 0, Info.MaxHP);
};

Spare = function () {
	if (Info.Spareable) then Remove();
};

// TODO
Remove = function () {
	with (battle.Enemies) Remove(Index(other.id));
}