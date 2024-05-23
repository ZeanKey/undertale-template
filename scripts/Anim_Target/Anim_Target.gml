function Anim_Target(target, var_name, val_target, time, tween = ANIM_TWEEN.LINEAR, ease = ANIM_EASE.IN, paraDelay = 0)
{
	var VAL_STA = variable_instance_get(target, var_name);
	var VAL_CHA = val_target - VAL_STA;
	return Anim_New(target, var_name, tween, ease, VAL_STA, VAL_CHA, time, paraDelay);
}

function AnimTarget(target, var_name, val_target, time, tween = ANIM_TWEEN.LINEAR, ease = ANIM_EASE.IN, delay = 0, fin_fn = METHOD_DEFAULT) {
	var start = variable_instance_get(target, var_name);
	var change = val_target - start;
	var anim = Anim_New(target, var_name, tween, ease, start, change, time, delay);
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