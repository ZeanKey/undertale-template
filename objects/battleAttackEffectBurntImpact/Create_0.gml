/// @desc Init
event_inherited();

_rate = 1;

image_speed = 0.5 / _rate;
image_xscale = 2;
image_yscale = 2;

alarm[0] = 6 * _rate + 10;
alarm[1] = 12 * _rate + 10;

Anim_Target(id, "image_angle", 45, 12 * _rate + 10, 0 ,0);
Anim_Target(id, "image_alpha", 0, 12 * _rate, 0, 0, 10);
Anim_Target(id, "image_xscale", 0, 12 * _rate, 0, 0, 10);
Anim_Target(id, "image_yscale", 0, 12 * _rate, 0, 0, 10);





