/// @desc Process Raw Text
// Init
var TXT_ORIGIN		= _text;
var TXT_PROCESSED	= "";

var GM_INDEX, CUR_CHAR;

var COMMAND_LOADING		= false;
var COMMAND_ARG_INDEX	= 0;
var COMMAND_CURRENT;

// Scan the text input
for (var INDEX = 0; INDEX < string_length(TXT_ORIGIN); INDEX ++) {
	GM_INDEX = INDEX + 1;
	CUR_CHAR = string_copy(TXT_ORIGIN, GM_INDEX, 1);
	
	// Case - New page
	if (CUR_CHAR == "\f") {
		_textSaved = string_copy(TXT_ORIGIN, GM_INDEX + 1, string_length(TXT_ORIGIN) - GM_INDEX);
		break;
	}
	
	// Case - Command start
	if (CUR_CHAR == "{") {
		COMMAND_LOADING		= true;
		COMMAND_CURRENT		= [];
		COMMAND_ARG_INDEX	= 0;
		continue;
	}
	
	// Case - Command end
	if (CUR_CHAR == "}") {
		COMMAND_LOADING = false;
		CommandSheet.Add(string_length(TXT_PROCESSED), COMMAND_CURRENT);
		continue;
	}
	
	// Case - Scan character to command array
	if (COMMAND_LOADING) {
		if (CUR_CHAR == " ") {
			COMMAND_ARG_INDEX ++;
			continue;
		}
		
		if (COMMAND_ARG_INDEX + 1 > array_length(COMMAND_CURRENT)) then COMMAND_CURRENT[COMMAND_ARG_INDEX] = ""
		
		COMMAND_CURRENT[COMMAND_ARG_INDEX] += CUR_CHAR;
		continue;
	}
	
	// Case - Scan character to render string
	TXT_PROCESSED += CUR_CHAR;
}

// Set render string
_text = TXT_PROCESSED;

