/// @desc Initialize & Register

// TODO
Overworld = {
	Boxes : {
		_content : [new Inventory(10),
					new Inventory(10)],
		Find : function (paraIndex) {
			return _content[paraIndex];
		}
	},
	Cell : {
		Enable : false,
		Mode : 0
	},
	UI : {
		Kills : {
			Enable : true,
		},
	},
	Typer : {
		IsTop : function () {
			if (instance_exists(entityPlayer)) {
				return entityPlayer.y - camera.y > 130 + entityPlayer.sprite_height;
			}
			return false;
		},
		PrefixFactory : function (paraFont, paraColor = "White", paraSkip = true, paraEnter = true, paraLeading = 36, paraGUI = true) {
			return "{Font " + paraFont + "}{Color " + paraColor + "}" + ((paraSkip) ? "{Skip}" : "") + ((paraEnter) ? "{Enter}" : "") + "{Leading" + paraLeading + "}" + ((paraGUI) ? "{GUI 1}" : "");
		},
		Generate : {
			Dialog : function (	paraTxt, paraPrefix = "{GUI 1}{Enter}{Skip}{Leading 36}{Font RegularBattle}{Color White}{Spd 0.33}", paraX = 32,
								paraY = (instance_exists(uiMenu)) ? ((uiMenu._top) ? 320 : 10) : 320, paraWidth = 578, paraHeight = 152,
								paraCallback = function () {if (instance_exists(entityPlayer)) {entityPlayer.IsUICaptured = false;entityPlayer.Movenable.Set("UI", true);}}) {
				if (instance_exists(entityPlayer)) {
					entityPlayer.IsUICaptured = true;
					entityPlayer.Movenable.Set("UI", false);
				}
				var TYPER	= instance_create_depth(paraX + 28, paraY + 21, DEPTH_UI.PANEL - 50, typer);
				TYPER._text = paraPrefix + paraTxt;
				with (TYPER) {
					Cache.Write("ODX", paraX);
					Cache.Write("ODY", paraY);
					Cache.Write("ODWidth", paraWidth);
					Cache.Write("ODHeight", paraHeight);
					Cache.Write("EDMethod", paraCallback);
					Events.PreRender.AddCallback(function () {
						var CACHE = Cache;
						var X = CACHE.Read("ODX");
						var Y = CACHE.Read("ODY");
						var WID = CACHE.Read("ODWidth");
						var HEI = CACHE.Read("ODHeight");
						var OTW = 6;
						draw_sprite_ext(sprPixel, 0, X, Y, WID, HEI, 0, c_white, 1);
						draw_sprite_ext(sprPixel, 0, X + OTW, Y + OTW, WID - 2 * OTW, HEI - 2 * OTW, 0, c_black, 1);
					});
					Events.Destroy.AddCallback(function (paraTyper) {
						method_call(paraTyper.Cache.Read("EDMethod"), []);
					});
					event_user(0);
				}
			
				return TYPER;
			},
			MenuDialog : function (	paraTxt, paraX = 32,
									paraY = (instance_exists(uiMenu)) ? ((uiMenu._top) ? 320 : 10) : 320, paraWidth = 578, paraHeight = 152,
									paraCallback = function () {if (instance_exists(uiMenu)) then instance_destroy(uiMenu);}) {
				var TYPER	= instance_create_depth(paraX + 28, paraY + 21, DEPTH_UI.PANEL - 50, typer);
				var PREFIX = "{GUI 1}{Enter}{Skip}{Leading 36}{Font RegularBattle}{Color White}{Spd 0.33}";
				TYPER._text = PREFIX + paraTxt;
				with (TYPER) {
					Cache.Write("ODX", paraX);
					Cache.Write("ODY", paraY);
					Cache.Write("ODWidth", paraWidth);
					Cache.Write("ODHeight", paraHeight);
					Cache.Write("EDMethod", paraCallback);
					Events.PreRender.AddCallback(function () {
						var CACHE = Cache;
						var X = CACHE.Read("ODX");
						var Y = CACHE.Read("ODY");
						var WID = CACHE.Read("ODWidth");
						var HEI = CACHE.Read("ODHeight");
						var OTW = 6;
						draw_sprite_ext(sprPixel, 0, X, Y, WID, HEI, 0, c_white, 1);
						draw_sprite_ext(sprPixel, 0, X + OTW, Y + OTW, WID - 2 * OTW, HEI - 2 * OTW, 0, c_black, 1);
					});
					Events.Destroy.AddCallback(function (paraTyper) {
						method_call(paraTyper.Cache.Read("EDMethod"), []);
					});
					event_user(0);
				}
			
				return TYPER;
			},
		},
	},
};

Encounter = {
	Init : function () {
		Cache = {};
		_encounterCache	= undefined;
		_encounterMap	= ds_map_create();
	},
	Exists : function (paraKey) {
		return not is_undefined(_encounterMap[? paraKey]);
	},
	Find : function (paraKey) {
		return _encounterMap[? paraKey];
	},
	Define : function (paraKey, paraObject) {
		ds_map_add(_encounterMap, paraKey, paraObject);
	},
	Start : function (paraKey, paraPlayer) {
		Cache._playerRenderer = paraPlayer.GetTransBattleRenderer();
		Cache._encounterIndex = paraKey;
		room_goto(roomTransBattle);
	},
	Launch : function (paraKey) {
		if (not WORLD_ENCOUNTER.Exists(paraKey)) then return false;
		_encounterCache = paraKey;
		room_goto(roomBattle);
	},
	GetCache : function () {
		return _encounterCache;	
	},
};
// TODO
Item = {
	Init : function () {
		_itemMap = ds_map_create();
	},
	Exists : function (paraKey) {
		return is_undefined(_itemMap[? paraKey]);
	},
	Find : function (paraKey) {
		return _itemMap[? paraKey];
	},
	Define : function (paraKey, paraObject) {
		var INSTANCE = instance_create_depth(0, 0, 0, paraObject);
		var STRUCT = {};
		with (INSTANCE) {
			STRUCT.Property = Property;
			STRUCT.Use		= Events.Use.Method();
			STRUCT.Info		= Events.Info.Method();
			STRUCT.Drop		= Events.Drop.Method();
			STRUCT.Index	= paraKey;
		}
		ds_map_add(_itemMap, paraKey, STRUCT);
		instance_destroy(INSTANCE);
	},
};
// TODO
Player = {
	Name	: "",
	HP		: {
		_player	: other,
		Value	: 20,
		Reduce	: function (paraVal) {
			Value -= paraVal;
			if (Value <= 0) {
				Value = 0;
				_player.Die();
			}
		}
	},
	MaxHP	: 20,
	Atk		: 0,
	Def		: 0,
	Exp		: 0,
	Lv		: 1,
	Kills	: 0,
	Gold	: 0,
		
	Weapon	: {
		_index		: undefined,
		_content	: undefined,
		Equip		: function (paraItemIndex) {
			if (not is_undefined(_index)) then WORLD_PLAYER.Storage.Add(_index);
			_index = paraItemIndex;
			_content = WORLD_ITEM.Find(paraItemIndex);
		},
		Set			: function (paraItemIndex) {
			_index = paraItemIndex;
			_content = WORLD_ITEM.Find(paraItemIndex);
		},
		Get			: function () {
			return _content;
		},
		GetIndex	: function () {
			return _index
		},
		GetValue	: function () {
			if (is_undefined(_content)) then return 0;
			return _content.Property.ATK;
		},
		GetName		: function () {
			if (is_undefined(_content)) then return "None";
			return _content.Property.Name;
		},
		Attack		: function (paraIndex) {
			if (is_undefined(_content)) {
				instance_create_depth(0, 0, 0, battleAttackNone).Index = paraIndex;
			}
			else {
				_content.Use(paraIndex, 2);
			}
		}
	},
	Armor	: {
		_index		: undefined,
		_content	: undefined,
		Equip		: function (paraItemIndex) {
			if (not is_undefined(_index)) then WORLD_PLAYER.Storage.Add(_index);
			_index = paraItemIndex;
			_content = WORLD_ITEM.Find(paraItemIndex);
		},
		Set			: function (paraItemIndex) {
			_index = paraItemIndex;
			_content = WORLD_ITEM.Find(paraItemIndex);
		},
		Get			: function () {
			return _content;
		},
		GetIndex	: function () {
			return _index
		},
		GetValue	: function () {
			if (is_undefined(_content)) then return 0;
			return _content.Property.DEF;
		},
		GetName		: function () {
			if (is_undefined(_content)) then return "None";
			return _content.Property.Name;
		},
	},
	Storage : new Inventory(8),
	Die		: function () {
		
	}
};

// Save
save.Bind("Timing", DATA_TYPE.VAL,
	method(world, function () {
		return GameTiming;
	}),
	method(world, function (paraVal) {
		GameTiming = real(paraVal);
	})
);
save.Bind("InvPlayer", DATA_TYPE.VAL,
	Player.Storage.GenSaveAccessor.Get(),
	Player.Storage.GenSaveAccessor.Set());
save.Bind("InvBox1", DATA_TYPE.VAL,
	Overworld.Boxes.Find(0).GenSaveAccessor.Get(),
	Overworld.Boxes.Find(0).GenSaveAccessor.Set());
save.Bind("PlayerStat", DATA_TYPE.VAL, 
	method(world.Player, function () {
		var tmpStruct = {
			Name	: Name,
			HP		: HP.Value,
			MaxHP	: MaxHP,
			Atk		: Atk,
			Def		: Def,
			Exp		: Exp,
			Lv		: Lv,
			Kills	: Kills,
			Gold	: Gold,
		};
		return json_stringify(tmpStruct);
	}),
	method(world.Player, function (paraStruct) {
		if (paraStruct != -1) {
			var tmpStruct = json_parse(paraStruct);
			Name		= tmpStruct.Name;
			HP.Value	= tmpStruct.HP;
			MaxHP		= tmpStruct.MaxHP;
			Atk			= tmpStruct.Atk;
			Def			= tmpStruct.Def;
			Exp			= tmpStruct.Exp;
			Lv			= tmpStruct.Lv;
			Kills		= tmpStruct.Kills;
			Gold		= tmpStruct.Gold;
		}
	})
);
save.Bind("PlayerWeapon", DATA_TYPE.VAL,
	method(world.Player, function () {
		return Weapon._index;
	}),
	method(world.Player, function (paraIndex) {
		if (paraIndex != -1) {
			Weapon.Set(paraIndex);
		}
	})
);
save.Bind("PlayerArmor", DATA_TYPE.VAL,
	method(world.Player, function () {
		return Weapon._index;
	}),
	method(world.Player, function (paraIndex) {
		if (paraIndex != -1) {
			Weapon.Set(paraIndex);
		}
	})
);

// Register
#region Encounters
WORLD_ENCOUNTER.Init();
WORLD_ENCOUNTER.Define(ENCOUNTER_INDEX.TEST, encounterTest);
WORLD_ENCOUNTER.Define(ENCOUNTER_INDEX.GBS_0, encounterGBS0);
WORLD_ENCOUNTER.Define(ENCOUNTER_INDEX.SSF, encounterSpaceSans);
#endregion

#region Items
WORLD_ITEM.Init();
WORLD_ITEM.Define(ITEM_INDEX.TEST_FOOD, itemTestFood);
WORLD_ITEM.Define(ITEM_INDEX.TEST_WEAPON, itemTestWeapon);
WORLD_ITEM.Define(ITEM_INDEX.BURNT_PAN, itemBurntPan);
WORLD_ITEM.Define(ITEM_INDEX.AIR_COLUMN_BAG, itemAirColBag);
#endregion

event_user(1);