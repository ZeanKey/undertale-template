/// @desc Initialize & Register
Typer = {
	Command : {
		_content	: ds_map_create(),
		_typer		: ds_list_create(),
		Define : function (paraName, paraMethod, paraIsTyper = false) {
			ds_map_add(_content, paraName, paraMethod);
			if (paraIsTyper) then ds_list_add(_typer, paraName);
		},
		IsTyper : function (paraName) {
			return ds_list_find_index(_typer, paraName) == -1;
		},
		Exists : function (paraName) {
			return is_undefined(_content[? paraName]);
		},
		Find : function (paraName) {
			return ds_map_find_value(_content, paraName);
		},
		TryCall : function (paraName, paraArray) {
			var METHOD = Find(paraName);
			if (METHOD != undefined) then method_call(METHOD, paraArray);
		}
	},
	Color : {
		_content : ds_map_create(),
		Define : function (paraName, paraColor) {
			ds_map_add(_content, paraName, paraColor);
		},
		Find : function (paraName) {
			var COLOR = ds_map_find_value(_content, paraName);
			if (COLOR == undefined) then return c_white;
			return COLOR;
		}
	},
	Font : {
		_content : ds_map_create(),
		Define : function (paraName, paraEN, paraCN, paraOffset = new Vector2D(0, 0)) {
			ds_map_add(_content, paraName, [paraEN, paraCN, paraOffset]);
		},
		Find : function (paraName, paraLangIndex) {
			var FONT = ds_map_find_value(_content, paraName);
			if (FONT == undefined) then return font8bitMono10;
			return FONT[paraLangIndex];
		},
		GetOffset : function (paraName, paraLangIndex) {
			if (paraLangIndex == 0) then return (new Vector2D(0, 0));
			var FONT = ds_map_find_value(_content, paraName);
			if (FONT == undefined) then return (new Vector2D(0, 0));
			return FONT[2];
		},
	},
	GeneratePrefix : {
		Font : function (paraFont) {
			return "{Font " + string(paraFont) + "}";
		},
		Color : function (paraColor) {
			return "{Color " + string(paraColor) + "}";
		},
		Speed : function (paraSpd) {
			return "{Spd " + string(paraSpd) + "}";
		},
	},
};

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

#region Typer
#region Fonts
WORLD_TYPER.Font.Define("RegularWorld", font8bitMono10, fontZpix12, new Vector2D(0, 2));
WORLD_TYPER.Font.Define("RegularWorldUI", font8bitSans20, fontZpix19, new Vector2D(0, 2));
WORLD_TYPER.Font.Define("RegularBattle", font8bitMono20, fontZpix19, new Vector2D(0, 2));
WORLD_TYPER.Font.Define("SansWorld", fontSans12, fontSans12);
WORLD_TYPER.Font.Define("SansBattle", fontSans24, fontSans24);
WORLD_TYPER.Font.Define("UIWorld", fontCryptOfTomorrow, fontZpix19);
#endregion

#region Colors
WORLD_TYPER.Color.Define("White", c_white);
WORLD_TYPER.Color.Define("Grey", c_grey);
WORLD_TYPER.Color.Define("Gray", c_gray);
WORLD_TYPER.Color.Define("Black", c_black);
WORLD_TYPER.Color.Define("Red", c_red);
WORLD_TYPER.Color.Define("Orange", c_orange);
WORLD_TYPER.Color.Define("Yellow", c_yellow);
WORLD_TYPER.Color.Define("Green", c_green);
WORLD_TYPER.Color.Define("Aqua", c_aqua);
WORLD_TYPER.Color.Define("Blue", c_blue);
WORLD_TYPER.Color.Define("Purple", c_purple);
#endregion

#region Commands
// Type Argument
WORLD_TYPER.Command.Define("Color", function (paraTypers) {
	var TYPER = paraTypers[0];
	if (argument_count == 4) {
		TYPER.Color = make_color_rgb(real(argument1), real(argument2), real(argument3));
	}
	else
	{
		var ARG_COL_STR = argument1;
		TYPER.Color = WORLD_TYPER.Color.Find(ARG_COL_STR);
	}
});
WORLD_TYPER.Command.Define("Font", function (paraTypers, paraFontKey) {
	var TYPER = paraTypers[0];
	TYPER.Font = paraFontKey;
});
WORLD_TYPER.Command.Define("X", function (paraTypers, paraX) {
	var TYPER = paraTypers[0]
	TYPER.x = real(paraX);
});
WORLD_TYPER.Command.Define("Y", function (paraTypers, paraY) {
	var TYPER = paraTypers[0];
	TYPER.y = real(paraY);
});
WORLD_TYPER.Command.Define("Spd", function (paraTypers, paraSpd) {
	var TYPER = paraTypers[0];
	TYPER._typerSpd = real(paraSpd);
});
WORLD_TYPER.Command.Define("TextX", function (paraTypers, paraX) {
	var TYPER = paraTypers[0];
	with (TYPER) {
		var DELTA_X = real(paraX) - x;
		_newLineRX = DELTA_X;
		_relativePos.X = DELTA_X;
	}
});
WORLD_TYPER.Command.Define("TextY", function (paraTypers, paraY) {
	var TYPER = paraTypers[0];
	with (TYPER) {
		var DELTA_Y = real(paraY) - y;
		_relativePos.Y = DELTA_Y;
	}
});
WORLD_TYPER.Command.Define("Sep", function () {
	var ARG_TYPER	= argument0[0];
	var ARG_SEP		= argument1;
	ARG_TYPER.Sep	= real(ARG_SEP);
});
WORLD_TYPER.Command.Define("Leading", function () {
	var ARG_TYPER	= argument0[0];
	var ARG_LEADING	= argument1;
	ARG_TYPER.Leading	= real(ARG_LEADING);
});
WORLD_TYPER.Command.Define("Update", function () {
	var ARG_TYPER	= argument0[0];
	var ARG_CACHE	= argument1;
	ARG_TYPER.Cache.Write("Update", ARG_CACHE);
	ARG_TYPER.Events.PostNewChar.AddCallback(function () {
		var ARG_TYPER_PNC = argument0;
		var ARG_CHAR = argument1;
		ARG_CHAR._commandUpdateCacheName = ARG_TYPER_PNC.Cache.Read("Update")
		ARG_CHAR.Events.CharPreRender.AddCallback(function () {
			var ARG_CHAR_UDT = argument0;
			ARG_CHAR_UDT.RenderInfo.Chr = ARG_CHAR_UDT._typer.Cache.Read(ARG_CHAR_UDT._commandUpdateCacheName) + 1;
		});
		ARG_TYPER_PNC.Events.PostNewChar.RemoveCallback("Update");
	}, "Update");
});
WORLD_TYPER.Command.Define("Write", function () {
	var ARG_TYPER = argument0[0];
	var ARG_KEY = argument1;
	var ARG_VAL = argument2;
	if (argument_count == 4) {
		switch (argument3) {
			case "Asset":
			ARG_VAL = asset_get_index(argument2);
			break;
		}
	}
	ARG_TYPER.Cache.Write(ARG_KEY, ARG_VAL);
});
// Type - Swicth
WORLD_TYPER.Command.Define("GUI", function (paraTypers) {
	var TYPER = paraTypers[0];
	TYPER.GUI = true;
});
WORLD_TYPER.Command.Define("/GUI", function (paraTypers) {
	var TYPER = paraTypers[0];
	TYPER.GUI = false;
});
WORLD_TYPER.Command.Define("Colorful", function () {
	var ARG_TYPER	= argument0[0];
	ARG_TYPER.Events.PostNewChar.AddCallback(function () {
		var ARG_CHAR = argument1;
		ARG_CHAR.Events.CharPreRender.AddCallback(function () {
			var ARG_CHAR_UDT = argument0;
			ARG_CHAR_UDT.RenderInfo.Col = make_color_hsv(frac(get_timer() / 1000000) * 256, 256, 256);
		});
	}, "Colorful");
});
WORLD_TYPER.Command.Define("/Colorful", function () {
	var ARG_TYPER	= argument0[0];
	ARG_TYPER.Events.PostNewChar.RemoveCallback("Colorful");
});
WORLD_TYPER.Command.Define("Enter", function () {
	var ARG_TYPER	= argument0[0];
	ARG_TYPER.Events.PreUpdate.AddCallback(function () {
		if (input_check_pressed(INPUT.CONFIRM)) {
			var ARG_TYPER_UDT = argument0;
			if (ARG_TYPER_UDT._typerCounter == string_length(ARG_TYPER_UDT._text) - 1) {
				if (ARG_TYPER_UDT._textSaved != "") {
					with (ARG_TYPER_UDT) event_user(2);
				}
				else {
					instance_destroy(ARG_TYPER_UDT);
				}
			}
		}
	}, "Enter");
});
WORLD_TYPER.Command.Define("/Enter", function () {
	var ARG_TYPER	= argument0[0];
	ARG_TYPER.Events.PreUpdate.RemoveCallback("Enter");
});
WORLD_TYPER.Command.Define("Skip", function (_typers) {
	var tmpTyper = _typers[0];
	tmpTyper.Events.PreUpdate.AddCallback(function (_typer) {
		if (input_check_pressed(INPUT.CANCEL)) {
			_typer._typerCounter = string_length(_typer._text) - 1;
		}
	}, "Skip");
});
WORLD_TYPER.Command.Define("/Skip", function (_typers) {
	var tmpTyper = _typers[0];
	tmpTyper.Events.PreUpdate.RemoveCallback("Skip");
});
// Type - Instant
WORLD_TYPER.Command.Define("Instant", function (){
	var ARG_TYPER	= argument0[0];
	ARG_TYPER._typerCounter = string_length(ARG_TYPER._text) - 1;
});
#endregion
#endregion