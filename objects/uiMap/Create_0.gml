/// @desc Init
event_inherited();

_regionsGet = [
    {
        Name : "Ruins",
        CompPerc : 0,
    },
    {
        Name : "Snowdin",
        CompPerc : 0,
    },
    {
        Name : "Waterfall",
        CompPerc : 0,
    },
    {
        Name : "Hotland",
        CompPerc : 0,
    },
    {
        Name : "Snowdin",
        CompPerc : 0,
    }
];

var STAGE_0, STAGE_1, STAGE_2;
STAGE_0	= new Stage(self);
STAGE_1	= new Stage(self);
STAGE_2	= new Stage(self);

STAGE_0.Result = 0;
STAGE_0.EntranceIn = function () {
	var STAGE_0 = Stages.Get(0);
	var MENU = global.UIHelper.Menu;
	MENU.Gen.Start(STAGE_0);
	MENU.Gen.AddEncodedString("{x 20}{y 20}[ ]{x 20}{y 60}[ ]");
	MENU.Gen.Override(UI_CALLBACK_RENDER, method(STAGE_0, function () {
	    draw_sprite(sprUIMapButtons, 0, 320, 240);
	}));
	MENU.Gen.Rebind(UI_MENU_KEYBIND_CANCEL, INPUT.NULL);
	STAGE_0.Menu = MENU.Gen.End();
	
	STAGE_0.LabelRegion = Widget.Add.Label(32, 320, $"Ruins");
	STAGE_0.LabelRegion.GetTyper().XScale = 2;
	STAGE_0.LabelRegion.GetTyper().YScale = 2;
	STAGE_0.LabelRegion.GetTyper().ReGen();
	STAGE_0.Register(STAGE_0.LabelRegion);
	STAGE_0.LabelCompPerc = Widget.Add.Label(32, 370, $"Complete: 0%");
	STAGE_0.LabelCompPerc.GetTyper().XScale = 0.5;
	STAGE_0.LabelCompPerc.GetTyper().YScale = 0.5;
	STAGE_0.LabelCompPerc.GetTyper().ReGen();
	STAGE_0.Register(STAGE_0.LabelCompPerc);
	STAGE_0.LabelCompPerc = Widget.Add.Label(32, 400, $"前往该地区?");
	STAGE_0.LabelCompPerc.GetTyper().XScale = 1;
	STAGE_0.LabelCompPerc.GetTyper().YScale = 1;
	STAGE_0.LabelCompPerc.GetTyper().ReGen();
	STAGE_0.Register(STAGE_0.LabelCompPerc);
};
STAGE_0.ExitIn = function () {

};
STAGE_0.ExitOut = function () {
	var STAGE_0 = Stages.Get(0);
	STAGE_0.Menu.Remove();
	STAGE_0.LabelHint.Remove();
	Stages._level = 1000;
};

STAGE_1.EntranceIn = function () {

}

Stages.Define(0,	STAGE_0);
Stages.Define(1000, STAGE_1);
Stages.Next();

