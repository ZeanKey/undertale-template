// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function turnCreateWater(paraX, paraY, paraW, paraH, paraNum, paraSpread = 0.2, paraSpring = 0.8, paraMass = 1.0, paraDump = 0.1)
{
	var INST_WATER;
	INST_WATER = instance_create(0, 0, bulletWater);
	INST_WATER._surfPointNum = paraNum;
	INST_WATER._surfPosX = paraX;
	INST_WATER._surfPosY = paraY;
	INST_WATER._surfHeight = paraH;
	INST_WATER._surfWidth = paraW;

	INST_WATER._pSpread = paraSpread;
	INST_WATER._pSpring = paraSpring;
	INST_WATER._pMass = paraMass;
	INST_WATER._pDumping = paraDump;

	with (INST_WATER)
	{
	    event_user(0);
	}
	
	return INST_WATER;
}

function waterHit(paraId, paraValue, paraSign)
{
	with paraId
	{
		_collisionSign	= paraSign;
		_collisionValue = paraValue;
		event_user(3);
	}
}