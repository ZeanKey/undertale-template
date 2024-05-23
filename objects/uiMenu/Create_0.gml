/// @desc Init
event_inherited();

_infoOffsetY = 0;

if (instance_exists(entityPlayer)) {
	_top = entityPlayer.y - camera.y > 130 + entityPlayer.sprite_height;
	entityPlayer.IsUICaptured = true;
	entityPlayer.Movenable.Set("UI", false);
}
else _top = false;

if (_top) then _infoOffsetY = -270;

var STAGE_0, STAGE_1_0, STAGE_1_1, STAGE_1_0_1, STAGE_1_0_2;
STAGE_0		= new Stage(self);
STAGE_1_0	= new Stage(self);
STAGE_1_0_1	= new Stage(self);
STAGE_1_0_2	= new Stage(self);
STAGE_1_1	= new Stage(self);

with (STAGE_0) {
	_choice = 0;
	EntranceIn = function () {
		_window_0 = _parent.Widget.Add.Window(32, 168, 142, 148);
		_window_1 = _parent.Widget.Add.Window(32, 322 + _parent._infoOffsetY, 142, 110);
		_label_0 = _parent.Widget.Add.Label(46, 331 + _parent._infoOffsetY, $"{WORLD_PLAYER.Name}");
		_label_1 = _parent.Widget.Add.Label(46, 364 + _parent._infoOffsetY, "LV", "UIWorld");
		_label_2 = _parent.Widget.Add.Label(46, 382 + _parent._infoOffsetY, "HP", "UIWorld");
		_label_3 = _parent.Widget.Add.Label(46, 400 + _parent._infoOffsetY, "G ", "UIWorld");
		_label_4 = _parent.Widget.Add.Label(82, 364 + _parent._infoOffsetY, $"{WORLD_PLAYER.Lv}", "UIWorld");
		_label_5 = _parent.Widget.Add.Label(82, 382 + _parent._infoOffsetY, $"{WORLD_PLAYER.HP.Value}/{WORLD_PLAYER.MaxHP}", "UIWorld");
		_label_6 = _parent.Widget.Add.Label(82, 400 + _parent._infoOffsetY, $"{WORLD_PLAYER.Gold}", "UIWorld");
		_menu_0 = 0;
		_menu_0 = _parent.Widget.Add.Menu([	[84, 189, _parent.GenerateText("ITEM", "RegularWorldUI", (WORLD_PLAYER.Storage.Size() > 0 ? "White" : "Gray")), WORLD_PLAYER.Storage.Size() > 0],
											[84, 225, _parent.GenerateText("STAT")]],
											function () {
												if (_menu_0.IsActivated) {
													_choice = _menu_0._choiceIndex;
													_parent.Stages.Next();
												}
											},
											function () {
												if (_menu_0.IsActivated) {
													_parent.Stages.Back();
												}
											},
											function () {
												if (_menu_0.IsActivated) {
													var CHOICE = _menu_0._origin[_menu_0._choiceIndex]
													draw_sprite_ext(sprUISoul, 0, CHOICE[0] - 28, CHOICE[1] + 7, 2, 2, 0, -1, 1);
												}
											});
		Register(_window_0);
		Register(_window_1);
		Register(_label_0);
		Register(_label_1);
		Register(_label_2);
		Register(_label_3);
		Register(_label_4);
		Register(_label_5);
		Register(_label_6);
		Register(_menu_0);
	};
	EntranceOut = function () {
		_window_0.Remove();
		_window_1.Remove();
		_label_0.Remove();
		_label_1.Remove();
		_label_2.Remove();
		_label_3.Remove();
		_menu_0.Remove();
		_parent.Stages._level = -1;
	};
	ExitIn = function () {
		_menu_0.Activate();
	};
	ExitOut = function () {
		_menu_0.Deactivate();
		_parent.Stages._level += 1000 + _choice * 100;
	};
};

with (STAGE_1_0) {
	EntranceIn = function () {
		_window_0 = _parent.Widget.Add.Window(188, 52, 346, 362);
		_menuChoices = [];
		for (var INDEX = 0; INDEX < WORLD_PLAYER.Storage.Size(); INDEX ++) {
			_menuChoices[INDEX] = [232, 81 + INDEX * 32, _parent.GenerateText(WORLD_PLAYER.Storage.Get(INDEX).Property.Name)];
		}
		_menu_0 = 0;
		_menu_0 = _parent.Widget.Add.Menu(_menuChoices,
											function () {
												if (_menu_0.IsActivated) {
													_parent.Stages.Get(1010)._choicePre = _menu_0._choiceIndex;
													_parent.Stages.Next();
												}
											},
											function () {
												if (_menu_0.IsActivated) {
													_parent.Stages.Back();
												}
											},
											function () {
												if (_menu_0.IsActivated) {
													var CHOICE = _menu_0._origin[_menu_0._choiceIndex]
													draw_sprite_ext(sprUISoul, 0, CHOICE[0] - 24, CHOICE[1] + 7, 2, 2, 0, -1, 1);
												}
											});
		_menuChoices = [	[232, 361, _parent.GenerateText("USE")],
							[328, 361, _parent.GenerateText("INFO")],
							[442, 361, _parent.GenerateText("DROP")]]; 
		_menu_1 = 0;
		_menu_1 = _parent.Widget.Add.Menu(_menuChoices,
											function () {
												if (_menu_1.IsActivated) {
													_parent.Stages.Get(1010)._choice = _menu_1._choiceIndex;
													_parent.Stages.Next();
												}
											},
											function () {
												if (_menu_1.IsActivated) {
													_parent.Stages.Back();
												}
											},
											function () {
												if (_menu_1.IsActivated) {
													var CHOICE = _menu_1._origin[_menu_1._choiceIndex]
													draw_sprite_ext(sprUISoul, 0, CHOICE[0] - 24, CHOICE[1] + 7, 2, 2, 0, -1, 1);
												}
											},
											function () {
												with (_menu_1) {
													if (IsActivated) {
														if (not _isCooling) {
															if (input_check_pressed(INPUT.LEFT)) {
																_choiceIndex --;
															}
															else if (input_check_pressed(INPUT.RIGHT)) {
																_choiceIndex ++;
															}
															_choiceIndex = clamp_loop(_choiceIndex, 0, array_length(_choices) - 1);
		
															if (input_check_pressed(INPUT.CONFIRM)) {
																if (_choices[_choiceIndex]._accessible) then Submit();
															}
															else if (input_check_pressed(INPUT.CANCEL)) {
																Cancel();
															}
														}
													}
													_choiceIndex = clamp_loop(_choiceIndex, 0, array_length(_choices) - 1);
												}
											});
		_menu_1.Deactivate();
		Register(_menu_0);
		Register(_menu_1);
		Register(_window_0);
		Register(_menu_0);
	};
	EntranceOut = function () {
		_window_0.Remove();
		_menu_0.Remove();
		_menu_1.Remove();
		_parent.Stages._level = 0;
	};
	ExitIn = function () {
		_menu_0.Activate();
		_menu_1.Deactivate();
	};
	ExitOut = function () {
		_menu_0.Deactivate();
		_menu_1.Activate();
		_parent.Stages._level = 1010;
	}
};

with (STAGE_1_0_1) {
	_choicePre = 0;
	_choice = 0;
	EntranceIn = function () {
		
	};
	EntranceOut = function () {
		_parent.Stages._level = 1000;
	};
	ExitOut = function () {
		_parent.Stages._level = 1020;
		with (_parent.Stages.Get(1000)) {
			_window_0.Remove();
			_menu_0.Remove();
			_menu_1.Remove();
		}
		
		switch (_choice) {
			case 0:
			WORLD_PLAYER.Storage.Get(_choicePre).Use(_choicePre);
			break;
			case 1:
			WORLD_PLAYER.Storage.Get(_choicePre).Info(_choicePre);
			break;
			case 2:
			WORLD_PLAYER.Storage.Get(_choicePre).Drop(_choicePre);
			break;
		}
		
		if (WORLD_PLAYER.Storage.Size() <= 0) {
			_parent.Stages.Get(0)._menu_0.Recolor(c_gray, 0);
		}
	};
};

with (STAGE_1_0_2) {
};

with (STAGE_1_1) {
	EntranceIn = function () {
		_window_0 = _parent.Widget.Add.Window(188, 52, 346, 418);
		_labels = [];
		_labels[0] = _parent.Widget.Add.Label(216, 85, $"\"{WORLD_PLAYER.Name}\"");
		_labels[1] = _parent.Widget.Add.Label(216, 145, "LV");
		_labels[2] = _parent.Widget.Add.Label(256, 145, $"{WORLD_PLAYER.Lv}");
		_labels[3] = _parent.Widget.Add.Label(216, 177, "HP");
		_labels[4] = _parent.Widget.Add.Label(256, 177, $"{WORLD_PLAYER.MaxHP} / {WORLD_PLAYER.HP.Value}");
		_labels[5] = _parent.Widget.Add.Label(216, 241, "AT");
		_labels[6] = _parent.Widget.Add.Label(256, 241, $"{WORLD_PLAYER.Atk} ({WORLD_PLAYER.Weapon.GetValue()})");
		_labels[7] = _parent.Widget.Add.Label(216, 273, "DF");
		_labels[8] = _parent.Widget.Add.Label(256, 273, $"{WORLD_PLAYER.Def} ({WORLD_PLAYER.Armor.GetValue()})");
		_labels[9] = _parent.Widget.Add.Label(384, 241, $"EXP: {WORLD_PLAYER.Exp}");
		_labels[10] = _parent.Widget.Add.Label(384, 273, "NEXT: ");
		_labels[11] = _parent.Widget.Add.Label(216, 334, $"WEAPON: {WORLD_PLAYER.Weapon.GetName()}");
		_labels[12] = _parent.Widget.Add.Label(216, 366, $"ARMOR: {WORLD_PLAYER.Armor.GetName()}");
		_labels[13] = _parent.Widget.Add.Label(216, 406, $"GOLD: {WORLD_PLAYER.Gold}");
		if (WORLD_OVERWORLD.UI.Kills.Enable) then _labels[14] = _parent.Widget.Add.Label(384, 406, $"KILLS: {WORLD_PLAYER.Kills}");
		_step_0 = 0;
		_step_0 = _parent.Widget.Add.Step(function () {
			if (input_check_pressed(INPUT.CANCEL)) {
				_parent.Stages.Back();
			}
		});
		Register(_window_0);
		for (var INDEX = 0; INDEX < array_length(_labels); INDEX ++) {
			Register(_labels[INDEX]);
		}
		Register(_step_0);
	};
	EntranceOut = function () {
		_window_0.Remove();
		for (var INDEX = 0; INDEX < array_length(_labels); INDEX ++) {
			_labels[INDEX].Remove();
		}
		_step_0.Remove();
		_parent.Stages._level = 0;
	};
};

Stages.Define(0, STAGE_0);
Stages.Define(1000, STAGE_1_0);
Stages.Define(1010, STAGE_1_0_1);
Stages.Define(1020, STAGE_1_0_2);
Stages.Define(1100, STAGE_1_1);

Stages.Next();
audio_play_sound(sndMenuSwitch, 0, false);