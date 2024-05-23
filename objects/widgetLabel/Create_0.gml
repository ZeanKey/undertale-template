/// @desc
_typer = noone;
_recolor = c_white;
_isInitialized = false;
_textPrev = "";

Text = "";

GetTyper = function () {
	return _typer;
};

GetProcessedText = function () {
	return _typer.GetProcessedText();
};

Init = function (paraX, paraY, paraText) {
	_typer = instance_create(paraX, paraY, typer);
	_typer._text = paraText;
	_typer.depth = DEPTH_UI.PANEL - 50;
	with (_typer) {
		event_user(0);
		Instantize();
	}
	_textPrev = paraText;
	Text = paraText;
	_isInitialized = true;
};

Recolor = function (paraColor) {
	if (not instance_exists(_typer)) then exit;
	_recolor = paraColor;
	_typer.Foreach(function (paraChr) {
		paraChr.Color = _recolor
	});
}

Remove = function () {
	instance_destroy();
};