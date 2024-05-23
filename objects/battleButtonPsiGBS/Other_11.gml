///@desc EVENT.BUTTON_CANCEL
if (battle_getStep()==BATTLE_STEP.TURN_BUTTON_CHOICE) and (global.battleButtonChoose==_slot)
{
    switch (_step)
    {
        case 1:
        _step-=1;
        battle_cleanButtonChoice();
		repeat(3)
		{
			instance_destroy(_arr1[0]);
			array_delete(_arr1,0,1);
		}
		battle_setStep(BATTLE_STEP.TURN_PREPARE);
        break;
		
		case 2:
        _step-=1;
        battle_cleanButtonChoice();
		_psiChoose=_slotReturn-1;
		var obj=battle_createButtonChoice();
        battle_setButtonChoiceNumber(obj,3);
        battle_setButtonChoice(obj,1," ",108,287);
		battle_setButtonChoice(obj,2," ",108,317);
		battle_setButtonChoice(obj,3," ",108,347);
		
		var LEN=array_length(_arr2);
		
		repeat(LEN)
		{
			instance_destroy(_arr2[0]);
			array_delete(_arr2,0,1);
		}
        break;
    }
}


