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

Enemies.Define(220, 240, 0, enemyTest);
Enemies.Define(420, 240, 1, enemyTest);

Mercy.Events.Add("Spare", function () {
	battle.Enemies.Spare();
	with (battleButton) Reset();
	if (not battle.Enemies.Remains()) {
		battle.SetTurnPhase(TURN_PHASE.CUSTOM);
		var V_EXP = string(battle.Loot.Exp);
		var V_GOLD = string(battle.Loot.Gold);
		battle.Typer.Generate.Winning("* YOU WON!\n* You earned " + V_EXP + " EXP and " + V_GOLD + " gold.");
	}
	else {
		battle.SetTurnPhase(TURN_PHASE.PLAYER_END);
	}
});
Mercy.Events.Add("Flee", function () {
	if (irandom(0) == 0) {
		battle.SetTurnPhase(TURN_PHASE.CUSTOM);
		var V_EXP = string(battle.Loot.Exp);
		var V_GOLD = string(battle.Loot.Gold);
		battle.Typer.Generate.Flee("* Escaped...");
		battleSoulUI.SoulUIMode = SOUL_UI_MODE.FLEE;
	}
});

//battle.Damage.Add("Karma", battleDamageKarma);