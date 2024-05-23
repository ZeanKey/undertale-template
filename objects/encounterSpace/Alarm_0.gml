/// @desc Create Background Parts
if (_encBackgroundEnable)
{
	if (ds_list_empty(_encPartsLst))
	{
		for(var INDEX = 0; INDEX < _encPartsNum; INDEX ++)
		{
			ds_list_add(_encPartsLst, INDEX)
		}
	}
	
	ds_list_shuffle(_encPartsLst);
	var RNG = ds_list_find_value(_encPartsLst, 0);
	instance_create(random_range(RNG * 640 / _encPartsNum, 
								(RNG + 1) * 640 / _encPartsNum),
								-60, battleBGPStar);
	ds_list_delete(_encPartsLst,0);
}

alarm[0] = 60;