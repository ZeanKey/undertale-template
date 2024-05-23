// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function gbsSetButtonEff(){
	//if (global.battleButtonChoose==_slot) && (battle_getState()==BATTLE_STATE.PLAYER)
	//{
	//	if (_scale!=2.5)
	//	{
	//		if (Anim_IsExists(id,"_scale"))
	//		{
	//			if (instance_exists(_inst[0]))
	//			{
	//				if (_inst[0]._change<0)
	//				{
	//					Anim_Stop(id,"_scale");
	//				}
	//			}
	//		}
	//		else
	//		{
	//			_inst=Anim_New(id,"_scale",ANIM_TWEEN.QUINT,ANIM_EASE.OUT,_scale,2.5-_scale,15);
	//		}
	//	}
	//}

	//if (global.battleButtonChoose!=_slot) || (battle_getState()==BATTLE_STATE.ENEMY)
	//{
	//	if (_scale!=2)
	//	{
	//		if (Anim_IsExists(id,"_scale"))
	//		{
	//			if (instance_exists(_inst[0]))
	//			{
	//				if (_inst[0]._change>0)
	//				{
	//					Anim_Stop(id,"_scale");
	//				}
	//			}
	//		}
	//		else
	//		{
	//			_inst=Anim_New(id,"_scale",ANIM_TWEEN.QUINT,ANIM_EASE.OUT,_scale,2-_scale,15);
	//		}
	//	}
	//}
	
	if (global.battleButtonChoose!=_slot) or (battle_getState()==BATTLE_STATE.ENEMY)
	{
		if (image_alpha!=0.5)
		{
			if (Anim_IsExists(id,"image_alpha"))
			{
				if (instance_exists(_inst[0]))
				{
					if (_inst[0]._change>0)
					{
						Anim_Stop(id,"image_alpha");
					}
				}
			}
			else
			{
				_inst=Anim_New(id,"image_alpha",ANIM_TWEEN.LINEAR,ANIM_EASE.IN,image_alpha,0.5-image_alpha,15);
			}
		}
	}

	if (global.battleButtonChoose==_slot) && (battle_getState()==BATTLE_STATE.PLAYER)
	{
		if (image_alpha!=1)
		{
			if (Anim_IsExists(id,"image_alpha"))
			{
				if (instance_exists(_inst[0]))
				{
					if (_inst[0]._change<0)
					{
						Anim_Stop(id,"image_alpha");
					}
				}
			}
			else
			{
				_inst=Anim_New(id,"image_alpha",ANIM_TWEEN.LINEAR,ANIM_EASE.IN,image_alpha,1-image_alpha,15);
			}
		}
	}

	//image_xscale=_scale;
	//image_yscale=_scale;
}