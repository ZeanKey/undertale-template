/// @desc Init
event_inherited();

_rawLetters = ""
_rawLetters += "{effect 0}{x 120}{y 152}{space_x 64}{space_y 28}"
_rawLetters += "[A][B][C][D][E][F][G]\n";
_rawLetters += "[H][I][J][K][L][M][N]\n";
_rawLetters += "[O][P][Q][R][S][T][U]\n"
_rawLetters += "[V][W][X][Y][Z]"
_rawLetters += "{space_y 20}\n\n{space_y 28}"
_rawLetters += "[a][b][c][d][e][f][g]\n"
_rawLetters += "[h][i][j][k][l][m][n]\n"
_rawLetters += "[o][p][q][r][s][t][u]\n"
_rawLetters += "[v][w][x][y][z]\n";
_rawLetters += "{x 120}{y 400}[Quit]{x 240}[Backspace]{x 440}[Done]";

_GenKeyboard = function (paraStage) {
	var MENU = global.UIHelper.Menu;
	MENU.Gen.Start(paraStage);
	MENU.Gen.AddEncodedString(_rawLetters);
	MENU.Gen.Inherit(UI_CALLBACK_UPDATE, method(paraStage, function () {
		if (instance_exists(Menu)) {
			Menu.Recolor(c_white, -1);
			Menu.Recolor(c_yellow, Menu.GetChosenIndex());
			if (input_check_pressed(INPUT.CONFIRM)) {
				var tmpNameGet = Menu.GetChosenName();
				switch (tmpNameGet) {
					case "Quit":
					break;
					case "Backspace":
					if (string_length(LabelName.GetProcessedText()) != 0) {
						LabelName.Text = string_copy(LabelName.Text, 1, string_length(LabelName.Text) - 1);
					}
					break;
					case "Done":
					if (string_length(LabelName.GetProcessedText()) != 0) {
						if (Menu.IsAccessible()) then Menu.Submit();
					}
					break;
					default:
					LabelName.Text += Menu.GetChosenName();
					break;
				}
				exit;
			}
			else if (input_check_pressed(INPUT.CANCEL)) {
				if (string_length(LabelName.GetProcessedText()) != 0) {
					LabelName.Text = string_copy(LabelName.Text, 1, string_length(LabelName.Text) - 1);
				}
				exit;
			}
		}
	}));
	MENU.Gen.Rebind(UI_MENU_KEYBIND_CONFIRM, INPUT.NULL);
	MENU.Gen.Rebind(UI_MENU_KEYBIND_CANCEL, INPUT.NULL);
	paraStage.Menu = MENU.Gen.End();
	paraStage.Menu.Foreach(function (curTyper) {
		if (string_length(curTyper.GetProcessedText()) == 1) {
			global.TyperHelper.Typer.Foreach(curTyper, function (paraChr) {
				paraChr.Events.CharPreRender.AddCallback(function (paraChr) {
					with (paraChr.RenderInfo) {
						Pos.X += random_range(1, -1);
						Pos.Y += random_range(1, -1);
					}
				});
			});
		}
	});
};

var STAGE_0, STAGE_1, STAGE_2;
STAGE_0	= new Stage(self);
STAGE_1	= new Stage(self);
STAGE_2	= new Stage(self);

STAGE_0.Result = 0;
STAGE_0.EntranceIn = function () {
	var STAGE_0 = Stages.Get(0);
	STAGE_0.LabelHint = Widget.Add.Label(180, 60, $"Name the fallen human.");
	STAGE_0.LabelName = Widget.Add.Label(320, 105, $"");
	STAGE_0.LabelName._typer.Halign = 1;
	STAGE_0.LabelName._typer.Valign = 1;
	STAGE_0.Register(STAGE_0.LabelHint);
	
	_GenKeyboard(STAGE_0);
};
STAGE_0.ExitIn = function () {
	var STAGE_0 = Stages.Get(0);
	STAGE_0.LabelHint = Widget.Add.Label(180, 60, $"Name the fallen human.");
	STAGE_0.Register(STAGE_0.LabelHint);
	with (STAGE_0.LabelName.GetTyper()) {
		XScale = 1;
		YScale = 1;
		y = 105;
		ReGen();
	}
	
	_GenKeyboard(STAGE_0);;
};
STAGE_0.ExitOut = function () {
	var STAGE_0 = Stages.Get(0);
	STAGE_0.Menu.Remove();
	STAGE_0.LabelHint.Remove();
	Stages._level = 1000;
};

STAGE_1.EntranceIn = function () {
	var STAGE_0 = Stages.Get(0);
	var STAGE_1 = Stages.Get(1000);
	
	STAGE_1.LabelName = STAGE_0.LabelName;
	global.TyperHelper.Effect.Affect(STAGE_1.LabelName.GetTyper(), function (paraInfo) {
		paraInfo.Pos.X += random_range(-1, 1);
		paraInfo.Pos.Y += random_range(-1, 1);
	}, "__tempEffectShake");
	
	STAGE_1.LabelHint = Widget.Add.Label(320, 60, $"Is this name correct?");
	STAGE_1.LabelHint.GetTyper().SetHalign(1);
	STAGE_1.Register(STAGE_1.LabelHint);
	
	STAGE_1.Step = Widget.Add.Step(method(STAGE_1, function () {
		with (LabelName.GetTyper()) {
			if (XScale < 8) {
				XScale += 1 / 120;
				YScale += 1 / 120;
				y += 1 / 4;
				ReGen();
			}
		}
	}));
	
	var MENU = global.UIHelper.Menu;
	MENU.Gen.Start(STAGE_1);
	MENU.Gen.AddEncodedString("{x 145}{y 400}[No]{x 460}[Yes]");
	MENU.Gen.Inherit(UI_CALLBACK_UPDATE, method(STAGE_1, function () {
		if (instance_exists(Menu)) {
			Menu.Recolor(c_white, -1);
			Menu.Recolor(c_yellow, Menu.GetChosenIndex());
			if (input_check_pressed(INPUT.CONFIRM)) {
				var tmpNameGet = Menu.GetChosenName();
				switch (tmpNameGet) {
					case "No":
					if (Menu.IsAccessible()) then Menu.Cancel();
					break;
					case "Yes":
					if (Menu.IsAccessible()) then Menu.Submit();
					break;
				}
				exit;
			}
			else if (input_check_pressed(INPUT.CANCEL)) {
				Menu.Cancel();
				exit;
			}
		}
	}));
	MENU.Gen.Rebind(UI_MENU_KEYBIND_CONFIRM, INPUT.NULL);
	MENU.Gen.Rebind(UI_MENU_KEYBIND_CANCEL, INPUT.NULL);
	STAGE_1.Menu = MENU.Gen.End();
};
STAGE_1.EntranceOut = function () {
	var STAGE_1 = Stages.Get(1000);
	STAGE_1.Menu.Remove();
	STAGE_1.LabelHint.Remove();
	STAGE_1.Step.Remove();
	global.TyperHelper.Effect.Remove(STAGE_1.LabelName.GetTyper(), "__tempEffectShake");
	Stages._level = 0;
};
STAGE_1.ExitOut = function () {
	var STAGE_1 = Stages.Get(1000);
	STAGE_1.Menu.Remove();
	STAGE_1.LabelHint.Remove();
	Stages._level = 2000;
};

Stages.Define(0,	STAGE_0);
Stages.Define(1000, STAGE_1);
Stages.Define(2000, STAGE_2);
Stages.Next();

