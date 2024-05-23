function input_check_released(argument0) {
	var result;
	result=0;
	switch (argument0)
	{
	    case INPUT.CONFIRM:
	    if (keyboard_check_released(ord("Z")))
	    {
	        result=1;
	    }
	    break;
	    case INPUT.CANCEL:
	    if (keyboard_check_released(ord("X")))
	    {
	        result=1;
	    }
	    break;
	    case INPUT.MENU:
	    if (keyboard_check_released(ord("C")))
	    {
	        result=1;
	    }
	    break;
	    case INPUT.LEFT:
	    if (keyboard_check_released(vk_left))
	    {
	        result=1;
	    }
	    break;
	    case INPUT.RIGHT:
	    if (keyboard_check_released(vk_right))
	    {
	        result=1;
	    }
	    break;
	    case INPUT.UP:
	    if (keyboard_check_released(vk_up))
	    {
	        result=1;
	    }
	    break;
	    case INPUT.DOWN:
	    if (keyboard_check_released(vk_down))
	    {
	        result=1;
	    }
	    break;
	}
	return (result);






}
