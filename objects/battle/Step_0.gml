/// @desc Battle Main Loop
switch (TurnPhase) {
	case TURN_PHASE.PLAYER_INIT:
	Encounter.Cache.Update(ENCOUNTER_CACHE.DIALOG);
	Typer.Generate.MainDialog(Encounter.Cache.DialogText);
	SetTurnPhase(TURN_PHASE.PLAYER_MAIN);
	break;
	
	case TURN_PHASE.PLAYER_MAIN:
	Buttons.Update();
	break;
	
	case TURN_PHASE.PLAYER_BUTTON:
	Buttons.Update();
	break;
	
	case TURN_PHASE.PLAYER_END:
	Encounter.Cache.Update(ENCOUNTER_CACHE.TURN);
	instance_create_depth(0, 0, DEPTH.DEBUG, Encounter.Cache.TurnObject);
	SetTurnPhase(TURN_PHASE.ENEMY_INIT);
	break;
	
	case TURN_PHASE.ENEMY_INIT:
	
	break;
	
	case TURN_PHASE.ENEMY_MAIN:
		
	break;
		
	case TURN_PHASE.ENEMY_END:
	SetTurnPhase(TURN_PHASE.PLAYER_INIT);
	break;
}