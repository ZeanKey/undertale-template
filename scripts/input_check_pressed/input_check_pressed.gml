function input_check_pressed(argument0) {
	var result;
	result=0;
	switch (argument0) {
	    case INPUT.CONFIRM:
	    if (keyboard_check_pressed(ord("Z"))) {
	        return true;
	    }
	    break;
	    case INPUT.CANCEL:
	    if (keyboard_check_pressed(ord("X"))) {
	        result=1;
	    }
	    break;
	    case INPUT.MENU:
	    if (keyboard_check_pressed(ord("C"))) {
	        result=1;
	    }
	    break;
	    case INPUT.LEFT:
	    if (keyboard_check_pressed(vk_left)) {
	        result=1;
	    }
	    break;
	    case INPUT.RIGHT:
	    if (keyboard_check_pressed(vk_right)) {
	        result=1;
	    }
	    break;
	    case INPUT.UP:
	    if (keyboard_check_pressed(vk_up)) {
	        result=1;
	    }
	    break;
	    case INPUT.DOWN:
	    if (keyboard_check_pressed(vk_down)) {
	        result=1;
	    }
	    break;
	}
	return (result);
}
