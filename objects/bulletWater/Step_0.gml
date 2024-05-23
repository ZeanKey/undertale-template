///@desc Update
var CUR_POINT, COUNT;
for (COUNT = 0; COUNT < _surfPointNum; COUNT += 1)
{
    CUR_POINT = ds_list_find_value(_surfPointLst, COUNT);
    with (CUR_POINT)
    {
        //show_message(CUR_POINT)
        event_user(0);
        event_user(1);
    }
}
for (COUNT = 0; COUNT < _surfPointNum; COUNT += 1)
{
    CUR_POINT = ds_list_find_value(_surfPointLst, COUNT);
    with (CUR_POINT)
    {
        event_user(2);
    }
}
