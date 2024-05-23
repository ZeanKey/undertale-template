/// @desc Init
// Inherit the parent event
event_inherited();

Info.Load("Test", 119, 119, 1, 1, 100, 100);
Info.Missenable = false;
Info.IsSpared	= false;

ActChoices.Add(0, "Check 1");
ActChoices.Add(1, "Check 2");

TyperInfo.Color		= "Black";
TyperInfo.Font		= "RegularWorld";
TyperInfo.Sep		= 0;
TyperInfo.Leading	= 16;
TyperInfo.Sound		= SND_NONE;
TyperInfo.GetX = function () {
	return x + 20;
};
TyperInfo.GetY = function () {
	return y - 90;
};

AimPos = new Vector2D(x, y - 70);

ButtonCall = function (paraEnumButton, paraIndex) {
	switch (paraEnumButton) {
		case BATTLE_BUTTON.ACT:
		switch (paraIndex) {
			case 0:
			battle.Typer.Generate.ActText("* Test enemy.\f* 100 ATK 100 DEF.");
			//battle_createDialogNormal(60,287,"* Test enemy.↓* 100 ATK 100 DEF.");
			break;
			case 1:
			battle.Typer.Generate.ActText("* Test message.")
			break;
		}
		break;
	}
}

TryHit = function (paraVal) {
	if (Info.Missenable) {
		
	}
	else {
		Hit(paraVal);
	}
};

Spare = function () {
	if (Info.Spareable) then Remove();
	Info.IsSpared = true;
};

_counter = random(100);