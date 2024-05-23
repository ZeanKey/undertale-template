///@desc Cache Update Dialog
var DIALOG_TEXT = undefined;

switch (battle.TurnIndex) {
    case 0:
	DIALOG_TEXT = "* Turn 0."
	break;
	
	case 1:
	DIALOG_TEXT = "* Turn 1."
	break;
}

Cache.DialogText = DIALOG_TEXT;
