/// @desc Update

// Alarms update
Alarms.Update();

// Event call - Pre Update
Events.PreUpdate.Call(self);

if (not instance_exists(id)) then exit;

// Init
var CHR_INDEX = floor(_typerCounter);
var CHR_CURRENT;
var COMMANDS, CUR_COMMAND_PACK, CUR_COMMAND, CUR_ARG_ARRAY;

// Create characters according to index (floored)
while (CHR_INDEX > _charIndex)
{
	// Update the counter
	_charIndex ++
	// Get the current character
	CHR_CURRENT = string_copy(_text, _charIndex + 1, 1);
	// Get the current command sheet
	COMMANDS = CommandSheet.Get(_charIndex);
	
	// Register the command
	for (var INDEX = 0; INDEX < array_length(COMMANDS); INDEX ++) {
		CUR_COMMAND_PACK	= COMMANDS[INDEX];
		CUR_COMMAND			= CUR_COMMAND_PACK[0];
		CUR_ARG_ARRAY		= [];
		array_copy(CUR_ARG_ARRAY, 0, CUR_COMMAND_PACK, 0, array_length(CUR_COMMAND_PACK))
		CUR_ARG_ARRAY[0] = [self, CHR_CURRENT];
		
		WORLD_TYPER.Command.TryCall(CUR_COMMAND, CUR_ARG_ARRAY);
	}
	
	// Try create the character / New line
	if (CHR_CURRENT != "\n") {
		var NEW_CHAR = new TyperCharacter(self, _relativePos.X, _relativePos.Y, CHR_CURRENT, Color, Font, Halign, Valign, XScale, YScale);
		draw_set_font(NEW_CHAR.GetFont());
		array_push(_textChars, NEW_CHAR);
		Events.PostNewChar.Call(self, NEW_CHAR);
		_relativePos.X += (Sep + string_width(CHR_CURRENT)) * XScale;
		var tmpOffsetX = 0;
		switch (Halign) {
			case 0:
			tmpOffsetX = 0;
			break;
			case 1:
			tmpOffsetX = -(Sep + string_width(CHR_CURRENT)) * XScale / 2;
			break;
			case 2:
			tmpOffsetX = -(Sep + string_width(CHR_CURRENT)) * XScale;
			break;
		}
		_relativePos.X += tmpOffsetX;
		Foreach(method({RelatY : _relativePos.Y, OffX : tmpOffsetX, CurChr : NEW_CHAR}, function (paraChr) {
			if (paraChr.RelativePos.Y == RelatY) {
				if (paraChr != CurChr) then paraChr.RelativePos.X += OffX;
			}
		}));
	}
	else {
		_relativePos.X = _newLineRX;
		_relativePos.Y += Leading;
		var tmpOffsetY = 0;
		switch (Valign) {
			case 0:
			tmpOffsetY = 0;
			break;
			case 1:
			tmpOffsetY = -Leading / 2;
			break;
			case 2:
			tmpOffsetY = -Leading;
			break;
		}
		_relativePos.Y += tmpOffsetY;
		Foreach(method({OffY : tmpOffsetY}, function (paraChr) {
			paraChr.RelativePos.Y += OffY;
		}));
	}
}

// Update all characters summoned
Refresh();

// Update index counter
_typerCounter += _typerSpd;

if (_typerCounter > string_length(_text) - 1) {
	if (not _isFullTyped) {
		Events.FullTyped.Call(self);
		_isFullTyped = true;
	}
	_typerCounter = string_length(_text) - 1;
}