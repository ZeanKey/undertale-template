_blinkingTimer ++;
if (_blinkingTimer >= BlinkingPeriod) {
	_blinkingTimer = 0;
	_blinkingIndex ++;
	_blinkingIndex = _blinkingIndex mod array_length(BlinkingColors);
}

image_blend = BlinkingColors[_blinkingIndex];


