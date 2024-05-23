/// @desc Init
// Inherit the parent event
event_inherited();

Duration = {
	_turn : other,
	_content : array_create(32, 0),
	Exists : function (paraIndex) {
		if (array_length(paraIndex) <= paraIndex) {
			return false;
		}
		var DUR_ARR = _content[paraIndex];
		if (not is_array(DUR_ARR)) {
			return false;
		}
		return true;
	},
	Set : function (paraIndex, paraStart, paraEnd) {
		_content[paraIndex] = [paraStart, paraEnd];
	},
	SetStart : function (paraIndex, paraVal) {
		if (not Exists(paraIndex)) {
			_content[paraIndex] = [-2, -2];
		}
		_content[paraIndex][0] = paraVal;
	},
	SetEnd : function (paraIndex, paraVal) {
		if (not Exists(paraIndex)) {
			_content[paraIndex] = [-2, -2];
		}
		_content[paraIndex][1] = paraVal;
	},
	In : function (paraIndex) {
		if (array_length(paraIndex) > paraIndex) {
			return false;
		}
		
		var DUR_ARR = _content[paraIndex];
		if (not is_array(DUR_ARR)) {
			return false;
		}
		
		if (_turn._timer >= DUR_ARR[0]) && (_turn._timer <= DUR_ARR[1]) {
			return true;
		}
		return false;
	}
};

Spot = {
	_turn : other,
	_content : array_create(30, -2),
	At : function (paraIndex) {
		if (paraIndex <= array_length(_content)) {
			return false;
		}
		return (_content[paraIndex] == _turn._timer)
	}
};

Dialog = {
	_turn : other,
	_queue : ds_queue_create(),
	Free : function () {
		ds_queue_destroy(_queue);
	},
	Add : function (paraTxt, paraEnemy, paraBubble = {Sprite : sprSpeechBubbles, Offset : new Vector2D(40, -20)}, paraEnter = true, paraRawOut = false) {
		var PREFIX = "";
		var TXT = paraTxt;
		if (not paraRawOut) {
			if (paraEnter) then PREFIX += "{Enter}";
			var TYPER_INFO = paraEnemy.TyperInfo;
			PREFIX += "{Write EDBubble " + sprite_get_name(paraBubble.Sprite) + " Asset}";
			PREFIX += "{Write EDOffsetX " + string(paraBubble.Offset.X) + "}";
			PREFIX += "{Write EDOffsetY " + string(paraBubble.Offset.Y) + "}";
			PREFIX += "{X " + string(TYPER_INFO.GetX() + paraBubble.Offset.X) + "}";
			PREFIX += "{Y " + string(TYPER_INFO.GetY() + paraBubble.Offset.Y) + "}";
			PREFIX += "{Color "	+ string(TYPER_INFO.Color) + "}";
			PREFIX += "{Font " + string(TYPER_INFO.Font) + "}";
			PREFIX += "{Sep " + string(TYPER_INFO.Sep) + "}";
			PREFIX += "{Leading " + string(TYPER_INFO.Leading) + "}";
			PREFIX += "{Sound " + string(TYPER_INFO.Sound) + "}";
		}
		TXT = PREFIX + TXT;
		ds_queue_enqueue(_queue, TXT);
	},
	Generate : function (paraMethod = _turn.SubPhases.Next) {
		var TXT = "";
		while (not ds_queue_empty(_queue)) {
			TXT += ds_queue_dequeue(_queue);
			if (not ds_queue_empty(_queue)) {
				TXT += "\f";
			}
		}
		battle.Typer.Generate.EnemyDialog(TXT, paraMethod);
	}
};

TimerSetState.Dialog();
