///@desc Trail
if _trail
{		
	var CUR_PART = instance_create_depth(
					x,
					y,
					depth,
					effectStarLeaves)
	CUR_PART.image_angle	= image_angle;
	CUR_PART.image_xscale	= image_xscale;
	CUR_PART.image_yscale	= image_yscale;
	CUR_PART.sprite_index	= sprite_index;
	CUR_PART._fadingSpd = 0.1;
}