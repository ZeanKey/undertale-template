if (_isInitialized) {
	if (Text != _textPrev) {
		_typer._text = Text;
		_typer.Instantize();
		_typer.ReGen();
		_textPrev = Text;
	}
}