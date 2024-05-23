/// @desc Init
depth = DEPTH_UI.PANEL;

function Stage(paraParent) constructor{
	_parent = paraParent;
	_widgets = [];
	Register = function (paraWidget) {
		array_push(_widgets, paraWidget);
	};
	ForceDestroy = function () {
		for (var INDEX = 0; INDEX < array_length(_widgets); INDEX ++) {
			if (instance_exists(_widgets[INDEX])) {
				instance_destroy(_widgets[INDEX]);
			}
		}
	};
	EntranceIn = function () {
		
	};
	EntranceOut = function () {
		
	};
	ExitIn = function () {
		
	};
	ExitOut = function () {
		
	};
}

GenerateText = function (paraText, paraFont = "RegularWorldUI", paraCol = "White") {
	return "{GUI 1}" + WORLD_TYPER.GeneratePrefix.Font(paraFont) + WORLD_TYPER.GeneratePrefix.Color(paraCol) + paraText;
};

Widget = {
	Add : {
		Window : function (paraX, paraY, paraWidth, paraHeight) {
			 var WINDOW = instance_create_depth(0, 0, 0, widgetWindow);
			 WINDOW.Init(paraX, paraY, paraWidth, paraHeight);
			 return WINDOW;
		},
		Label : function (paraX, paraY, paraTxt, paraFont = "RegularWorldUI", paraCol = "White") {
			var LABEL = instance_create_depth(0, 0, 0, widgetLabel);
			var PREFIX = "{GUI 1}{Instant}" + WORLD_TYPER.GeneratePrefix.Font(paraFont) + WORLD_TYPER.GeneratePrefix.Color(paraCol);
			LABEL.Init(paraX, paraY, PREFIX + paraTxt);
			return LABEL;
		},
		Menu : function (paraChoices, paraSubmit, paraCancel, paraRender, paraUpdate = -1, paraRepos = false) {
			var MENU = instance_create_depth(0, 0, 0, widgetMenu);
			MENU.Init(paraChoices, paraSubmit, paraCancel, paraRender, paraUpdate, paraRepos);
			return MENU;
		},
		Step : function (paraUpdate = -1, paraRender = -1) {
			var STEP = instance_create_depth(0, 0, 0, widgetStep);
			if (paraUpdate != -1) then STEP.Update = paraUpdate;
			if (paraRender != -1) then STEP.Render = paraRender;
			return STEP;
		},
	},
};

Stages = {
	_parent		: other,
	_fuse		: false,
	_content	: ds_map_create(),
	_level		: -1,
	Define : function (paraIndex, paraStage) {
		ds_map_add(_content, paraIndex, paraStage);
	},
	FuseOff : function () {
		_fuse = false;
	},
	Destroy : function () {
		var SIZE = ds_map_size(_content);
		var KEYS = ds_map_keys_to_array(_content);
		for (var INDEX = 0; INDEX < SIZE; INDEX ++) {
			_content[? KEYS[INDEX]].ForceDestroy();
		}
		ds_map_destroy(_content);
	},
	Get : function (paraIndex) {
		return _content[? paraIndex];
	},
	Next : function () {
		if (not (instance_exists(_parent.id))) then return false;
		if (not _fuse) then _fuse = true;
		else if (_fuse) then return false;
		
		if (_level == -1) {
			_level = 0;
		}
		else _content[? _level].ExitOut();
		if (not (instance_exists(_parent.id))) then return false;
		_content[? _level].EntranceIn();
	},
	Back : function () {
		if (not (instance_exists(_parent.id))) then return false;
		if (not _fuse) then _fuse = true;
		else if (_fuse) then return false;
		
		_content[? _level].EntranceOut();
		if (_level == -1) {
			with (_parent) instance_destroy();
			exit;
		}
		_content[? _level].ExitIn();
	},
};


