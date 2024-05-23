/// @desc Init
// Inherit the parent event
event_inherited();

_phase0 = new TurnSubPhase(id, TURN_SUBPHASE_TYPE.DIALOG);
_phase0.Events.EvStart.AddCallback(-1, function () {
	Dialog.Add("{Color Blue}Standard Training-Dummy{Color Black}\nNo.1.", battle.Enemies.Find(0));
	Dialog.Add("{Color Blue}Standard Training-Dummy{Color Black}\nNo.2.", battle.Enemies.Find(1));
	Dialog.Generate();
});

_phase1 = new TurnSubPhase(id, TURN_SUBPHASE_TYPE.BATTLE);
_phase1.AddTimePoint(function () {
}, 10);
_phase1.AddTimePoint(function () {
	_bone1 = global.Bullet.Bone.Create(320, 320, new BulletConfig({
		Size : 20,
		IsOnBoard : true
	}, {
		Step : new Event(function (paraBullet) {
			paraBullet.image_angle ++;
		}),
		Create : new Event(function (paraBullet) {
			paraBullet.SetOrigin(BONE_ORIGIN.CENTER);
		})}, global.Bullet.Bone.Configs.Regular));
	_blaster1 = instance_create(320, 240, bulletBlaster);
	bulletBlaster.Init(0, 0, 320, 240, 180, 30, 2, 2);
}, 10);

SubPhases.Add(_phase0);
SubPhases.Add(_phase1);
SubPhases.Launch();