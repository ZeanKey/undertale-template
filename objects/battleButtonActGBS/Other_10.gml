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
		_enemyChoose=_slotReturn-1;
		var obj=battle_createButtonChoice();
        battle_setButtonChoiceNumber(obj,battle_getButtonActNumber(_enemyChoose));
        for(var i=1;i<=battle_getButtonActNumber(_enemyChoose);i++)
        {
            battle_setButtonChoice(obj,i,"* "+battle_getButtonActName(_slotReturn-1,i-1),battle_getTextPosX()+48+((i+1) mod 2)*battle_getChoiceSpace(),battle_getTextPosY()-30+((i+1) div 2)*30);
        }
		audio_play_sound(sndMenuConfirm,0,0);
        break;
        
        case 0:
        _step+=1;
        var obj=battle_createButtonChoice();
        battle_setButtonChoiceNumber(obj,battle_getEnemyNumber());
        for(var i=1;i<=battle_getEnemyNumber();i++)
        {
            battle_setButtonChoice(obj,i,"* "+battle_getEnemyName(i-1),battle_getTextPosX()+48,battle_getTextPosY()-30+i*30);
        }
		audio_play_sound(sndMenuConfirm,0,0);
        break;
    }
}

