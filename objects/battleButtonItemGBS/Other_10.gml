///@desc EVENT.BUTTON_PRESS
if (battle_getStep()==BATTLE_STEP.TURN_BUTTON_CHOICE) and (global.battleButtonChoose==_slot)
{
    switch (_step)
    {
        case 3:
        battle_setStep(BATTLE_STEP.TURN_END);
        break;
        
        case 2:
        break;
		
        case 1:
        _step+=1;
        battle_getButtonChoiceResult();
		battle_useItem(item_getOrigin(_slotReturn-1));
		global.encounterObj._globalButtonResult=item_getName(item_getOrigin(_slotReturn-1));
		item_remove(_slotReturn-1);
		audio_play_sound(sndItemSwallow,0,0);
        break;
        
        case 0:
		_step+=1;
	    var obj=battle_createButtonChoiceItem();
	    battle_setButtonChoiceNumber(obj,item_getNumber());
		var count=1;
	    for(var i=1;i<=item_getNumber();i++)
	    {
			if (count>4)
			{
				count=1;
			}
			
			var tx=battle_getTextPosX()+48+((count+1) mod 2)*battle_getChoiceSpace();
			var ty=battle_getTextPosY()-30+((count+1) div 2)*30;
			
			count++;
			
			battle_setButtonChoice(obj,i,"* "+item_getName(item_getOrigin(i-1)),tx,ty);
	    }
		audio_play_sound(sndMenuConfirm,0,0);
        break;
    }
}

