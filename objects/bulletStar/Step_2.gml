///@desc Trail
if _trail
{		
	var CUR_PART = instance_create_depth(
					x,
					y,
					depth,
					effectSpotLeaves)
	CUR_PART.image_angle	= direction;
	CUR_PART._counter		= 4;
	CUR_PART._dyingSpd		= 0.2;
}