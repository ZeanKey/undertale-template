/// @desc Init
function TyperEvent() constructor {
	Callbacks = [];
	AddCallback = function (paraFunc, paraKey = array_length(Callbacks)) {
		array_push(Callbacks, [paraFunc, paraKey]);
	};
	RemoveCallback = function (paraKey = -1) {
		if (paraKey == -1) {
			Callbacks = [];
		}
		else {
			for (var INDEX = 0; INDEX < array_length(Callbacks); INDEX ++) {
				if (Callbacks[INDEX][1] == paraKey) {
					array_delete(Callbacks, INDEX, 1);
					INDEX --;
				}
			}
		}
	};
	Call = function () {
		var CUR_FUNC;
		var ARG_ARR = []
		for (var INDEX = 0; INDEX < argument_count; INDEX ++) {
			array_push(ARG_ARR, argument[INDEX]);
		}
		for (var INDEX = 0; INDEX < array_length(Callbacks); INDEX ++) {
			CUR_FUNC = Callbacks[INDEX][0];
			method_call(CUR_FUNC, ARG_ARR);
		}
	};
}

function TyperCharacter(paraTyper, paraRX, paraRY, paraChar, paraColor, paraFont, paraHalign, paraValign, paraXScale, paraYScale) constructor {	
	var CHR = self;
	_typer		= paraTyper;
	_align		= new Vector2D(paraHalign, paraValign);
	
	Char		= paraChar;
	Pos			= new Vector2D(paraTyper.x + paraRX, paraTyper.y + paraRY);
	Scale		= new Vector2D(paraXScale, paraYScale);
	RelativePos = new Vector2D(paraRX, paraRY);
	Color		= paraColor;
	Font		= paraFont;
	FontIndex	= ord(paraChar) > 180;
	
	RenderInfo	= {
		_char	: CHR,
		Chr		: "",
		Pos		: new Vector2D(0, 0),
		Col		: 0,
		Fnt		: 0,
		XScale	: 0,
		YScale	: 0,
		Alpha	: 0,
		Angle	: 0,
		Update	: function () {
			var OFFSET = _char.GetFontOffset();
			Chr		= _char.Char;
			Pos.X	= _char.Pos.X + OFFSET.X;
			Pos.Y	= _char.Pos.Y + OFFSET.Y;
			Col		= _char.Color;
			Fnt		= _char.GetFont();
			XScale	= _char.Scale.X;
			YScale	= _char.Scale.Y;
			Alpha	= 1;
			Angle	= 0;
		}
	};
	
	Events		= {
		CharPreRender	: new _typer.TyperEvent(),
		CharPosRender	: new _typer.TyperEvent(),
		CharUpdate		: new _typer.TyperEvent(),
	};
	
	Update = function () {
		Pos.X = _typer.x + RelativePos.X;
		Pos.Y = _typer.y + RelativePos.Y;
		RenderInfo.Update();
	};
	GetFont = function () {
		return WORLD_TYPER.Font.Find(Font, FontIndex);
	};
	GetFontOffset = function () {
		return WORLD_TYPER.Font.GetOffset(Font, FontIndex);
	};
	Render = function () {
		Events.CharPreRender.Call(self);
		draw_set_halign(_align.X);
		draw_set_valign(_align.Y);
		draw_set_font(RenderInfo.Fnt);
		draw_text_transformed_color(RenderInfo.Pos.X, RenderInfo.Pos.Y,
									RenderInfo.Chr, RenderInfo.XScale, RenderInfo.YScale, RenderInfo.Angle,
									RenderInfo.Col, RenderInfo.Col, RenderInfo.Col, RenderInfo.Col, RenderInfo.Alpha);
		Events.CharPosRender.Call(self);
	};
}

Events = {
	PostNewChar : new TyperEvent(),
	PreUpdate	: new TyperEvent(),
	PreRender	: new TyperEvent(),
	PostRender	: new TyperEvent(),
	FullTyped	: new TyperEvent(),
	Destroy		: new TyperEvent(),
	Custom		: new TyperEvent()
};

CommandSheet = {
	_content : ds_map_create(),
	Add : function (paraPos, paraArray) {
		if (ds_map_find_value(_content, paraPos) == undefined) then ds_map_add(_content, paraPos, []);
		array_push(ds_map_find_value(_content, paraPos), paraArray);
	},
	Get : function (paraPos) {
		if (ds_map_find_value(_content, paraPos) == undefined) then return [];
		return ds_map_find_value(_content, paraPos);
	},
	Free : function () {
		ds_map_destroy(_content);
	},
	Empty : function () {
		ds_map_clear(_content);
	}
};

Alarms = {
	_content : [],
	Add : function (paraStart, paraEnd, paraMethod) {
		array_push(_content, [paraStart, paraEnd, paraMethod]);
	},
	Update : function () {
		for (var INDEX = 0; INDEX < array_length(_content); INDEX ++) {
			_content[INDEX][0] ++;
			if (_content[INDEX][0] >= _content[INDEX][1]) {
				_content[INDEX][2]();
				array_delete(_content, INDEX, 1);
				INDEX --;
			}
		}
	}
};

Cache = {
	Write : function (paraKey, paraVal) {
		variable_struct_set(self, paraKey, paraVal);
	},
	Read : function (paraKey) {
		return variable_struct_get(self, paraKey);
	}
};

//depth = DEPTH.UI_HIGH;

_text = "";
_textSaved = "";
_textChars = [];

GUI			= false;

Font		= "RegularBattle";
Color		= c_white;
Sep			= 0;
Leading		= 20;
Halign		= 0;
Valign		= 0;
XScale		= 1;
YScale		= 1;

RenderEnable = true;

_relativePos = new Vector2D(0, 0);
_isFullTyped = false;
_charIndex = -1;

_typerCounter	= 0;
_typerSpd		= 1;

_newLineRX		= 0;

Instantize = function () {
	_typerCounter = string_length(_text) - 1;
	event_perform(ev_step, 0);
};

SetHalign = function (paraHalign) {
	Halign = paraHalign;
	ReGen();
};

SetValign = function (paraValign) {
	Valign = paraValign;
	ReGen();
};

SetText = function (paraTxt) {
	_text = paraTxt;
	ReGen();
};

GetText = function (paraTxt) {
	return _text;
};

GetProcessedText = function (paraTxt) {
	var tmpTxt = ""
	for (var INDEX = 0; INDEX < array_length(_textChars); INDEX ++) {
		tmpTxt += string(_textChars[INDEX].Char);
	}
	return tmpTxt;
};

ReGen = function () {
	CommandSheet.Empty();
	_textSaved		= "";
	_textChars		= [];
	_charIndex		= -1;
	_isFullTyped	= false;
	_relativePos.X	= 0;
	_relativePos.Y	= 0;
	event_user(0);
	var tmpSpd = _typerSpd;
	_typerSpd = 0;
	event_perform(ev_step, 0);
	_typerSpd = tmpSpd;
};

RePos = function () {
	Foreach(function (paraChr) {
		
	});
};

Refresh = function () {
	for (var INDEX = 0; INDEX < array_length(_textChars); INDEX ++) {
		_textChars[INDEX].Update();
	}
};

Foreach = function (paraMethod) {
	var CUR_CHR;
	for (var INDEX = 0; INDEX < array_length(_textChars); INDEX ++) {
		CUR_CHR = _textChars[INDEX];
		if (is_struct(CUR_CHR) && is_instanceof(CUR_CHR, TyperCharacter)) {
			paraMethod(CUR_CHR);
		}
	}
};