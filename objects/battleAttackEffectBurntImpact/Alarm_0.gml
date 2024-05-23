/// @desc 
var CUR_DIR;
var CUR_STAR;
for (var INDEX = 0; INDEX < 8; INDEX ++) {
	CUR_DIR = 360 / 8 * INDEX;
	CUR_STAR = instance_create_depth(	x + lengthdir_x(45, CUR_DIR),
										y + lengthdir_y(45, CUR_DIR), depth, battleAttackEffectBurntStar);
	with (CUR_STAR) {
		direction	= CUR_DIR;
		image_angle = CUR_DIR + 90;
		speed		= 2;
		Anim_Target(id, "speed", 0, 60, 0, 0);
	}
	
	CUR_STAR.image_blend = image_blend;
}

CallEnemy();

