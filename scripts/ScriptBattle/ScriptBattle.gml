BattleHelper = {};

BattleHelper.Soul = {};

var SOUL = BattleHelper.Soul;

SOUL._SoulClassMap = {};
SOUL.Register = function (name, obj) {
	BattleHelper.Soul._SoulClassMap[$ name] = obj;
};
SOUL.GetObjectIndex = function (name) {
	if (variable_struct_exists(BattleHelper.Soul._SoulClassMap, name)) {
		return BattleHelper.Soul._SoulClassMap[$ name];
	}
	return undefined;
};

SOUL.Register(SOUL_MODE.RED, battleSoulRed);
SOUL.Register(SOUL_MODE.BLUE, battleSoulBlue);