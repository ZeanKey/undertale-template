///@desc Button Confirm Call
if (not (IsChosen() && battle.TurnPhase == TURN_PHASE.PLAYER_BUTTON)) then exit;

switch (_phase)
{
	case 0:
	var MULTI_CHOICE	= CreateMultiChoices();
	var TYPER_INFOS		= battle.Encounter.TyperPosition;
	var CHOICE_X, CHOICE_Y, CHOICE_TXT, CUR_ENEMY, PREFIX;
		
	CHOICE_X = TYPER_INFOS.Dialog.X + 48;
	
	MULTI_CHOICE.Init();
	MULTI_CHOICE.Cache.Button = self;
	with (MULTI_CHOICE) NewChoiceMethod = function (paraTyper) {
		paraTyper.Events.PostRender.AddCallback(Cache.Button.BarRenderAbsFactory(paraTyper, Cache.Enemy, Cache.Back, Cache.Front));
	};
		
	for (var INDEX = 0; INDEX < 2; INDEX ++) {
		CUR_ENEMY	= battle.Enemies.Find(INDEX);
		PREFIX		= (battle.Enemies.Find(INDEX).Info.Spareable) ? battle.Encounter.Mercy.Color : "";
		CHOICE_Y	= TYPER_INFOS.Dialog.Y + 32 * INDEX;
		CHOICE_TXT	= PREFIX + "* " + CUR_ENEMY.Info.Name;
		
		MULTI_CHOICE.Add(CHOICE_X, CHOICE_Y, CHOICE_TXT);
		MULTI_CHOICE.Cache.Enemy	= battle.Enemies.Find(INDEX);
		MULTI_CHOICE.Cache.Front	= BarColor.Front;
		MULTI_CHOICE.Cache.Back		= BarColor.Back;
	}
	MULTI_CHOICE.Generate();
	
	audio_play_sound(sndMenuConfirm, 0, 0);
	
	_choice = MULTI_CHOICE;
	_phase ++;
	break;
	
	case 1:
	var RESULT = _choice.Submit();
	
	battle.Soul.RemoveUI();
	
	var AIM = instance_create_depth(0, 0, 0, battleAimBar);
	AIM.Launch(RESULT);

	audio_play_sound(sndMenuConfirm,0,0);
	
	_phase ++;
	break;
	
	case 2:
	break;
	
	case 3:
	with (battleButton) Reset();
	battle.SetTurnPhase(TURN_PHASE.PLAYER_END);
	break;
}

