/// @desc Init
event_inherited();

// Constructors - Selector Data Generator
function SelectorDataGenerator() constructor {
	_content = [];
	Text = function (paraText, paraFont = "RegularWorldUI", paraCol = "White", paraSpd = 0.33) {
		return "{GUI 1}" + WORLD_TYPER.GeneratePrefix.Font(paraFont) + WORLD_TYPER.GeneratePrefix.Color(paraCol) + WORLD_TYPER.GeneratePrefix.Speed(paraSpd) + paraText;
	};
	Add = function (paraX, paraY, paraTxt) {
		array_push(_content, [paraX, paraY, paraTxt]);
	};
	Generate = function () {
		var ARRAY = [];
		array_copy_fixed(ARRAY, _content);
		_content = [];
		return ARRAY;
	};
}

// Pre Init - Identify dialog window's position
_top = false;
if (instance_exists(entityPlayer)) {
	_top = entityPlayer.y - camera.y > 130 + entityPlayer.sprite_height;
	entityPlayer.IsUICaptured = true;
	entityPlayer.Movenable.Set("UI", false);
}

// Init - Property
x = 32;
y = (_top) ? 320 : 10;
_prefix		 = "{GUI 1}{Skip}{Leading 36}{Font RegularBattle}{Color White}{Spd 0.33}";
_width		 = 578;
_height		 = 152;
_callback	 = function () {};
_resumenable = true;
// Init - Data
_textbase	 = ds_map_create();
_typer		 = noone;

// Functions
// Trans selector array to dialog text
DataToDialog = function (paraArray) {
	var DIA_STR = "";
	for (var INDEX = 0; INDEX < array_length(paraArray); INDEX ++) {
		DIA_STR += "{TextX " + string(paraArray[INDEX][0]) + "}";
		DIA_STR += "{TextY " + string(paraArray[INDEX][1]) + "}";
		DIA_STR += paraArray[INDEX][2];
	}
	return DIA_STR;
};
// Trans selector array to selector choices(position only)
DataSimplify = function (paraArray) {
	var ARRAY_OUT = [];
	array_copy_fixed(ARRAY_OUT, paraArray);
	for (var INDEX = 0; INDEX < array_length(ARRAY_OUT); INDEX ++) {
		ARRAY_OUT[INDEX][2] = " "; 
	}
	return ARRAY_OUT;
};
// Add single dialog
Add = function (paraKey, paraText, paraType, paraArg) {
	var TEXT = paraText;
	switch (paraType) {
		case DIALOG_TYPE.ENTER:
		break;
		case DIALOG_TYPE.SELECTOR:
		TEXT += DataToDialog(paraArg);
		break;
	}
	ds_map_add(_textbase, paraKey, [TEXT, paraType, paraArg]);
};
// Update typer to next dialog
Next = function (paraTyper) {
	// Empty check
	if (not ds_map_exists(_textbase, paraTyper.Cache.DialogIndex)) {
		instance_destroy(paraTyper);
		instance_destroy();
		return false;
	}
	var CONTENT = _textbase[? paraTyper.Cache.DialogIndex];
	// Read dialog
	paraTyper.Cache.DialogType = CONTENT[1];
	// Case - Callback
	if (CONTENT[1] == DIALOG_TYPE.CALLBACK) {
		CONTENT[2](self);
		instance_destroy(paraTyper);
		instance_destroy();
		return true;
	}
	// Case - Selector
	if (CONTENT[1] == DIALOG_TYPE.SELECTOR) {
		// Define callbacks
		with (paraTyper) {
			var FUNC_RENDER = function () {
				if (Cache.Selector.IsActivated) {
					var CHOICE = Cache.Selector._origin[Cache.Selector._choiceIndex]
					draw_sprite_ext(sprUISoul, 0, CHOICE[0] - 24, CHOICE[1] + 7, 2, 2, 0, -1, 1);
				}
			};
			var FUNC_UPDATE = function () {
				with (Cache.Selector) {
					if (IsActivated) {
						if (not _isCooling) {
							if (input_check_pressed(INPUT.LEFT)) {
								_choiceIndex --;
							}
							else if (input_check_pressed(INPUT.RIGHT)) {
								_choiceIndex ++;
							}
							_choiceIndex = clamp_loop(_choiceIndex, 0, array_length(_choices) - 1);
						}
					}
					_choiceIndex = clamp_loop(_choiceIndex, 0, array_length(_choices) - 1);
				}
			};
		}
		// Define selector data
		var CONTENT_SELECTOR = DataSimplify(CONTENT[2]);
		// Set
		paraTyper.Cache.Selector = Widget.Add.Menu(CONTENT_SELECTOR, function () {}, function () {}, FUNC_RENDER, FUNC_UPDATE);
		paraTyper.Cache.Selector.IsActivated = false;
		paraTyper.Cache._origin = CONTENT_SELECTOR;
	}
	// Reset typer
	with (paraTyper) {
		CommandSheet.Empty();
		_text			= CONTENT[0];
		_textSaved		= "";
		_textChars		= [];
		_charIndex		= -1;
		_isFullTyped	= false;
		_typerCounter	= 0;
		_relativePos.X	= 0;
		_relativePos.Y	= 0;
		event_user(0);
	}
	// Return
	return true;
};
// Initialize and launch typer
Launch = function () {
	var CONTENT = _textbase[? "0"];
	// Typer Init - Text settings
	_typer = instance_create_depth(x + 28, y + 21, DEPTH_UI.PANEL - 50, typer);
	_typer._text = _prefix + CONTENT[0];
	// Typer Init - Selector
	_typer.Cache.Selector		= noone;
	_typer.Cache.DialogType		= CONTENT[1];
	_typer.Cache.DialogIndex	= "0";
	
	if (CONTENT[1] == DIALOG_TYPE.SELECTOR) {
		with (_typer) {
			var FUNC_RENDER = function () {
				if (Cache.Selector.IsActivated) {
					var CHOICE = Cache.Selector._origin[Cache.Selector._choiceIndex]
					draw_sprite_ext(sprUISoul, 0, CHOICE[0] - 24, CHOICE[1] + 7, 2, 2, 0, -1, 1);
				}
			};
			var FUNC_UPDATE = function () {
				with (Cache.Selector) {
					if (IsActivated) {
						if (not _isCooling) {
							if (input_check_pressed(INPUT.LEFT)) {
								_choiceIndex --;
							}
							else if (input_check_pressed(INPUT.RIGHT)) {
								_choiceIndex ++;
							}
							_choiceIndex = clamp_loop(_choiceIndex, 0, array_length(_choices) - 1);
						}
					}
					_choiceIndex = clamp_loop(_choiceIndex, 0, array_length(_choices) - 1);
				}
			};
		}
		// Define selector data
		var CONTENT_SELECTOR = DataSimplify(CONTENT[2]);
		// Set
		_typer.Cache.Selector = Widget.Add.Menu(CONTENT_SELECTOR, function () {}, function () {}, FUNC_RENDER, FUNC_UPDATE);
		_typer.Cache.Selector.IsActivated = false;
		_typer.Cache._origin = CONTENT_SELECTOR;
	}
	
	// Typer Plugins
	#region Typer Plugin - Dialog new page
	_typer.Events.PreUpdate.AddCallback(function () {
		if (input_check_pressed(INPUT.CONFIRM)) {
			if (_typer._isFullTyped) {
				if (_typer.Cache.DialogType == DIALOG_TYPE.ENTER)
				{
					_typer.Cache.DialogIndex += "0";
				}
				else if (_typer.Cache.DialogType == DIALOG_TYPE.SELECTOR){
					_typer.Cache.DialogIndex += string(_typer.Cache.Selector._choiceIndex);
					instance_destroy(_typer.Cache.Selector);
				}
				Next(_typer);
			}
		}
	});
	#endregion
	
	#region Typer Plugin - Dialog selector
	with (_typer) {
		Events.FullTyped.AddCallback(function () {
			if (instance_exists(Cache.Selector)) then Cache.Selector.IsActivated = true;
		});
	}
	#endregion
	
	#region Typer Plugin - Dialog window
	with (_typer) {
		Cache.Write("ODX", other.x);
		Cache.Write("ODY", other.y);
		Cache.Write("ODWidth", other._width);
		Cache.Write("ODHeight", other._height);
		Cache.Write("EDMethod", other._callback);
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
	}
	#endregion
	
	// Typer Ignition
	with (_typer) {
		event_user(0);
	}
};