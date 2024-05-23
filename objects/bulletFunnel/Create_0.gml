/// @desc
depth = DEPTH.BULLET_OUTSIDE_LOW;
image_alpha = 1;
image_xscale = 2;
image_yscale = 2;

//Phase 0: Chase
//Phase 1: StandBy
//Phase 2: Shoot
_isFire = false;

_isTrack = false;
_targetX = 320;
_targetY = 240;
_trackRate = 7;

_counter		= 0;
_counterSpd		= pi / 20;

_laserWidth		= 2;
_laserWidthOri	= 2;
_laserRate		= 1;

_motionAccel = 0;
_motionSpeed = 0;
_motionFrcit = 0.9;

