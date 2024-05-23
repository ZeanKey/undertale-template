/// @desc
var SIZE = _clockScaleNum;

self._drawClockScales([320, 240], _counter * 2, _clockScaleRad, [_rectSingle._width, _rectSingle._height], SIZE, c_white, 0.999);
self._drawClockScales([320, 240], _counter * 3, _clockScaleTinyRad, [_rectSingleTiny._width, _rectSingleTiny._height], SIZE, c_white, 0.9);

var RING_BLANK_S_WID_HALF = 10;
var RING_BLANK_L_WID_HALF = 30;
var ANG_S = _counter;

self._drawRing([320, 240], _blankRingSpinA._start, _blankRingSpinA._end,	[	[ANG_S - RING_BLANK_S_WID_HALF, ANG_S + RING_BLANK_S_WID_HALF],
											[ANG_S - RING_BLANK_S_WID_HALF + 180, ANG_S + RING_BLANK_S_WID_HALF + 180],
											[ANG_S + 90 - RING_BLANK_L_WID_HALF, ANG_S + 90 + RING_BLANK_L_WID_HALF],
											[ANG_S - 90 - RING_BLANK_L_WID_HALF, ANG_S - 90 + RING_BLANK_L_WID_HALF]], 0.999, c_white)
ANG_S *= 2

self._drawRing([320, 240], _blankRingSpinD._start, _blankRingSpinD._end,	[	[ANG_S - RING_BLANK_S_WID_HALF, ANG_S + RING_BLANK_S_WID_HALF],
											[ANG_S - RING_BLANK_S_WID_HALF + 180, ANG_S + RING_BLANK_S_WID_HALF + 180],
											[ANG_S + 90 - RING_BLANK_L_WID_HALF, ANG_S + 90 + RING_BLANK_L_WID_HALF],
											[ANG_S - 90 - RING_BLANK_L_WID_HALF, ANG_S - 90 + RING_BLANK_L_WID_HALF]], 0.9, c_white)

self._drawRing([320, 240], _blankRingSpinB._start, _blankRingSpinB._end,	[], 0.999, c_white)

ANG_S *= -1 / 2;

var RING_DELTA = sin(_counter / 60) * 30;
RING_BLANK_S_WID_HALF = 10 - RING_DELTA / 3;
RING_BLANK_L_WID_HALF = 30 + RING_DELTA;

self._drawRing([320, 240], _blankRingSpinC._start, _blankRingSpinC._end,	[	[ANG_S - RING_BLANK_S_WID_HALF, ANG_S + RING_BLANK_S_WID_HALF],
											[ANG_S - RING_BLANK_S_WID_HALF + 180, ANG_S + RING_BLANK_S_WID_HALF + 180],
											[ANG_S + 90 - RING_BLANK_L_WID_HALF, ANG_S + 90 + RING_BLANK_L_WID_HALF],
											[ANG_S - 90 - RING_BLANK_L_WID_HALF, ANG_S - 90 + RING_BLANK_L_WID_HALF]], 0.999, c_white)