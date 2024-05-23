/// @desc Layer & Random
depth = DEPTH_UI.TEXT;

#region Encounter Init
// -- Battle Typer Settings -- //
_boardTyperX = 60;
_boardTyperY = 287;
_boardTyperSpace = 240;
_boardTyperBarX = 260;
_boardTyperPageX = 326;
_boardTyperPageY = 47;

// -- Enemy Settings -- //
_mercyEnable = false;

// -- Effect Settings -- //
_encBackgroundEnable = false;
_soulCreateEffect = true;

_counter	= 0;
_alpha		= 0;
_timer		= 0;

// Effect - Background Parts Init
alarm[0]=10;
_encPartsLst	= ds_list_create();
_encPartsNum	= 2;

for (var INDEX = 0; INDEX < _encPartsNum; INDEX ++)
{
	ds_list_add(_encPartsLst, INDEX);
}
#endregion

#region Encounter Start
// Battle - Fading Effect
Fader_Fade(1, 0, 60, c_black);
// Battle - Enemy Turn
battle_stateInit(BATTLE_STATE.ENEMY);
#endregion