// Inherit the parent event
event_inherited();

SoulMode = SOUL_MODE.THREE_D;
ZIndex = 0;

GetInput3D = function () {
	var VEC_INPUT = [0, 0, 0];
	if (keyboard_check(vk_up)) {
		VEC_INPUT[1] += -1;
	}
	if (keyboard_check(vk_down)) {
		VEC_INPUT[1] += 1;
	}
	if (keyboard_check(vk_left)) {
		VEC_INPUT[0] += -1;
	}
	if (keyboard_check(vk_right)) {
		VEC_INPUT[0] += 1;
	}
	if (keyboard_check(vk_enter)) {
		VEC_INPUT[2] += 1;
	}
	if (keyboard_check(vk_shift)) {
		VEC_INPUT[2] -= 1;
	}
	return VEC_INPUT;
};


DrawSelf = function (matWorld) {
	var pos = matrix_transform_vertex(matWorld, x, y, ZIndex);
	matrix_set(matrix_world, matrix_build_identity());
	draw_sprite_ext(sprite_index, image_index, pos[0], pos[1], 0.5, 0.5, 0, -1, 1);
	matrix_set(matrix_world, matWorld);
};