if (_isInitialized) {
	if (Text != _textPrev) {
		Typer._text = Text;
		Typer.Instantize();
		Typer.ReGen();
		_textPrev = Text;
	}
}