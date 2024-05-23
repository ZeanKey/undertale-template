///@desc Init
image_blend = c_white;
image_alpha = 1;
direction = 90;

_surfPointLst	= ds_list_create();
_surfPointNum	= 0;
_surfPosX		= 0; //The position of the middle-bottom point of the water box.
_surfPosY		= 0;
_surfHeight		= 0;
_surfWidth		= 0;

_pSpread	= 1;
_pSpring	= 1;
_pMass		= 1;
_pDumping	= 1;
