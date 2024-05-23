for (COUNT = 0; COUNT < _surfPointNum; COUNT += 1)
{
    CUR_POINT = ds_list_find_value(_surfPointLst, COUNT);
	if instance_exists(CUR_POINT)
	{
	    with (CUR_POINT)
		{
			instance_destroy();
		}
	}
}