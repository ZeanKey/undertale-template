///@desc
var COLOR = #f00056;
var BLANK_ANGLE = 25;

self._drawRing([320, 240], 62 * _ringRate, 70 * _ringRate, [[_counter, _counter + BLANK_ANGLE], [_counter + 180, _counter + 180 + BLANK_ANGLE]], _ringAlpha, COLOR);
self._drawRing([320, 240], 80 * _ringRate, 83 * _ringRate, [[_counter, _counter + BLANK_ANGLE]], _ringAlpha, COLOR);

self._drawRing([320, 240], 87 * _ringRate, 95 * _ringRate, [[-_counter, -_counter + BLANK_ANGLE]], _ringAlpha, COLOR);
self._drawRing([320, 240], 99 * _ringRate, 102 * _ringRate, [[-_counter, -_counter + BLANK_ANGLE]], _ringAlpha, COLOR);