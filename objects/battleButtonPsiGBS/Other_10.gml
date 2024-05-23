///@desc EVENT.AFTER_BUTTON_PRESS
if (battle_getStep()==BATTLE_STEP.TURN_BUTTON_CHOICE) and (global.battleButtonChoose==_slot)
{
    switch (_step)
    {
        case 4:
        battle_setStep(BATTLE_STEP.TURN_END);
        break;
		
		case 3:
		break;
        
        case 2:
		_step+=1;
        battle_getButtonChoiceResult();
		battle_getEnemyInstance(_enemyChoose)._slot=_slotReturn;
		with(battle_getEnemyInstance(_enemyChoose))
		{
			_battleButton=BATTLE_BUTTON.ACT;
			event_user(1);
		}
		audio_play_sound(sndMenuConfirm,0,0);
		global.encounterObj._globalButtonResult=battle_getButtonActName(_enemyChoose,_slotReturn-1);
        break;
		
        case 1:
        _step+=1;
        battle_getButtonChoiceResult();
		_psiChoose=_slotReturn-1;
		var obj=battle_createButtonChoice();
		switch(_psiChoose)
		{
			case 0:
			_psiLst=_psiOffense;
			break;
			case 1:
			_psiLst=_psiRecover;
			break;
			case 2:
			_psiLst=_psiAssist;
			break;
		}
        battle_setButtonChoiceNumber(obj,array_length(_psiLst));
        for(var i=1;i<=array_length(_psiLst);i++)
        {
            battle_setButtonChoice(obj,i," ",320,257+i*30);
        }
		for(var i=0;i<array_length(_psiLst);i++)
        {
            _arr2[i]=menuCreateTyper(320,287+i*30,_psiLst[i]);
        }
		audio_play_sound(sndMenuConfirm,0,0);
        break;
        
        case 0:
        _step+=1;
        var obj=battle_createButtonChoice();
        battle_setButtonChoiceNumber(obj,3);
        
		if (array_length(_arr1)==0)
		{
			_arr1[0]=menuCreateTyper(108,287,"* Offense");
			_arr1[1]=menuCreateTyper(108,317,"* Recover");
			_arr1[2]=menuCreateTyper(108,347,"* Assist");
		}
		
		battle_setButtonChoice(obj,1," ",108,287);
		battle_setButtonChoice(obj,2," ",108,317);
		battle_setButtonChoice(obj,3," ",108,347);
		audio_play_sound(sndMenuConfirm,0,0);
        break;
    }
}

