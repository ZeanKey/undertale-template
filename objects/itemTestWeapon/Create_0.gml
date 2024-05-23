/// @desc Init
event_inherited();

Property.Name	= "Test Weapon";
Property.Info	= "* It is just a test weapon.\n* Can provide 1 ATK.";
Property.Class	= ITEM_CLASS.WEAPON;
Property.ATK	= 1;

Events.Info.Generate("Text Info");
Events.Drop.Generate();

Events.Use.Set(function (paraPos, paraModeIndex = (instance_exists(battle))) {
	switch (paraModeIndex) {
		case 0:
			WORLD_OVERWORLD.Typer.Generate.MenuDialog("* You equip the test weapon.");
			WORLD_PLAYER.Weapon.Equip(ITEM_INDEX.TEST_WEAPON);
			WORLD_PLAYER.Storage.Remove(paraPos);
		break;
		
		case 1:
			battle.Typer.Generate.ItemText("* You equip the test weapon.");
			WORLD_PLAYER.Weapon.Equip(ITEM_INDEX.TEST_WEAPON);
			WORLD_PLAYER.Storage.Remove(paraPos);
		break;
		
		case 2:
			var ATTACK = instance_create_depth(0, 0, 0, battleAttackKnife);
			ATTACK.Index = paraPos;
		break;
	}
});

Events.Info.Set(function (paraPos) {
	WORLD_OVERWORLD.Typer.Generate.MenuDialog("* Undescrible weapon.");
});

Events.Drop.Set(function (paraPos) {
	WORLD_OVERWORLD.Typer.Generate.MenuDialog("* You throw the test weapon.");
	WORLD_PLAYER.Storage.Remove(paraPos);
});
