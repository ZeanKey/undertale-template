/// @desc Define Animation
var ANIM_WALK = [];
ANIM_WALK[0] = new EntityAnimation("WalkLeft", sprEntFriskLeft, 16, seqplay_loop);
ANIM_WALK[1] = new EntityAnimation("WalkRight", sprEntFriskRight, 16, seqplay_loop);
ANIM_WALK[2] = new EntityAnimation("WalkUp", sprEntFriskUp, 16, seqplay_loop);
ANIM_WALK[3] = new EntityAnimation("WalkDown", sprEntFriskDown, 16, seqplay_loop);

for (var INDEX = 0; INDEX < 4; INDEX ++) {
	ANIM_WALK[INDEX].SetDefaultFrame(new EntityFrame(0, new Vector2D(1, 1), new Vector2D(0, 0), 0));
	ANIM_WALK[INDEX].AddFrame(9, new EntityFrame(0, new Vector2D(1, 1), new Vector2D(0, 0), 0));
	ANIM_WALK[INDEX].AddFrame(1, new EntityFrame(1, new Vector2D(1, 1), new Vector2D(0, 0), 0));
	Animations.AddAnim(ANIM_WALK[INDEX]);
}

var ANIM_IDLE = [];

ANIM_IDLE[0] = new EntityAnimation("IdleLeft", sprEntFriskLeft, 1, seqplay_loop);
ANIM_IDLE[1] = new EntityAnimation("IdleRight", sprEntFriskRight, 1, seqplay_loop);
ANIM_IDLE[2] = new EntityAnimation("IdleUp", sprEntFriskUp, 1, seqplay_loop);
ANIM_IDLE[3] = new EntityAnimation("IdleDown", sprEntFriskDown, 1, seqplay_loop);

for (var INDEX = 0; INDEX < 4; INDEX ++) {
	ANIM_IDLE[INDEX].AddFrame(0, new EntityFrame(0, new Vector2D(1, 1), new Vector2D(0, 0), 0));
	Animations.AddAnim(ANIM_IDLE[INDEX]);
}


