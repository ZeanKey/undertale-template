/// @desc Init
enum TURN_SUBPHASE_TYPE {
	DIALOG,
	BATTLE
}

function TurnSubPhase(paraTurnInst, paraType) constructor {
	_turn = paraTurnInst;
	
	Events = {
		EvStart		: new Event(),
		EvUpdate	: new Event(),
		EvEnd		: new Event(),
	};
	
	Events.EvStart.AddCallback(Events.EvStart.Generator(), function () {
		_turn._timer = 0;
	});
	if (paraType == TURN_SUBPHASE_TYPE.BATTLE) {
		Events.EvStart.AddCallback(Events.EvStart.Generator(), function () {
			_turn.TimerSetState.Battle();
		});
	}
	else if (paraType == TURN_SUBPHASE_TYPE.DIALOG) {
		Events.EvStart.AddCallback(Events.EvStart.Generator(), function () {
			_turn.TimerSetState.Dialog();
		});
	}
	
	Events.EvEnd.AddCallback(Events.EvEnd.Generator(), function () {
		_turn.SubPhases._index ++;
		_turn.SubPhases.Current().Events.EvStart.Call();
	});
	
	AddTimePoint = function (paraMsd, paraTime) {
		var tmpContext = {Turn : _turn, Msd : paraMsd, Time : paraTime};
		Events.EvUpdate.AddCallback(Events.EvUpdate.Generator(), method(tmpContext, function () {
			if (Turn._timer == Time) {
				Msd(Time);
			}
		}));
	};
	AddTimeRange = function (paraMsd, paraStart, paraEnd = infinity, paraStep = 1) {
		var tmpContext = {Turn : _turn, Msd : paraMsd, TStart : paraStart, TEnd : paraEnd, Step : paraStep};
		Events.EvUpdate.AddCallback(Events.EvUpdate.Generator(), method(tmpContext, function () {
			if (Turn._timer >= TStart) and (Turn._timer < TEnd) and ((Turn._timer - TStart) mod paraStep == 0) {
				Msd(Time);
			}
		}));
	};
}

// The value -1 refers the enemy main phase hasn't begun
_timer = -1;

SubPhases = {
	_content : [],
	_index : 0,
	Add : function (paraPhase) {
		array_push(_content, paraPhase);
	},
	Launch : function () {
		Current().Events.EvStart.Call();
	},
	Next : function () {
		Current().Events.EvEnd.Call();
	},
	Current : function () {
		return _content[_index];
	},
};

IsTimerOn	= true;

TimerSetState = {
	_turn : other,
	Dialog : function () {
		_timer = -1;
		_turn.IsTimerOn = false;
	},
	Battle : function () {
		_turn.IsTimerOn = true;
	}
};

Start = function () {
	SubPhases.Current().Events.EvStart.Call();
};
Update = function () {
	if (IsTimerOn) then _timer ++;
	SubPhases.Current().Events.EvUpdate.Call();
};
End = function () {
	if (battle.GetTurnClass() == TURN_CLASS.ENEMY) {
		battle.TurnPhase = TURN_PHASE.ENEMY_END;
	}
};