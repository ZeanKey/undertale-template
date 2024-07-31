/// @desc Typer Init
#region Fonts
global.TyperServer.Font.Define("RegularWorld", font8bitMono10, fontZpix12, new Vector2D(0, 2));
global.TyperServer.Font.Define("RegularWorldUI", font8bitSans20, fontZpix19, new Vector2D(0, 2));
global.TyperServer.Font.Define("RegularBattle", font8bitMono20, fontZpix19, new Vector2D(0, 2));
global.TyperServer.Font.Define("SansWorld", fontSans12, fontSans12);
global.TyperServer.Font.Define("SansBattle", fontSans24, fontSans24);
global.TyperServer.Font.Define("UIWorld", fontCryptOfTomorrow, fontZpix19);
#endregion

#region Colors
global.TyperServer.Color.Define("White", c_white);
global.TyperServer.Color.Define("Grey", c_grey);
global.TyperServer.Color.Define("Gray", c_gray);
global.TyperServer.Color.Define("Black", c_black);
global.TyperServer.Color.Define("Red", c_red);
global.TyperServer.Color.Define("Orange", c_orange);
global.TyperServer.Color.Define("Yellow", c_yellow);
global.TyperServer.Color.Define("Green", c_green);
global.TyperServer.Color.Define("Aqua", c_aqua);
global.TyperServer.Color.Define("Blue", c_blue);
global.TyperServer.Color.Define("Purple", c_purple);
#endregion

#region Commands
// Type - Property
global.TyperServer.Command.Define("Color", function (paraTypers) {
	var TYPER = paraTypers[0];
	if (argument_count == 4) {
		TYPER.Color = make_color_rgb(real(argument1), real(argument2), real(argument3));
	}
	else
	{
		var ARG_COL_STR = argument1;
		TYPER.Color = global.TyperServer.Color.Find(ARG_COL_STR);
	}
});
global.TyperServer.Command.Define("Font", function (paraTypers, paraFontKey) {
	var TYPER = paraTypers[0];
	TYPER.Font = paraFontKey;
});
global.TyperServer.Command.Define("X", function (paraTypers, paraX) {
	var TYPER = paraTypers[0]
	TYPER.x = real(paraX);
});
global.TyperServer.Command.Define("Y", function (paraTypers, paraY) {
	var TYPER = paraTypers[0];
	TYPER.y = real(paraY);
});
global.TyperServer.Command.Define("Spd", function (paraTypers, paraSpd) {
	var TYPER = paraTypers[0];
	TYPER._typerSpd = real(paraSpd);
});
global.TyperServer.Command.Define("TextX", function (paraTypers, paraX) {
	var TYPER = paraTypers[0];
	with (TYPER) {
		var DELTA_X = real(paraX) - x;
		_newLineRX = DELTA_X;
		_relativePos.X = DELTA_X;
	}
});
global.TyperServer.Command.Define("TextY", function (paraTypers, paraY) {
	var TYPER = paraTypers[0];
	with (TYPER) {
		var DELTA_Y = real(paraY) - y;
		_relativePos.Y = DELTA_Y;
	}
});
global.TyperServer.Command.Define("Sep", function () {
	var ARG_TYPER	= argument0[0];
	var ARG_SEP		= argument1;
	ARG_TYPER.Sep	= real(ARG_SEP);
});
global.TyperServer.Command.Define("Leading", function () {
	var ARG_TYPER	= argument0[0];
	var ARG_LEADING	= argument1;
	ARG_TYPER.Leading	= real(ARG_LEADING);
});
global.TyperServer.Command.Define("Update", function () {
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
global.TyperServer.Command.Define("Write", function () {
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
global.TyperServer.Command.Define("GUI", function (paraTypers) {
	var TYPER = paraTypers[0];
	TYPER.GUI = true;
});
global.TyperServer.Command.Define("/GUI", function (paraTypers) {
	var TYPER = paraTypers[0];
	TYPER.GUI = false;
});
global.TyperServer.Command.Define("Colorful", function () {
	var ARG_TYPER	= argument0[0];
	ARG_TYPER.Events.PostNewChar.AddCallback(function () {
		var ARG_CHAR = argument1;
		ARG_CHAR.Events.CharPreRender.AddCallback(function () {
			var ARG_CHAR_UDT = argument0;
			ARG_CHAR_UDT.RenderInfo.Col = make_color_hsv(frac(get_timer() / 1000000) * 256, 256, 256);
		});
	}, "Colorful");
});
global.TyperServer.Command.Define("/Colorful", function () {
	var ARG_TYPER	= argument0[0];
	ARG_TYPER.Events.PostNewChar.RemoveCallback("Colorful");
});
global.TyperServer.Command.Define("Enter", function () {
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
global.TyperServer.Command.Define("/Enter", function () {
	var ARG_TYPER	= argument0[0];
	ARG_TYPER.Events.PreUpdate.RemoveCallback("Enter");
});
global.TyperServer.Command.Define("Skip", function (_typers) {
	var tmpTyper = _typers[0];
	tmpTyper.Events.PreUpdate.AddCallback(function (_typer) {
		if (input_check_pressed(INPUT.CANCEL)) {
			_typer._typerCounter = string_length(_typer._text) - 1;
		}
	}, "Skip");
});
global.TyperServer.Command.Define("/Skip", function (_typers) {
	var tmpTyper = _typers[0];
	tmpTyper.Events.PreUpdate.RemoveCallback("Skip");
});
// Type - Instant
global.TyperServer.Command.Define("Instant", function () {
	var ARG_TYPER	= argument0[0];
	ARG_TYPER._typerCounter = string_length(ARG_TYPER._text) - 1;
});
// Type - Once
// Sound
//		Give typer the effect of clicking when creating the new char.
// example : "{sound sound_index sound_interval}"
global.TyperServer.Command.Define("Sound", function (typerParams, soundName, soundInterval = 4) 
{
	var typerReceived = global.TyperHelper.Command.DecodeTyperArgs(typerParams).Typer;
	typerReceived.Cache.__soundAssetName	= soundName;
	typerReceived.Cache.__soundCooldown		= 0;
	typerReceived.Cache.__soundInterval		= soundInterval;

	typerReceived.Events.PostNewChar.AddCallback(method(typerReceived, function (_) {
		var index = asset_get_index(Cache.__soundAssetName);
		if (index != -1) {
			if (Cache.__soundCooldown <= 0) {
				audio_play_sound(index, 0, 0);
				Cache.__soundCooldown = Cache.__soundInterval;
			}
			Cache.__soundCooldown --;
		}
	}), "Sound");
});
#endregion