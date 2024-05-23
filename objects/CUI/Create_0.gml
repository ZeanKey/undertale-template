/// @desc Init
depth = DEPTH_UI.PANEL;

function UIStage() constructor{
    static __DefaultCallback__ = function () {};
	UI = other;
	_widgets = [];
	Bind = function (_widget) {
		array_push(_widgets, _widget);
	};
	Destroy = function () {
		for (var i = 0; i < array_length(_widgets); i ++) {
			if (instance_exists(_widgets[i])) {
				instance_destroy(_widgets[i]);
			}
		}
	};
	EntranceIn  = __DefaultCallback__;
	EntranceOut = __DefaultCallback__
	ExitIn      = __DefaultCallback__;
	ExitOut     = __DefaultCallback__;
}

Stage = {};
Stage.UI = self;
Stage.StageIndex = -1;
Stage._inputFuse   = false;
Stage._stages      = ds_map_create();


Stage.Register = function (_index, _stage) {
	ds_map_add(Stage._stages, _index, _stage);
};
Stage.InputRefresh = function () {
	Stage._inputFuse = false;
};
Stage.Destroy = function () {
	var _end = ds_map_size(Stage._stages);
	var _key = ds_map_keys_to_array(Stage._stages);
	for (var i = 0; i < _end; i ++) {
		Stage._stages[? _key[i]].Destroy();
	}
	ds_map_destroy(_content);
};
Stage.Get = function (_index) {
	return Stage._stages[? _index];
};
Stage.GetCurrent = function () {
    return Stage._stages[Stage.StageIndex];
};
Stage.GotoNext = function () {
	if (not (instance_exists(Stage.UI))) then return false;
	if (Stage._inputFuse) then return false;
	Stage._inputFuse = true;
	
	if (Stage.StageIndex == -1) {
	    Stage.StageIndex = 0;
	}
	else {
	    Stage._stages[? Stage.StageIndex].ExitOut();
	}
	if (not (instance_exists(Stage.UI))) then return false;
    Stage._stages[? Stage.StageIndex].EntranceIn();
};
Stage.GotoPrev = function () {
	if (not (instance_exists(Stage.UI))) then return false;
	if (Stage._inputFuse) then return false;
	Stage._inputFuse = true;
	
	Stage._stages[? Stage.StageIndex].EntranceOut();
	if (Stage.StageIndex == -1) {
	    instance_destroy();
	    return false;
	}
	Stage._stages[? Stage.StageIndex].ExitIn();
};


