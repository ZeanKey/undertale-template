///@desc Button Confirm Call
if (not (IsChosen() && battle.TurnPhase == TURN_PHASE.PLAYER_BUTTON)) then exit;

switch (_phase) {
	case 0:
	var MULTI_CHOICE	= CreateMultiChoices();
	var TYPER_INFOS		= battle.Encounter.TyperPosition;
	var CHOICE_X, CHOICE_Y, CHOICE_TXT, CUR_TXT, PREFIX;
	
	MULTI_CHOICE.Init();
	CHOICE_X = TYPER_INFOS.Dialog.X + 48;
	CHOICE_TXT = battle.Encounter.Mercy.Events.GetNames();
	
	for (var INDEX = 0; INDEX < ds_list_size(CHOICE_TXT); INDEX ++) {
		CHOICE_Y	= TYPER_INFOS.Dialog.Y + 32 * INDEX;
		CUR_TXT		= CHOICE_TXT[| INDEX];
		PREFIX		= "* ";
		if (CUR_TXT == "Spare") then PREFIX = ((battle.Enemies.Find(INDEX).Info.Spareable) ? battle.Encounter.Mercy.Color : "") + PREFIX;
		CUR_TXT		=  PREFIX + CUR_TXT;
		
		MULTI_CHOICE.Add(CHOICE_X, CHOICE_Y, CUR_TXT);
	}
	MULTI_CHOICE.Generate();
	
	audio_play_sound(sndMenuConfirm, 0, 0);
	
	_choice = MULTI_CHOICE;
	_choiceArray = CHOICE_TXT;
	_phase ++;
	break;
		
	case 1:
	var RESULT = _choice.Submit();
	
	if (_choiceArray[| RESULT] != "Flee") {
		battle.Soul.RemoveUI();
	}
	battle.Encounter.Mercy.Events.Call(_choiceArray[| RESULT]);
	
	_phase ++;
	break;
		
	case 2:
		
	break;
}

