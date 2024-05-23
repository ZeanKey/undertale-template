/// @desc
_counter ++;

if (_counter >= _timeFin) {
	FinFn();
	instance_destroy();
}
