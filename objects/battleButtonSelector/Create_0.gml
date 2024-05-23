///@desc Init
depth = DEPTH.BOARD - 50;

IsPage = false;

_page	= 0;
_index	= 0;

_typerPage = noone;

function Choice(paraX, paraY, paraTxt, paraManager, paraPos = -1) constructor {
	var POS = paraPos;
	if (POS == -1) then POS = ds_list_size(paraManager._choiceLst) - 1;
	_x		= paraX;
	_y		= paraY;
	_txt	= paraTxt;
	_pos	= paraPos;
	_typer	= noone;
	_owner	= paraManager;
	
	Create = function (paraIsPage, paraPage = 0) {
		_typer = battle.Typer.Generate.RegularChoice(_x, _y, _txt);
		if (paraIsPage) {
			_typer.Cache.Write("Manager", _owner);
			_typer.Cache.Write("Page", paraPage);
			_typer.Events.PreRender.AddCallback(function () {
				var ARG_CHAR	= argument0[1];
				var TYPER		= argument0[0];
				var MANAGER		= TYPER.Cache.Read("Manager");
				var PAGE		= TYPER.Cache.Read("Page");
			
				if (instance_exists(MANAGER)) {
					TYPER.RenderEnable = (MANAGER._page == PAGE);
				}
			});
		}
		return _typer;
	};
};

NewChoiceMethod = function (paraTyperRed) {
	
};

CustomRender = function () {
	
};

Cache = {
	
};

Init = function () {
	_choiceLst = ds_list_create();
};

Add = function (paraX, paraY, paraTxt, paraPos = -1) {
	ds_list_add(_choiceLst, new Choice(paraX, paraY, paraTxt, self, paraPos));
};

Generate = function () {
	var TYPER, CHOICE;
	var PAGE
	for (var INDEX = 0; INDEX < ds_list_size(_choiceLst); INDEX ++) {
		CHOICE	= _choiceLst[| INDEX];
		PAGE	= INDEX div 4;
		TYPER	= CHOICE.Create(IsPage, PAGE);
		NewChoiceMethod(TYPER);
	}
	
	if (IsPage) {
		var TYPER_INFOS		= battle.Encounter.TyperPosition;
		var TYPER_PAGE		= battle.Typer.Generate.RegularChoice(TYPER_INFOS.Page.X, TYPER_INFOS.Page.Y, "PAGE {Update PageNumber}1");
		
		TYPER_PAGE.Cache.Write("Manager", self);
		TYPER_PAGE.Cache.Write("PageNumber", 1);
		TYPER_PAGE.Events.PreRender.AddCallback(function () {
			var TYPER		= argument0[0];
			var MANAGER		= TYPER.Cache.Read("Manager");
			
			if (instance_exists(MANAGER)) then TYPER.Cache.Write("PageNumber", MANAGER._page);
		});
		
		_typerPage = TYPER_PAGE;
	}
};

Input = function () {
	if (input_check_pressed(INPUT.LEFT)) {
	    _index --;
		audio_play_sound(sndMenuSwitch,0,0);
	}
	else if (input_check_pressed(INPUT.RIGHT)) {
	    _index ++;
		audio_play_sound(sndMenuSwitch,0,0);
	}

	_index = clamp_loop(_index, 0, ds_list_size(_choiceLst) - 1);
};

Free = function () {
	var TYPER, CHOICE;
	for (var INDEX = 0; INDEX < ds_list_size(_choiceLst); INDEX ++) {
		CHOICE	= _choiceLst[| INDEX];
		TYPER	= CHOICE._typer;
		if (TYPER != noone) then instance_destroy(TYPER);
	}
}

Destroy = function () {
	instance_destroy();
}

Submit = function () {
	var ANS = _index;
	instance_destroy();
	return ANS;
}