///@desc Screen Reset
// Debug text depth setting
depth = DEPTH_UI.SCREEN;

// Debug switch
_debug = false;
// Surface variable defination
_surfFinal = -1;
// Instance timer
_timer = 0;

Events = {
	Update		: new Event(),
	PreRender	: new Event(),
	PostRender	: new Event()
};

RenderSettings = {
	Offset : new Vector2D(0, 0),
	Reset : function () {
		Offset.X = 0;
		Offset.Y = 0;
	},
};

Cache = {
	Write : function (paraKey, paraVal) {
		variable_struct_set(self, paraKey, paraVal);
	},
	Read : function (paraKey) {
		return variable_struct_get(self, paraKey);
	},
};