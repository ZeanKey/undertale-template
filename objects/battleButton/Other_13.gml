/// @desc Main Confirm Call
if (Pressenable) {
	battle.SetTurnPhase(TURN_PHASE.PLAYER_BUTTON);
	Confirm();
	with (typer) event_user(10);
}