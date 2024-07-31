Bullet3DServer = {};

Bullet3DServer.DrawBone = function(bone_length, mat_transform) {
	var mat_bonehead = matrix_build(0, bone_length/2, 0, 0, 0, 0, 1, 1, 1);
	var mat_bonehead_flip = matrix_build(0, -bone_length/2, 0, 0, 0, 0, 1, -1, 1);
	var mat_bone = matrix_build(0, 0, 0, 0, 0, 0, 6, bone_length, 6);
	matrix_set(matrix_world, matrix_multiply(mat_bonehead, mat_transform));
	vertex_submit(global.boneModel, pr_trianglelist, sprite_get_texture(sprModelTex, 0));
	matrix_set(matrix_world, matrix_multiply(mat_bone, mat_transform));
	vertex_submit(global.cubeModel, pr_trianglelist, sprite_get_texture(sprModelTex, 0));
	matrix_set(matrix_world, matrix_multiply(mat_bonehead_flip, mat_transform));
	vertex_submit(global.boneModel, pr_trianglelist, sprite_get_texture(sprModelTex, 0));
	matrix_set(matrix_world, matrix_build_identity());
}