//Init - Draw Settings
depth			= DEPTH.BULLET_OUTSIDE_LOW;
image_alpha		= 0;
image_xscale	= 2;
image_yscale	= 2;
image_speed		= 0;
image_angle		= 0;

//Init - Motion Settings
direction		= 0;
speed			= 0;
_speedX			= 0;
_speedY			= 0;
_accX			= 0;
_accY			= 0;

//Init - Stars
_starGrade = 3;
_starAlarm = 20;
_starNum   = 4;
_starSpd   = 3;

//Init - Others
_forceCrack = false;
_rotSign	= choose(1,-1);
_targetInst = noone; //battleBoardFrame;
_splash		= false; 
_width	= sprite_get_width(sprite_index);
_height	= sprite_get_height(sprite_index);

//Init - Figures for tearing effect
_bandNumY	= 20;
_bandHeight = _height / _bandNumY;
_bandNumX	= 17;
_bandWidth	= _width  / _bandNumX;

//Start
audio_play_sound(sndNoise, false, false);
Anim_New(id, "image_alpha", ANIM_TWEEN.LINEAR, ANIM_TWEEN.IN, 0, 1, 10);

//Basic functions defination
var FILE = file_text_open_read("pieceImage.txt");
var LINE = 0;

while (!file_text_eof(FILE))
{
	_dye[LINE] = file_text_read_string(FILE);
	file_text_readln(FILE);
	LINE ++;
}

file_text_close(FILE);

function pieceGet(targetX,targetY)
{
	return(string_copy(_dye[targetY],targetX+1,1));
}

function effectTearingGetX(imageWidth,imageHeight,partLeft,partUp)
{	
	var X_ORI=imageWidth/2-partLeft;
	var Y_ORI=imageHeight/2-partUp;
	var X_EDIT=lengthdir_x(image_xscale*X_ORI,180+image_angle)+lengthdir_x(image_yscale*Y_ORI,90+image_angle);
	
	return(X_EDIT);
}

function effectTearingGetY(imageWidth,imageHeight,partLeft,partUp)
{
	var X_ORI=imageWidth/2-partLeft;
	var Y_ORI=imageHeight/2-partUp;
	var Y_EDIT=lengthdir_y(image_xscale*X_ORI,180+image_angle)+lengthdir_y(image_yscale*Y_ORI,90+image_angle);
	
	return(Y_EDIT);
}