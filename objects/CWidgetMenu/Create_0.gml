/// @desc
event_inherited();

depth = DEPTH_UI.PANEL - 100;

IsActivated = false;

_isCooling		= false;

_isInitialized	= false;
_origin			= [];
_choices		= [];
_choiceIndex	= 0;

_rpX = 0;
_rpY = 0;
_rpDeltaX = 0;
_rpDeltaY = 0;

Cooldown = function (paraTime = 1) {
	_isCooling = true;
	alarm[0] = paraTime;
};

Activate = function () {
	IsActivated = true;
	Cooldown();
};

Deactivate = function () {
	IsActivated = false;
	Cooldown();
};

Reposition = function () {
	for (var INDEX = 0; INDEX < array_length(_choices); INDEX ++) {
		_choices[INDEX].x = _rpX + INDEX * _rpDeltaX;
		_choices[INDEX].y = _rpY + INDEX * _rpDeltaY;
		_choices[INDEX].Refresh();
	}
};

IsAccessible = function (paraIndex = -1) {
	return _choices[(paraIndex == -1) ? _choiceIndex : paraIndex]._accessible
};

GenerateChoice = function (paraName, paraX, paraY, paraAcc = true) {
	var CUR_TYPER = instance_create_depth(paraX, paraY, depth, typer);
	CUR_TYPER._text = paraName;
	CUR_TYPER._accessible = paraAcc;
	with (CUR_TYPER) {
		event_user(0);
		Instantize();
	}
	return CUR_TYPER;
};

GetChosen = function () {
	return _choices[_choiceIndex];
};

GetChosenName = function () {
	return GetChosen().GetProcessedText();
}

GetChosenIndex = function () {
	return _choiceIndex;
}

GetReposX = function (paraIndex) {
	return (_rpX + (paraIndex * _rpDeltaX));
};

GetReposY = function (paraIndex) {
	return (_rpY + (paraIndex * _rpDeltaY));
};

AddChoice = function (paraName, paraPos = -1, paraAcc = true) {
	var POS = paraPos;
	if (POS == -1) {
		array_push(_choices, GenerateChoice(paraName, GetReposX(array_length(_choices)), GetReposY(array_length(_choices)), paraAcc));
	}
	else {
		array_insert(_choices, paraPos, GenerateChoice(paraName, GetReposX(array_length(POS)), GetReposY(array_length(POS)), paraAcc));
	}
	Reposition();
};

RemoveChoice = function (paraPos = -1) {
	var POS = paraPos;
	if (POS == -1) then POS = array_length(_choices) - 1;
	instance_destroy(_choices[paraPos]);
	array_delete(_choices, paraPos, 1);
	Reposition();
};

Update = function () {
	if (IsActivated) {
		if (not _isCooling) {
			if (input_check_pressed(INPUT.UP)) {
				_choiceIndex --;
			}
			else if (input_check_pressed(INPUT.DOWN)) {
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
};

Submit = function () {
	
};

Cancel = function () {
	
};

Render = function () {
	
};

Recolor = function (paraColor, paraIndex = -1) {
	if (paraIndex == -1) {
		for (var INDEX = 0; INDEX < array_length(_choices); INDEX ++) {
			with (_choices[INDEX]) {
				Cache.Write("WMColor", paraColor)
				Foreach(function (paraChr) {
					paraChr.Color = Cache.Read("WMColor");
				});
			}
		}
	}
	else {
		if (paraIndex < array_length(_choices)) {
			with (_choices[paraIndex]) {
				Cache.Write("WMColor", paraColor)
				Foreach(function (paraChr) {
					paraChr.Color = Cache.Read("WMColor");
				});
			}
		}
	}
}

Foreach = function (paraCallback) {
	for (var INDEX = 0; INDEX < array_length(_choices); INDEX ++) {
		paraCallback(_choices[INDEX], INDEX);
	}
};

Init = function (paraArray, paraMethodSubmit, paraMethodCancel, paraMethodRender, paraMethodUpdate = -1, paraRepos = false) {
	if (paraRepos != false) {
		if (is_array(paraRepos)) {
			_rpX = paraRepos[0];
			_rpY = paraRepos[1];
			_rpDeltaX = paraRepos[2];
			_rpDeltaY = paraRepos[3];
		}
		else {
			if (array_length(paraArray) >= 2) {
				_rpX = paraArray[0][0];
				_rpY = paraArray[0][1];
				_rpDeltaX = paraArray[1][0] - paraArray[0][0];
				_rpDeltaY = paraArray[1][1] - paraArray[0][1];
			}
		}
	}
	var CUR_CHOICE, CUR_TYPER;
	for (var INDEX = 0; INDEX < array_length(paraArray); INDEX ++) {
		CUR_CHOICE = paraArray[INDEX];
		CUR_TYPER = instance_create_depth(CUR_CHOICE[0], CUR_CHOICE[1], depth, typer);
		CUR_TYPER._text = CUR_CHOICE[2];
		if (array_length(CUR_CHOICE) == 4) {
			CUR_TYPER._accessible = CUR_CHOICE[3];
		}
		else {
			CUR_TYPER._accessible = true;
		}
		with (CUR_TYPER) {
			event_user(0);
			Instantize();
		}
		array_push(_choices, CUR_TYPER);
	}
	if (paraMethodUpdate != -1) {
		Update = paraMethodUpdate;
	}
	Render = paraMethodRender;
	Submit = paraMethodSubmit;
	Cancel = paraMethodCancel;
	_origin = paraArray;
	_isInitialized = true;
	Activate();
};

Remove = function () {
	instance_destroy();
};




