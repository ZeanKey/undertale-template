/// @desc Init
event_inherited();

Property.Name	= "气柱袋";
Property.Info	= "";
Property.Class	= ITEM_CLASS.FOOD;

Events.Use.Set(function (paraPos, paraModeIndex = (instance_exists(battle))) {
	switch (paraModeIndex) {
		case 0:
		audio_play_sound(sndItemSwallow, 0, 0);
		WORLD_OVERWORLD.Typer.Generate.MenuDialog("* 你吃了气柱袋。\f* 为什么要吃这种东西啊。");
		WORLD_PLAYER.Storage.Remove(paraPos);
		break;
		case 1:
		audio_play_sound(sndItemSwallow, 0, 0);
		battle.Typer.Generate.ItemText("* 你吃了气柱袋。\f* 为什么要吃这种东西啊。");
		WORLD_PLAYER.Storage.Remove(paraPos);
		break;
	}
});

Events.Info.Set(function (paraPos) {
	WORLD_OVERWORLD.Typer.Generate.MenuDialog("* 气柱袋，俗称包装箱气囊。\n* 放在这种根本不会被搬运的箱子里。\n* 毋庸置疑，就是垃圾。");
});

Events.Drop.Set(function (paraPos) {
	WORLD_OVERWORLD.Typer.Generate.MenuDialog("* 你把气柱袋放到了它应该处于的地方。");
	WORLD_PLAYER.Storage.Remove(paraPos);
});
