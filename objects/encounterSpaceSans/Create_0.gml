/// @desc Load Data
event_inherited();

TyperPosition.Space		= 240;
TyperPosition.Dialog	= new Vector2D(52, 271);
TyperPosition.Bar		= new Vector2D(260, 0);
TyperPosition.Page		= new Vector2D(386, 335);

Buttons.Define(87,	453, 0, battleButtonFight);
Buttons.Define(240,	453, 1, battleButtonAct);
Buttons.Define(400,	453, 2, battleButtonItem);
Buttons.Define(555,	453, 3, battleButtonMercy);

Enemies.Define(320, 240, 0, enemySpace);

Mercy.Events.Add("Spare", function () {
	battle.SetTurnPhase(TURN_PHASE.PLAYER_END);
});
Mercy.Events.Add("Flee", function () {
	battle.SetTurnPhase(TURN_PHASE.PLAYER_END);
});

battle.Damage.Add("Karma", battleDamageKarma);