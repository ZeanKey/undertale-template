/// @desc Init
event_inherited();

if (instance_exists(entityPlayer)) {
	entityPlayer.IsUICaptured = true;
	entityPlayer.Movenable.Set("UI", false);
}

if (not variable_instance_exists(id, "_boxLinked")) {
	_boxLinked = WORLD_OVERWORLD.Boxes.Find(0);
}

var STAGE_0;
STAGE_0	= new Stage(self);

with (STAGE_0) {
	_choice = 0;
	EntranceIn = function () {
		var INV_STRG = [];
		for (var INDEX = 0; INDEX < WORLD_PLAYER.Storage.Size(); INDEX ++) {
			array_push(INV_STRG, [68, 73 + 32 * INDEX, _parent.GenerateText(WORLD_PLAYER.Storage.Get(INDEX).Property.Name)]);
		}
		var INV_BOX = [];
		for (var INDEX = 0; INDEX < _parent._boxLinked.Size(); INDEX ++) {
			array_push(INV_BOX, [370, 73 + 32 * INDEX, _parent.GenerateText(_parent._boxLinked.Get(INDEX).Property.Name)]);
		}
		
		_window_0 = _parent.Widget.Add.Window(16, 16, 610, 450);
		_label_0 = _parent.Widget.Add.Label(104, 31, "INVENTORY");
		_label_1 = _parent.Widget.Add.Label(448, 31, "BOX");
		_label_2 = _parent.Widget.Add.Label(200, 407, "Press [X] to Finish");
		_step_0 = 0;
		_step_0 = _parent.Widget.Add.Step(-1, function () {
			draw_sprite_ext(sprPixel, 0, 320, 92, 1, 300, 0, c_white, 1);
			draw_sprite_ext(sprPixel, 0, 322, 92, 1, 300, 0, c_white, 1);
		});
		_step_0.depth = DEPTH_UI.PANEL - 50;
		_menu_0 = 0;
		#region Player Storage
		_menu_0 = _parent.Widget.Add.Menu(INV_STRG,
											// Confirm
											function () {
												if (_menu_0.IsActivated) {
													if (_menu_0._choiceIndex < WORLD_PLAYER.Storage.Size()) && (_parent._boxLinked.Size() < _parent._boxLinked.Limit) {
														_parent._boxLinked.AddRaw(WORLD_PLAYER.Storage.Get(_menu_0._choiceIndex))
														_menu_1.AddChoice(_parent.GenerateText(WORLD_PLAYER.Storage.Get(_menu_0._choiceIndex).Property.Name));
														WORLD_PLAYER.Storage.Remove(_menu_0._choiceIndex);
														_menu_0.RemoveChoice(_menu_0._choiceIndex);
													}
												}
											},
											// Cancel
											function () {
												if (_menu_0.IsActivated) {
													instance_destroy(_parent);
												}
											},
											// Render
											function () {
												for (var INDEX = 0; INDEX < WORLD_PLAYER.Storage.Limit; INDEX ++) {
													if (INDEX >= array_length(_menu_0._choices)) {
														draw_sprite_ext(sprPixel, 0, _menu_0.GetReposX(INDEX) + 10, _menu_0.GetReposY(INDEX) + 19, 180, 1, 0, c_red, 1);
													}
												}
												if (_menu_0.IsActivated) {
													draw_sprite_ext(sprUISoul, 0, _menu_0.GetReposX(_menu_0._choiceIndex) - 28, _menu_0.GetReposY(_menu_0._choiceIndex) + 7, 2, 2, 0, -1, 1);
												}
											},
											//Update
											function () {
												with (_menu_0) {
													if (IsActivated) {
														if (not _isCooling) {
															if (input_check_pressed(INPUT.UP)) {
																_choiceIndex --;
															}
															else if (input_check_pressed(INPUT.DOWN)) {
																_choiceIndex ++;
															}
															_choiceIndex = clamp_loop(_choiceIndex, 0, WORLD_PLAYER.Storage.Limit - 1);
		
															if (input_check_pressed(INPUT.CONFIRM)) {
																if (_choiceIndex < array_length(_choices)) {
																	if (_choices[_choiceIndex]._accessible) {
																		Submit();
																		exit;
																	}
																}
															}
															else if (input_check_pressed(INPUT.CANCEL)) {
																Cancel();
																exit;
															}
															
															if (input_check_pressed(INPUT.RIGHT)) {
																IsActivated = false;
																other._menu_1.IsActivated = true;
															}
														}
													}
													_choiceIndex = clamp_loop(_choiceIndex, 0, WORLD_PLAYER.Storage.Limit - 1);
												}
											},
											[68, 73, 0, 32]);
		#endregion
		_menu_1 = 0;
		#region Player Storage
		_menu_1 = _parent.Widget.Add.Menu(INV_BOX,
											// Confirm
											function () {
												if (_menu_1.IsActivated) {
													if (_menu_1._choiceIndex < _parent._boxLinked.Size()) && (WORLD_PLAYER.Storage.Size() < WORLD_PLAYER.Storage.Limit) {
														WORLD_PLAYER.Storage.AddRaw(_parent._boxLinked.Get(_menu_1._choiceIndex))
														_menu_0.AddChoice(_parent.GenerateText(_parent._boxLinked.Get(_menu_1._choiceIndex).Property.Name));
														_parent._boxLinked.Remove(_menu_1._choiceIndex);
														_menu_1.RemoveChoice(_menu_1._choiceIndex);
													}
												}
											},
											// Cancel
											function () {
												if (_menu_1.IsActivated) {
													instance_destroy(_parent);
												}
											},
											// Render
											function () {
												for (var INDEX = 0; INDEX < _parent._boxLinked.Limit; INDEX ++) {
													if (INDEX >= array_length(_menu_1._choices)) {
														draw_sprite_ext(sprPixel, 0, _menu_1.GetReposX(INDEX) + 10, _menu_1.GetReposY(INDEX) + 19, 180, 1, 0, c_red, 1);
													}
												}
												if (_menu_1.IsActivated) {
													draw_sprite_ext(sprUISoul, 0, _menu_1.GetReposX(_menu_1._choiceIndex) - 28, _menu_1.GetReposY(_menu_1._choiceIndex) + 7, 2, 2, 0, -1, 1);
												}
											},
											//Update
											function () {
												with (_menu_1) {
													if (IsActivated) {
														if (not _isCooling) {
															if (input_check_pressed(INPUT.UP)) {
																_choiceIndex --;
															}
															else if (input_check_pressed(INPUT.DOWN)) {
																_choiceIndex ++;
															}
															_choiceIndex = clamp_loop(_choiceIndex, 0, _parent._boxLinked.Limit - 1);
		
															if (input_check_pressed(INPUT.CONFIRM)) {
																if (_choiceIndex < array_length(_choices)) {
																	if (_choices[_choiceIndex]._accessible) {
																		Submit();
																		exit;
																	}
																}
															}
															else if (input_check_pressed(INPUT.CANCEL)) {
																Cancel();
																exit;
															}
															
															if (input_check_pressed(INPUT.LEFT)) {
																IsActivated = false;
																other._menu_0.IsActivated = true;
															}
														}
													}
													_choiceIndex = clamp_loop(_choiceIndex, 0, _parent._boxLinked.Limit - 1);
												}
											},
											[370, 73, 0, 32]);
		_menu_1._parent = _parent;
		_menu_1.IsActivated = false;
		#endregion
		
		Register(_window_0);
		Register(_label_0);
		Register(_label_1);
		Register(_label_2);
		Register(_step_0);
		Register(_menu_0);
		Register(_menu_1);
	};
};

Stages.Define(0, STAGE_0);
Stages.Next();
audio_play_sound(sndMenuSwitch, 0, false);