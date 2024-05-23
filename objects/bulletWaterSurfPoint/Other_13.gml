///@desc Collision
var VALUE	= _collisionValue;
var INST	= id;
var SIGN	= _collisionSign;

INST._pDeltaPos += VALUE * SIGN;
    
var INDEX, POINT_PREVIOUS, POINT_NEXT;
INDEX = ds_list_find_index(_target._surfPointLst, INST);
    
if (INDEX > 0)
{
    POINT_PREVIOUS = ds_list_find_value(_target._surfPointLst, INDEX - 1);
    POINT_PREVIOUS._pDeltaPos -= VALUE * SIGN * _target._pSpread * 3;
}
if (INDEX < ds_list_size(_target._surfPointLst) - 1)
{
    POINT_NEXT = ds_list_find_value(_target._surfPointLst, INDEX + 1);
    POINT_NEXT._pDeltaPos -= VALUE * SIGN * _target._pSpread * 3;
}