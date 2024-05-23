///@desc Button Cancel Call
if (not (IsChosen() && battle.TurnPhase == TURN_PHASE.PLAYER_BUTTON)) then exit;

switch (_phase) {
	case 1:
	_choice.Destroy();
	battle.SetTurnPhase(TURN_PHASE.PLAYER_INIT);
	_phase --;
	break;
}