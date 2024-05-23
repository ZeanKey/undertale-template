///@desc Create Surface Point
var DELTA_XPOS;
DELTA_XPOS = _surfWidth / (_surfPointNum - 1);

var COUNT, CUR_X, CUR_POINT, CUR_Y, ORI_X, ORI_Y, PARENT;
ORI_X = _surfPosX - _surfWidth / 2;
ORI_Y = _surfPosY - _surfHeight;
PARENT = id;
for (COUNT = 0; COUNT < _surfPointNum; COUNT += 1)
{
    CUR_X = ORI_X + DELTA_XPOS * COUNT;
    CUR_Y = ORI_Y;
    CUR_POINT = instance_create(CUR_X, CUR_Y, bulletWaterSurfPoint);
	CUR_POINT._delXOri = ORI_X - _surfPosX;
    CUR_POINT._number = COUNT
    CUR_POINT._pSpread = _pSpread;
    CUR_POINT._pSpring = _pSpring;
    CUR_POINT._pMass = _pMass;
    CUR_POINT._pDumping = _pDumping;
    CUR_POINT._pC = - _pSpring / _pMass;
    CUR_POINT._parent = PARENT;

    ds_list_add(_surfPointLst, CUR_POINT);
}