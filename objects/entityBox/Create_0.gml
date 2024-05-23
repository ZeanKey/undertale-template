/// @desc Init
event_inherited();

Box = WORLD_OVERWORLD.Boxes.Find(0);

Interact = function () {
	var UI_DIALOG = instance_create_depth(0, 0, 0, uiDialog);
	var GENERATOR = new UI_DIALOG.SelectorDataGenerator();
	
	GENERATOR.Add(UI_DIALOG.x + 120, UI_DIALOG.y + 100, GENERATOR.Text("是"));
	GENERATOR.Add(UI_DIALOG.x + 420, UI_DIALOG.y + 100, GENERATOR.Text("否"));
	var CHOICE_0 = GENERATOR.Generate()
	
	UI_DIALOG.Add("0", "* 嗷嗷呜", DIALOG_TYPE.SELECTOR, CHOICE_0);
	UI_DIALOG.Add("00", "", DIALOG_TYPE.CALLBACK, function (paraDialog) {
		paraDialog._resumenable = false;
		instance_create_depth(0, 0, 0, uiBox, {_boxLinked : Box});
	});
	UI_DIALOG.Launch();
}