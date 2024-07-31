///@desc Init
bktglitch_init();

// TODO
_isNamed = false;

GameTiming = 0;

// TODO
global.SaveManager		= instance_create(0, 0, save);
global.ScreenManager	= instance_create(0, 0, screen);
global.CameraManager	= instance_create(0, 0, camera);

save.Init();
if (!save.Exists(0))
{
	save.New(0);
}

// Initialize template
event_user(0);

save.Load(0);

repeat (5) WORLD_OVERWORLD.Boxes.Find(1).Add(ITEM_INDEX.AIR_COLUMN_BAG)


with (screen) {
	// This is an example of how to add a screen effect(permenent)
	Shake = function (paraMagnitude, paraTime) {
		var EFFECT = Cache.Read("EffectShake");
		EFFECT.Timer += paraTime;
		EFFECT.Magnitude += paraMagnitude;
	};
	
	Cache.Write("EffectShake", {Timer : 0, Magnitude : 0});

	var EFF_SHAKE_FUNC = function () {
		var CACHE = Cache.Read("EffectShake");
		var MAGNITUDE	= CACHE.Magnitude;
		var TIMER		= CACHE.Timer;
		
		if (TIMER > 0) {
			RenderSettings.Offset.X = random_range(-MAGNITUDE, MAGNITUDE);
			RenderSettings.Offset.Y = random_range(-MAGNITUDE, MAGNITUDE);
			CACHE.Timer --;
			CACHE.Magnitude /= 1 + log2(TIMER) / 200;
		}
		else {
			CACHE.Timer = 0;
			CACHE.Magnitude = 0;
		}
	}

	Events.Update.AddCallback("Shake2D", EFF_SHAKE_FUNC);
}

room_goto(roomLaunch);
exit;

if (_isNamed)
{
	room_goto(roomMainMenu);
}
else
{
	room_goto(roomNaming);
}