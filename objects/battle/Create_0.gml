///@desc Initialize
// Variables
TurnPhase		= undefined;
TurnIndex		= 0;

EncounterObject = undefined;
Encounter		= 0;

// Structs
Buttons	= {
	_content : ds_list_create(),
	Index	: 0,
	Update	: function () {
		if (battle.TurnPhase == TURN_PHASE.PLAYER_MAIN) {
			if (input_check_pressed(INPUT.LEFT)) {
				Index --;
				audio_play_sound(sndMenuSwitch,0,0);
			}
			else if (input_check_pressed(INPUT.RIGHT)) {
				Index ++;
				audio_play_sound(sndMenuSwitch,0,0);
		    }
		}
		
		Index = clamp_loop(Index, 0, ds_list_size(_content) - 1);
	
		if (input_check_pressed(INPUT.CONFIRM)) {
			Current().Confirm();
		}
		else if (input_check_pressed(INPUT.CANCEL)) {
			Current().Cancel();
		}
	},
	Add		: function (paraInst, paraPos = -1) {
		var POS = paraPos;
		if (POS == -1) then POS = ds_list_size(_content) - 1;
		ds_list_insert(_content, POS, paraInst);
	},
	Find	: function (paraPos) {
		return _content[| paraPos];
	},
	Current : function () {
		var INST = Find(Index);
		if (INST == undefined) then return noone;
		return INST;
	},
	Remove	: function (paraPos) {
		ds_list_delete(_content, paraPos);
	},
	Free	: function () {
		ds_list_destroy(_content);
	}
};

Enemies	= {
	_content : ds_list_create(),
	Add		: function (paraInst, paraPos = -1) {
		var POS = paraPos;
		if (POS == -1) then POS = ds_list_size(_content) - 1;
		ds_list_insert(_content, POS, paraInst);
	},
	Find	: function (paraPos) {
		return _content[| paraPos];
	},
	Index	: function (paraId) {
		for (var INDEX = 0; INDEX < ds_list_size(_content); INDEX ++) {
			if (_content[| INDEX].id == paraId) {
				return INDEX;
			}
		}
		return -1;
	},
	Remains	: function () {
		return (not ds_list_empty(_content));
	},
	Spare	: function () {
		var ENEMIES = [];
		for (var INDEX = 0; INDEX < ds_list_size(_content); INDEX ++) {
			array_push(ENEMIES, _content[| INDEX]);
		}
		for (var INDEX = 0; INDEX < array_length(ENEMIES); INDEX ++) {
			ENEMIES[INDEX].Spare();
		}
	},
	Remove	: function (paraPos) {
		ds_list_delete(_content, paraPos);
	},
	Free	: function () {
		ds_list_destroy(_content);
	}
};

Typer = {
	Generate : {
		MainDialog		: function (paraTxt) {
			var TYPER	= instance_create_depth(battle.Encounter.TyperPosition.Dialog.X, 
												battle.Encounter.TyperPosition.Dialog.Y, DEPTH.BOARD - 50, typer);
			var PREFIX	= "{Font RegularBattle}{Color White}{Leading 32}";
			TYPER._text = PREFIX + paraTxt;
			with (TYPER) {
				Events.Custom.AddCallback(function () {
					instance_destroy();
				});
				event_user(0);
			}
			
			return TYPER;
		},
		EnemyDialog		: function (paraTxt, paraMethod = function () {}) {
			var TYPER	= instance_create_depth(0, 0, DEPTH.BOARD - 50, typer);
			TYPER._text = paraTxt;
			with (TYPER) {
				Cache.Write("EDBubble", sprDefault);
				Cache.Write("EDOffsetX", 0);
				Cache.Write("EDOffsetY", 0);
				Cache.Write("EDMethod", paraMethod);
				Events.PreRender.AddCallback(function () {
					var CACHE = Cache;
					draw_sprite(CACHE.Read("EDBubble"), 0, x - Cache.Read("EDOffsetX"), y - Cache.Read("EDOffsetY"));
				});
				Events.Destroy.AddCallback(function (paraTyper) {
					method_call(paraTyper.Cache.Read("EDMethod"), []);
				});
				event_user(0);
			}
			
			return TYPER;
		},
		Winning		: function (paraTxt) {
			var TYPER	= instance_create_depth(battle.Encounter.TyperPosition.Dialog.X, 
												battle.Encounter.TyperPosition.Dialog.Y, DEPTH.BOARD - 50, typer);
			var PREFIX	= "{Font RegularBattle}{Color White}{Leading 32}";
			TYPER._text = PREFIX + paraTxt;
			with (TYPER) {
				Events.Custom.AddCallback(function () {
					instance_destroy();
				});
				event_user(0);
			}
			
			return TYPER;
		},
		Flee			: function (paraTxt) {
			var TYPER	= instance_create_depth(battle.Encounter.TyperPosition.Dialog.X + 48, 
												battle.Encounter.TyperPosition.Dialog.Y, DEPTH.BOARD - 50, typer);
			var PREFIX	= "{Font RegularBattle}{Color White}{Leading 32}";
			TYPER._text = PREFIX + paraTxt;
			with (TYPER) {
				Events.Custom.AddCallback(function () {
					instance_destroy();
				});
				event_user(0);
			}
			
			return TYPER;
		},
		RegularChoice	: function (paraX, paraY, paraTxt) {
			var TYPER	= instance_create_depth(paraX, 
												paraY, DEPTH.BOARD - 50, typer);
			var PREFIX	= "{Font RegularBattle}{Color White}{Leading 32}";
			TYPER._text = PREFIX + paraTxt;
			with (TYPER) {
				event_user(0);
				Instantize();
			}
			
			return TYPER;
		},
		ActText			: function (paraTxt) {
			var TYPER	= instance_create_depth(battle.Encounter.TyperPosition.Dialog.X, 
												battle.Encounter.TyperPosition.Dialog.Y, DEPTH.BOARD - 50, typer);
			var PREFIX	= "{Font RegularBattle}{Color White}{Enter}{Leading 32}";
			TYPER._text = PREFIX + paraTxt;
			with (TYPER) {
				Events.Destroy.AddCallback(function () {
					with (battleButton) event_user(BUTTON_EVENT.OUTER_CONFIRM);
				});
				event_user(0);
			}
			
			return TYPER;
		},
		ItemText		: function (paraTxt) {
			var TYPER	= instance_create_depth(battle.Encounter.TyperPosition.Dialog.X, 
												battle.Encounter.TyperPosition.Dialog.Y, DEPTH.BOARD - 50, typer);
			var PREFIX	= "{Font RegularBattle}{Color White}{Enter}{Leading 32}";
			TYPER._text = PREFIX + paraTxt;
			with (TYPER) {
				Events.Destroy.AddCallback(function () {
					with (battleButton) event_user(BUTTON_EVENT.OUTER_CONFIRM);
				});
				event_user(0);
			}
			
			return TYPER;
		},
	}
};

Buffs = {
	// TODO
	_content : [],
	Add : function () {
		
	}
}

Damage = {
	_content : ds_map_create(),
	Add		: function (paraName, paraManager) {
		var MANAGER = instance_create_depth(0, 0, 0, paraManager);
		ds_map_add(_content, paraName, MANAGER); 
	},
	Exists	: function (paraName) {
		return ds_map_exists(_content, paraName);
	},
	Find	: function (paraName) {
		return ds_map_find_value(_content, paraName);
	},
	Cause	: function (paraName, paraArray = []) {
		var DMG = Find(paraName);
		if (not is_undefined(DMG)) then DMG.Cause(paraArray);
	},
	Remove	: function (paraName = -1) {
		if (paraName == -1) {
			instance_destroy(battleDamage);
			ds_map_clear(_content);
			return true;
		}
		if (Exists(paraName)) {
			instance_destroy(Find(paraName));
			ds_map_delete(_content, paraName);
		}
	},
	Free	: function () {
		ds_map_destroy(_content);
	}
};

Soul = {
	Mode		: SOUL_MODE.RED,
	Inv			: 0,
	Movenable	: false,
	Change : function (paraMode) {
		if (paraMode != Mode) {
			var objIdx = global.BattleHelper.Soul.GetObjectIndex(paraMode);
			if (not is_undefined(objIdx)) {
				with (battleSoul) {
					instance_create(x, y, objIdx);
					instance_destroy();
				}
				Mode = paraMode;
			}
		}
	},
	GetSprite : function () {
		var SPRITE = sprSoulRed;
		switch (Mode) {
			case SOUL_MODE.BLUE:
			SPRITE = sprSoulBlue;
			break;
		}
		return SPRITE;
	},
	SetUI : function (paraX, paraY) {
		if (not instance_exists(battleSoulUI)) then instance_create_depth(-100, -100, DEPTH.SOUL, battleSoulUI);
		battleSoulUI.x = paraX;
		battleSoulUI.y = paraY;
	},
	RemoveUI : function () {
		if (instance_exists(battleSoulUI)) then instance_destroy(battleSoulUI);
	}
};

Loot = {
	Exp		: 0,
	Gold	: 0
};

// Functions
GetTurnClass = function () {
	var CLASS;
	switch (TurnPhase) {
		case TURN_PHASE.PLAYER_INIT:
	    CLASS = TURN_CLASS.PLAYER;
		break;
		case TURN_PHASE.PLAYER_MAIN:
		CLASS = TURN_CLASS.PLAYER;
		break;
		case TURN_PHASE.PLAYER_BUTTON:
		CLASS = TURN_CLASS.PLAYER;
		break;
		case TURN_PHASE.PLAYER_END:
		CLASS = TURN_CLASS.PLAYER;
		break;
		case TURN_PHASE.ENEMY_INIT:
		CLASS = TURN_CLASS.ENEMY;
		break;
		case TURN_PHASE.ENEMY_MAIN:
		CLASS = TURN_CLASS.ENEMY;
		break;
		case TURN_PHASE.ENEMY_END:
		CLASS = TURN_CLASS.ENEMY;
		break;
		case TURN_PHASE.CUSTOM:
		CLASS = TURN_CLASS.CUSTOM;
		break;
	}
	
	return CLASS;
};

SetTurnPhase = function (paraTurnPhase) {
	TurnPhase = paraTurnPhase;
};

SetTurnIndex = function (paraIndex) {
	TurnIndex = paraIndex;
};

SetEncounter = function (paraEnumEncounter) {
	EncounterObject = WORLD_ENCOUNTER.Find(paraEnumEncounter);
};

LaunchEncounter = function () {
	SetEncounter(WORLD_ENCOUNTER.GetCache());
	Encounter = instance_create_depth(0, 0, 0, EncounterObject);
	with (Encounter) event_user(ENCOUNTER_EVENT.BATTLE_INIT);
	instance_create_depth(0, 0, DEPTH.BG, battleBackground);
	instance_create_depth(0, 0, DEPTH.UI, battleUI);
	instance_create_depth(0, 0, DEPTH.BOARD, battleBoard);
};

// Launch the battle
LaunchEncounter();