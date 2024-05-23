_speedY += _accY;
_speedX += _accX;

x += _speedX;
y += _speedY;

image_angle += _rotSign * sqrt(power(_speedX, 2) + power(_speedY, 2))/2;

if (!_splash)
{
	if (place_meeting(x, y, _targetInst) or _forceCrack)
	{
		_splash = true;
		audio_play_sound(sndBreak0, false, false);
		var ADD_X;
		var ADD_Y;
		var CURRENT_INST;
		var PIECE;
		for (var CURRENT_BAND_Y=0;CURRENT_BAND_Y<_bandNumY;CURRENT_BAND_Y+=1)
		{
			for (var CURRENT_BAND_X=0;CURRENT_BAND_X<_bandNumX;CURRENT_BAND_X+=1)
			{
				PIECE=pieceGet(CURRENT_BAND_X,CURRENT_BAND_Y);
				if (PIECE!="0")
				{
					ADD_X = effectTearingGetX(_width,_height,_bandWidth*CURRENT_BAND_X,_bandHeight*CURRENT_BAND_Y);
					ADD_Y = effectTearingGetY(_width,_height,_bandWidth*CURRENT_BAND_X,_bandHeight*CURRENT_BAND_Y);
					CURRENT_INST = instance_create(x+ADD_X,y+ADD_Y,effectSplashPiece);
					switch(PIECE)
					{
						case 1:
						CURRENT_INST._color = c_white;
						break;
						case 2:
						CURRENT_INST._color = c_gray;
						break;
					}
					CURRENT_INST._spd /= 4;
					CURRENT_INST.speed = 1;
					CURRENT_INST.depth = depth;
					CURRENT_INST.image_xscale = image_yscale;
					CURRENT_INST.image_yscale = image_yscale;
					//draw_sprite_general(sprBlasterEffectCard,image_index,0,_bandHeight*CURRENT_BAND,_width,_bandHeight,x+ADD_X,y+ADD_Y,image_xscale,image_yscale,image_angle,-1,-1,-1,-1,image_alpha);
					//show_debug_message(string(CURRENT_BAND_X)+","+string(CURRENT_BAND_Y));
				}
			}
		}
		//screen.battle_boardShake(100,100,0,0);
		instance_destroy();
		
		gbsCreateStar(x, y, point_direction(0, 0, _speedX, _speedY), _starGrade, _starAlarm, _starSpd, 120, _starNum);
	}
	if (x<-100||x>room_width+100||y<-100||y>room_height+100)
	{
		instance_destroy();
	}
}