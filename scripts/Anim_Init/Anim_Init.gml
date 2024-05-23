function Anim_Init() { }

global.AnimHelper = { };

global.AnimHelper.TargetValueRecord = function (start, target) {
	return new AnimValueRecord(start, target - start);
};

enum ANIM_TWEEN{
	LINEAR,
	SINE,
	QUAD,
	CUBIC,
	QUART,
	QUINT,
	EXPO,
	CIRC,
	BACK,
	ELASTIC,
	BOUNCE,
	IN,
	OUT,
	IN_OUT
}

enum ANIM_EASE{
	IN,
	OUT,
	IN_OUT
}

function AnimValueRecord(start, change) constructor {
	Start	= start;
	Change	= change;
}


function AnimCurveFormat(tween = 0, ease = 0) constructor {
	Tween = tween;
	Ease  = ease;
	
	GenerateAnim = function (target, varName, valueRecord, time, delay) {
		return new AnimRecord(target, varName, Tween, Ease, valueRecord.Start, valueRecord.Change, time, delay)
	};
}

function AnimRecord(target, varName, tween, ease, start, change, time, delay) constructor {
	Target	= noone;
	VarName = varName;
	Tween	= tween;
	Ease	= ease;
	Start	= start;
	Change	= change;
	Delay	= delay;
	Time	= time;
	New = function (finFn = METHOD_DEFAULT) {
		var anim = Anim_New(Target, VarName, Tween, Ease, Start, Change, Time, Delay);
		if (instance_exists(anim)) {
			anim._finFn = fin_fn;
		}
		else if (is_array(anim)) {
			for (var i = 0; i < array_length(anim); i ++) {
				if (instance_exists(anim[i])) anim[i]._finFn = fin_fn;
			}
		}
		return anim;
	}
};
