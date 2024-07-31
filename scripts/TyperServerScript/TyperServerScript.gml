TyperServer = {};

TyperServer.Command = {};
with (TyperServer.Command) {
	_content = ds_map_create();
	_typer = ds_list_create();
	Define = function (paraName, paraMethod, paraIsTyper = false) {
		ds_map_add(_content, paraName, paraMethod);
		if (paraIsTyper) then ds_list_add(_typer, paraName);
	};
	IsTyper = function (paraName) {
			return ds_list_find_index(_typer, paraName) == -1;
	};
	Exists = function (paraName) {
		return is_undefined(_content[? paraName]);
	};
	Find = function (paraName) {
		return ds_map_find_value(_content, paraName);
	};
	TryCall = function (paraName, paraArray) {
		var METHOD = Find(paraName);
		if (METHOD != undefined) then method_call(METHOD, paraArray);
	};
}

TyperServer.Color = {};
with (TyperServer.Color) {
	_content = ds_map_create();
	Define = function (paraName, paraColor) {
		ds_map_add(_content, paraName, paraColor);
	};
	Find = function (paraName) {
		var COLOR = ds_map_find_value(_content, paraName);
		if (COLOR == undefined) then return c_white;
		return COLOR;
	};
}

TyperServer.Font = {};
with (TyperServer.Font) {
	_content = ds_map_create();
	Define = function (paraName, paraEN, paraCN, paraOffset = new Vector2D(0, 0)) {
		ds_map_add(_content, paraName, [paraEN, paraCN, paraOffset]);
	};
	Find = function (paraName, paraLangIndex) {
		var FONT = ds_map_find_value(_content, paraName);
		if (FONT == undefined) then return font8bitMono10;
		return FONT[paraLangIndex];
	};
	GetOffset = function (paraName, paraLangIndex) {
		if (paraLangIndex == 0) then return (new Vector2D(0, 0));
		var FONT = ds_map_find_value(_content, paraName);
		if (FONT == undefined) then return (new Vector2D(0, 0));
		return FONT[2];
	};
};

TyperServer.GeneratePrefix = {};
with (TyperServer.GeneratePrefix) {
	Font = function (paraFont) {
		return "{Font " + string(paraFont) + "}";
	};
	Color = function (paraColor) {
		return "{Color " + string(paraColor) + "}";
	};
	Speed = function (paraSpd) {
		return "{Spd " + string(paraSpd) + "}";
	};
};