/// @desc Init
// Inherit the parent event
event_inherited();

#region Enemy Property
Info.Load("Sans", 119, 119, 1, 1, 100, 100);
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
#endregion

_counter = random(100);

#region Enemy Anim Config
_animCounter = 0;

var idleSpd = 15;
var idleRound = idleSpd * 4 * 2;
var idleRate = 1 / idleSpd / 2 * pi;

AnimSpriteHead = new EntitySprite();
AnimSpriteBody = new EntitySprite();

var hIdle = new EntityAnimation("Idle", sprEnemySansHead, idleRound, seqplay_loop);
var bIdle = new EntityAnimation("Idle", sprEnemySansIdle, idleRound, seqplay_loop);
hIdle.SetDefaultFrame(new EntityFrame(0, new Vector2D(2, 2), new Vector2D(0, -84), 0));
bIdle.SetDefaultFrame(new EntityFrame(0, new Vector2D(2, 2), new Vector2D(0, -40), 0));
AnimSpriteHead.AddAnim(hIdle);
AnimSpriteBody.AddAnim(bIdle);

for (var i = 0; i < idleRound; i ++) {
	var bodyPosX = sin(i * idleRate) * 1 * 2;
	var bodyPosY = sin(i * idleRate * 2) * 0.7 * 2 - 40;
	bIdle.AddFrame(i, new EntityFrame(0, new Vector2D(2, 2), new Vector2D(bodyPosX, bodyPosY), 0));
	hIdle.AddFrame(i, new EntityFrame(0, new Vector2D(2, 2), new Vector2D(	bodyPosX + sin(i * idleRate) * 0.1 * 2,
																			bodyPosY + sin(i * idleRate * 2) * 0.1 * 2 - 44), 0));
}

var bHOffsets = [[-2, 0], [0, 0], [3, 0], [5, 0], [3, 0]];
var bVOffsets = [[0, -2], [0, 0], [0, 3], [0, 5], [0, 3]];

var bRight = new EntityAnimation("Right", sprEnemySansHandH, 20, seqplay_oneshot);
var hRight = new EntityAnimation("Right", sprEnemySansHead, 20, seqplay_oneshot);
bRight.SetDefaultFrame(new EntityFrame(0, new Vector2D(2, 2), new Vector2D(0, -40), 0));
hRight.SetDefaultFrame(new EntityFrame(0, new Vector2D(2, 2), new Vector2D(0, -84), 0));
for (var i = 0; i < 5; i ++) {
	bRight.AddFrame(i * 2, new EntityFrame(i, new Vector2D(2, 2), new Vector2D(bHOffsets[i][0], bHOffsets[i][1] - 40), 0));
	hRight.AddFrame(i * 2, new EntityFrame(0, new Vector2D(2, 2), new Vector2D(bHOffsets[i][0], bHOffsets[i][1] - 84), 0));
}
AnimSpriteBody.AddAnim(bRight);
AnimSpriteHead.AddAnim(hRight);

var bLeft = new EntityAnimation("Left", sprEnemySansHandH, 20, seqplay_oneshot);
var hLeft = new EntityAnimation("Left", sprEnemySansHead, 20, seqplay_oneshot);
bLeft.SetDefaultFrame(new EntityFrame(4, new Vector2D(2, 2), new Vector2D(0, -40), 0));
hLeft.SetDefaultFrame(new EntityFrame(0, new Vector2D(2, 2), new Vector2D(0, -84), 0));
for (var i = 0; i < 5; i ++) {
	bLeft.AddFrame(i * 2, new EntityFrame(4 - i, new Vector2D(2, 2), new Vector2D(bHOffsets[4 - i][0], bHOffsets[4 - i][1] - 40), 0));
	hLeft.AddFrame(i * 2, new EntityFrame(0, new Vector2D(2, 2), new Vector2D(bHOffsets[4 - i][0], bHOffsets[4 - i][1] - 84), 0));
}
AnimSpriteBody.AddAnim(bLeft);
AnimSpriteHead.AddAnim(hLeft);

var bDown = new EntityAnimation("Down", sprEnemySansHandV, 20, seqplay_oneshot);
var hDown = new EntityAnimation("Down", sprEnemySansHead, 20, seqplay_oneshot);
bDown.SetDefaultFrame(new EntityFrame(0, new Vector2D(2, 2), new Vector2D(0, -40), 0));
hDown.SetDefaultFrame(new EntityFrame(0, new Vector2D(2, 2), new Vector2D(0, -84), 0));
for (var i = 0; i < 5; i ++) {
	bDown.AddFrame(i * 2, new EntityFrame(i, new Vector2D(2, 2), new Vector2D(bVOffsets[i][0], bVOffsets[i][1] - 40), 0));
	hDown.AddFrame(i * 2, new EntityFrame(0, new Vector2D(2, 2), new Vector2D(bVOffsets[i][0], bVOffsets[i][1] - 84), 0));

}
AnimSpriteBody.AddAnim(bDown);
AnimSpriteHead.AddAnim(hDown);

var bUp = new EntityAnimation("Up", sprEnemySansHandV, 20, seqplay_oneshot);
var hUp = new EntityAnimation("Up", sprEnemySansHead, 20, seqplay_oneshot);
bUp.SetDefaultFrame(new EntityFrame(4, new Vector2D(2, 2), new Vector2D(0, -40), 0));
hUp.SetDefaultFrame(new EntityFrame(0, new Vector2D(2, 2), new Vector2D(0, -84), 0));
for (var i = 0; i < 5; i ++) {
	bUp.AddFrame(i * 2, new EntityFrame(4 - i, new Vector2D(2, 2), new Vector2D(bVOffsets[4 - i][0], bVOffsets[4 - i][1] - 40), 0));
	hUp.AddFrame(i * 2, new EntityFrame(0, new Vector2D(2, 2), new Vector2D(bVOffsets[4 - i][0], bVOffsets[4 - i][1] - 84), 0));
}
AnimSpriteBody.AddAnim(bUp);
AnimSpriteHead.AddAnim(hUp);

AnimSpriteBody.SetDefaultAnim("Idle");
AnimSpriteHead.SetDefaultAnim("Idle");

AnimSpriteHead.Play("Idle");
AnimSpriteBody.Play("Idle");
#endregion


HandUp = function () {
	AnimSpriteBody.Play("Up", true);
	AnimSpriteHead.Play("Up", true);
	if (instance_exists(battleSoulBlue)) with (battleSoulBlue) Throw(90);
};

HandDown = function () {
	AnimSpriteBody.Play("Down", true);
	AnimSpriteHead.Play("Down", true);
	if (instance_exists(battleSoulBlue)) with (battleSoulBlue) Throw(-90);
};

HandLeft = function () {
	AnimSpriteBody.Play("Left", true);
	AnimSpriteHead.Play("Left", true);
	if (instance_exists(battleSoulBlue)) with (battleSoulBlue) Throw(180);
};

HandRight = function () {
	AnimSpriteBody.Play("Right", true);
	AnimSpriteHead.Play("Right", true);
	if (instance_exists(battleSoulBlue)) with (battleSoulBlue) Throw(0);
};