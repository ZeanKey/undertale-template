///@desc EVENT.AFTER_BUTTON_PRESS
if (battle_getStep()==BATTLE_STEP.TURN_BUTTON_CHOICE) and (global.battleButtonChoose==_slot)
{
    switch (_step)
    {
        case 2:
        battle_setStep(BATTLE_STEP.TURN_END);
        break;
        
        case 1:
		_step+=1;
        battle_getButtonChoiceResult();
		switch(_slotReturn)
		{
			case 1:
			battle_setStep(BATTLE_STEP.TURN_END);
			global.encounterObj._globalButtonResult=_choice1;
			//Write By Your Self
			break;
			case 2:
			battle_setStep(BATTLE_STEP.TURN_END);
			global.encounterObj._globalButtonResult=_choice2;
			//Write By Your Self
			break;
		}
		audio_play_sound(sndMenuConfirm,0,0);
        break;
        
        case 0:
        _step+=1;
        var obj=battle_createButtonChoice();
        battle_setButtonChoiceNumber(obj,2);
		_choice1=lang_getString("battle.ini",global.language,"buttonMercy0");
		_choice2=lang_getString("battle.ini",global.language,"buttonMercy1");
        battle_setButtonChoice(obj,1,(global.encounterObj._mercyEnable ? "{color yellow}":"")+"* "+_choice1,battle_getTextPosX()+48,battle_getTextPosY());
		battle_setButtonChoice(obj,2,"* "+_choice2,battle_getTextPosX()+48,battle_getTextPosY()+30);
		audio_play_sound(sndMenuConfirm,0,0);
        break;
    }
}

