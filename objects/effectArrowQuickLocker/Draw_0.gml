/// @desc
var X_OFFSET = lengthdir_x(_len, image_angle);
var Y_OFFSET = lengthdir_y(_len, image_angle);

draw_sprite_ext(sprEffectLocker, 0, x - X_OFFSET, y - Y_OFFSET, _scale, _scale, image_angle, -1, _alpha);
draw_sprite_ext(sprEffectLocker, 0, x + X_OFFSET, y + Y_OFFSET, _scale, _scale, image_angle, -1, _alpha);

