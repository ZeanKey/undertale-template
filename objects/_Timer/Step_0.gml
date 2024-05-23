/// @desc
_counter ++;
if (Delay <= _counter) {
	Alarm.Call();
	instance_destroy()
}