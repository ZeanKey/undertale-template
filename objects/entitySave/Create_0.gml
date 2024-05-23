/// @desc Init
event_inherited();

image_speed = 1 / 3;

_name = "";

CallMenu = function (paraTyper) {
	paraTyper.Cache.Write("EDMethod", function () {
		instance_create_depth(0, 0, 0, uiSave).Generate(_name);
	});
};

GenerateMenu = function (paraName, paraText) {
	_name = paraName;
	CallMenu(WORLD_OVERWORLD.Typer.Generate.Dialog(paraText));
};

Interact = function (paraEntity, paraSide) {
	GenerateMenu("", "* 如果你看到这句话，那么很显然，\n你忘记初始化了");
};
