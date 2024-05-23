/// @desc Init
// Inherit the parent event
event_inherited();

_entitySans = battle.Enemies.Find(0);

_flag		= array_create(64, 0);
_duration	= array_create(64, [-1, -1]);
_bone		= array_create(64, noone);
_plate		= array_create(64, noone);

_phase0 = new TurnSubPhase(id, TURN_SUBPHASE_TYPE.DIALOG);
_phase0.Events.EvStart.AddCallback(-1, function () {
	var boardCenter = battleBoard.Figs.Center();
	instance_create(boardCenter[0], boardCenter[1], battleSoulRed);
	Dialog.Add("space_sans_fight turn dream.", battle.Enemies.Find(0));
	Dialog.Generate();
});

_phase1 = new TurnSubPhase(id, TURN_SUBPHASE_TYPE.BATTLE);
_phase1.AddTimePoint(function () {
	//_blaster1 = instance_create(320, 240, bulletBlaster);
	//bulletBlaster.Init(0, 0, 320, 240, 180, 30, 2, 2);

}, 10);

_BoardHelper.SetInEase(65, 65, 65, 65, 30, new AnimCurveFormat(ANIM_TWEEN.CUBIC, ANIM_EASE.IN_OUT));


SubPhases.Add(_phase0);
SubPhases.Add(_phase1);
SubPhases.Launch();