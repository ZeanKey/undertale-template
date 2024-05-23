/// @desc Init
event_inherited();

Property.Name	= "Test Food";
Property.Info	= "* It is just a test food.\n* Can Heal 1 HP.";
Property.Class	= ITEM_CLASS.FOOD;

Events.Use.Set(function (paraPos, paraModeIndex = (instance_exists(battle))) {
	switch (paraModeIndex) {
		case 0:
		audio_play_sound(sndItemSwallow, 0, 0);
		WORLD_OVERWORLD.Typer.Generate.MenuDialog("* Overworld item text.\f* Item text page 2.");
		WORLD_PLAYER.Storage.Remove(paraPos);
		break;
		case 1:
		audio_play_sound(sndItemSwallow, 0, 0);
		battle.Typer.Generate.ItemText("* Battle item text.\f* Item text page 2.");
		WORLD_PLAYER.Storage.Remove(paraPos);
		break;
	}
});

Events.Info.Set(function (paraPos) {
	WORLD_OVERWORLD.Typer.Generate.MenuDialog("* Undescrible.");
});

Events.Drop.Set(function (paraPos) {
	WORLD_OVERWORLD.Typer.Generate.MenuDialog("* You throw the test food.");
	WORLD_PLAYER.Storage.Remove(paraPos);
});
