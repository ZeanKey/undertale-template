/// @desc Init
event_inherited();

Property.Name	= "Burnt Pan";
Property.Info	= "* It is just a test weapon.\n* Can provide 1 ATK.";
Property.Class	= ITEM_CLASS.WEAPON;
Property.ATK	= 10;

Events.Info.Generate("Text Info");
Events.Drop.Generate();

Events.Use.Set(function (paraPos, paraModeIndex = (instance_exists(battle))) {
	switch (paraModeIndex) {
		case 0:
			WORLD_OVERWORLD.Typer.Generate.MenuDialog("* You equip the burnt pan.");
			WORLD_PLAYER.Weapon.Equip(ITEM_INDEX.BURNT_PAN);
			WORLD_PLAYER.Storage.Remove(paraPos);
		break;
		
		case 1:
			battle.Typer.Generate.ItemText("* You equip the burnt pan.");
			WORLD_PLAYER.Weapon.Equip(ITEM_INDEX.BURNT_PAN);
			WORLD_PLAYER.Storage.Remove(paraPos);
		break;
		
		case 2:
			var ATTACK = instance_create_depth(0, 0, 0, battleAttackBurntPan);
			ATTACK.Index = paraPos;
		break;
	}
});

Events.Info.Set(function (paraPos) {
	WORLD_OVERWORLD.Typer.Generate.MenuDialog("* Damage is rather consistent. \nConsumable items heal 4 more HP.");
});

Events.Drop.Set(function (paraPos) {
	WORLD_OVERWORLD.Typer.Generate.MenuDialog("* You throw the burnt pan.");
	WORLD_PLAYER.Storage.Remove(paraPos);
});
