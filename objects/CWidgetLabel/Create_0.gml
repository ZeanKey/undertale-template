depth = DEPTH_UI.PANEL - 50;

Typer   = noone;
Text    = "";

_isInitialized  = false;
_textPrev       = "";

GetProcessedText = function () {
	return Typer.GetProcessedText();
};

Gen = function (_x, _y, _txt) {
	Typer = instance_create(_x, _y, typer);
	Typer._text = _txt;
	Typer.depth = depth;
	with (Typer) {
		event_user(0);
		Instantize();
	}
	
	_isInitialized = true;
	_textPrev   = _txt;
	Text        = _txt;
};

Recolor = function (_color) {
	if not (_isInitialized) then exit;
	Typer.Foreach(method({_color : _color}, function (_chr) {
		_chr.Color = _color
	}));
}

Remove = function () {
	instance_destroy();
};