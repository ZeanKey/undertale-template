///@desc Refresh Position
var DELTA_XPOS;
DELTA_XPOS = _surfWidth / (_surfPointNum - 1);

var COUNT, CUR_X, CUR_POINT, CUR_Y, ORI_X, ORI_Y;
ORI_X = _surfPosX - _surfWidth / 2;
ORI_Y = _surfPosY - _surfHeight;
for (COUNT = 0; COUNT < _surfPointNum; COUNT += 1)
{
    CUR_X = ORI_X + DELTA_XPOS * COUNT;
    CUR_Y = ORI_Y;
    CUR_POINT = ds_list_find_value(_surfPointLst, COUNT);
    with (CUR_POINT)
    {
        _pOriX = CUR_X;
        _pOriY = ORI_Y;
        event_user(0);
        event_user(1);
    }
}
for (COUNT = 0; COUNT < _surfPointNum; COUNT += 1)
{
    event_user(2);
}
