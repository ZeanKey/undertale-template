/// @desc Spread
var P_CUR, P_NEXT, P_PREVIOUS, IS_FIRST, IS_LAST;
P_CUR = id;
P_NEXT = noone;
P_PREVIOUS = noone;
IS_FIRST = false;
IS_LAST = false;

with (_parent)
{
    var P_INDEX;
    P_INDEX = ds_list_find_index(_surfPointLst, P_CUR);
    if (P_INDEX > 0)
    {
        P_PREVIOUS = ds_list_find_value(_surfPointLst, P_INDEX - 1)
    }
    else
    {
        IS_FIRST = true;
    }
    
    if (P_INDEX < ds_list_size(_surfPointLst) - 1)
    {
        P_NEXT = ds_list_find_value(_surfPointLst, P_INDEX + 1)
    }
    else
    {
        IS_LAST = true;
    }
}

var DELTA_Y;
if (not IS_LAST)
{
    if (P_NEXT != noone)
    { 
        DELTA_Y = (P_CUR._pDeltaPos - P_NEXT._pDeltaPos) * _pSpread;
        P_NEXT._pVelocity += DELTA_Y;
        P_NEXT._pDeltaPos += DELTA_Y;
    }
}
if (not IS_FIRST)
{
    if (P_PREVIOUS != noone)
    {
        DELTA_Y = (P_CUR._pDeltaPos - P_PREVIOUS._pDeltaPos) * _pSpread;
        P_PREVIOUS._pVelocity += DELTA_Y;
        P_PREVIOUS._pDeltaPos += DELTA_Y;
    }
}








