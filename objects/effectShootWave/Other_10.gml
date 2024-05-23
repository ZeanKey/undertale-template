/// @desc Launch
_begin = true;

Anim_New(id, "_ringStart", ANIM_TWEEN.CUBIC, ANIM_EASE.OUT, 0, _ringIdeal, _time - 5, 5);
Anim_New(id, "_ringEnd", ANIM_TWEEN.CUBIC, ANIM_EASE.OUT, 0, _ringIdeal + 5, _time);