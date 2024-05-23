/// @desc Init
depth		= DEPTH.UI;
image_index = 0;
image_speed = 0;

_phase = 0;
_choice = noone;

Pressenable = true;

IsChosen = function () {
	if (battle.GetTurnClass() == TURN_CLASS.PLAYER) {
		if (battle.Buttons.Current() == noone) then return false;
		if (battle.Buttons.Current().id == self.id) then return true;
	}
	
	return false;
};

Confirm = function () {
	if (battle.TurnPhase == TURN_PHASE.PLAYER_MAIN) {
		event_user(BUTTON_EVENT.MAIN_CONFIRM);
	}
	else {
		event_user(BUTTON_EVENT.CONFIRM);
	}
};

Cancel = function () {
	event_user(BUTTON_EVENT.CANCEL);
};

Reset = function () {
	_phase = 0;
	_choice = noone;
};

CreateMultiChoices = function () {
	var CHOICES = instance_create_depth(0, 0, DEPTH.UI_HIGH, battleButtonSelector);
	return CHOICES;
};