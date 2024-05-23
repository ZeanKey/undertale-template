/// @desc Init
event_inherited();

_stationName = "";

Generate = function (paraName) {
	_stationName = paraName;
	Stages.Next();
}

var STAGE_0, STAGE_1;
STAGE_0		= new Stage(self);
STAGE_1		= new Stage(self);

with (STAGE_0) {
	_choice = 0;
	EntranceIn = function () {
		_window_0 = _parent.Widget.Add.Window(108, 118, 424, 174);
		_label_0 = _parent.Widget.Add.Label(140, 141, $"{WORLD_PLAYER.Name}");
		_label_1 = _parent.Widget.Add.Label(300, 141, $"LV {WORLD_PLAYER.Lv}");
		_label_2 = _parent.Widget.Add.Label(438, 141, $"{global.TimeAdapter.GetUTMinutes(world.GameTiming)}:{global.TimeAdapter.GetUTSeconds(world.GameTiming)}");
		_label_3 = _parent.Widget.Add.Label(140, 181, _parent._stationName);
		
		_menu_0 = 0;
		_menu_0 = _parent.Widget.Add.Menu([	[170, 241, _parent.GenerateText("Save")],
											[350, 241, _parent.GenerateText("Return")]],
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
											},
											function () {
												with (_menu_0) {
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
		Register(_window_0);
		Register(_label_0);
		Register(_label_1);
		Register(_label_2);
		Register(_label_3);
		Register(_menu_0);
	};
	ExitOut = function () {
		_menu_0.Remove();
		if (_choice == 1) {
			instance_destroy(_parent);
		}
		_parent.Stages._level = 1000;
	};
};

with (STAGE_1) {
	EntranceIn = function () {
		save.Save();
		with (_parent.Stages.Get(0)) {
			_label_0.Recolor(c_yellow);
			_label_1.Recolor(c_yellow);
			_label_2.Remove();
			_label_2 = _parent.Widget.Add.Label(438, 141,
				$"{global.TimeAdapter.GetUTMinutes(world.GameTiming)}:{global.TimeAdapter.GetUTSeconds(world.GameTiming)}",
				"RegularWorldUI", "Yellow");
			_label_3.Recolor(c_yellow);
			Register(_label_2);
		}
		_label_0 = _parent.Widget.Add.Label(170, 241, "File saved.", "RegularWorldUI", "Yellow");
		_step_0 = 0;
		_step_0 = _parent.Widget.Add.Step(function () {
			if (input_check_pressed(INPUT.CONFIRM)) {
				instance_destroy(_parent);
			}
		});
		Register(_step_0);
		Register(_label_0);
	};
};

Stages.Define(0, STAGE_0);
Stages.Define(1000, STAGE_1);

