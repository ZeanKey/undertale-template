Timer = {};

Timer.SetTimeOut = function (callback, delay) {
	var timer = instance_create_depth(0, 0, 0, _Timer, { _delay : delay });
	timer.Alarm.AddCallback(-1, callback);
}
