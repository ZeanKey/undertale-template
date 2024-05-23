///@desc Button Confirm Call
if (not (IsChosen() && battle.TurnPhase == TURN_PHASE.PLAYER_BUTTON)) then exit;

switch (_phase) {
	case 0:
	var MULTI_CHOICE	= CreateMultiChoices();
	var TYPER_INFOS		= battle.Encounter.TyperPosition;
	var PAGE_COUNTER	= 0;
	var CONTENT			= WORLD_PLAYER.Storage.Copy();
	var CHOICE_X, CHOICE_Y, CHOICE_TXT;
	
	MULTI_CHOICE.Init();
	for (var INDEX = 0; INDEX < array_length(CONTENT); INDEX ++) {
		if (PAGE_COUNTER >= 4) then PAGE_COUNTER = 0;
		
		CHOICE_X = TYPER_INFOS.Dialog.X + 48 + ((PAGE_COUNTER) mod 2) * TYPER_INFOS.Space;
		CHOICE_Y = TYPER_INFOS.Dialog.Y + ((PAGE_COUNTER) div 2) * 32;
		CHOICE_TXT = "* " + CONTENT[INDEX].Property.Name;
			
		PAGE_COUNTER ++;
		
		MULTI_CHOICE.Add(CHOICE_X, CHOICE_Y, CHOICE_TXT);
	}
	MULTI_CHOICE.IsPage = true;
	MULTI_CHOICE.Generate();
	
	audio_play_sound(sndMenuConfirm, 0, 0);
	
	_choice = MULTI_CHOICE;
	_phase ++;
    break;
	
	case 1:
	var RESULT = _choice.Submit();
	
	battle.Soul.RemoveUI();
	WORLD_PLAYER.Storage.Get(RESULT).Use(RESULT);
	
	_phase ++;
    break;
	
	case 3:
	with (battleButton) Reset();
	battle.SetTurnPhase(TURN_PHASE.PLAYER_END);
    break;
        
    case 2:
    break;
		
    
        
}

