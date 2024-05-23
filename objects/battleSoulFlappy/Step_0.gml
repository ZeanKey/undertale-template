event_inherited()

var IS_HURT=false;
if (_inv>0)
{
	IS_HURT=true;
}

if(_index<3)
{
	_index+=0.5;
}

image_index=_index+IS_HURT*4

var SPD=2
var SPD=(input_check(INPUT.CANCEL) ? SPD/2 : SPD);

if(_moveable)
{
	repeat(SPD*10)
	{
		if(input_check(INPUT_BLUE.LEFT))
		{
			if(!IsPositionCollideFrame(x-lengthdir_x(sprite_width/2,image_angle-90),y-lengthdir_y(sprite_width/2,image_angle-90)))
			{
				x-=lengthdir_x(0.1,image_angle);
				y-=lengthdir_y(0.1,image_angle);
			}
		}
		if(input_check(INPUT_BLUE.RIGHT))
		{
			if(!IsPositionCollideFrame(x+lengthdir_x(sprite_width/2,image_angle-90),y+lengthdir_y(sprite_width/2,image_angle-90)))
			{
				x+=lengthdir_x(0.1,image_angle);
				y+=lengthdir_y(0.1,image_angle);
			}
		}
	}
	
	if (_impact)
	{
		_move=15;
	}
	
	if IsPositionCollideFrame(x-lengthdir_x(sprite_height/2,image_angle-90),y-lengthdir_y(sprite_height/2,image_angle-90))
	{
		if (_impact)
		{
			_move=15;
		}
		else if (_move!=0)
		{
			_move=0;
		}
		else
		{
			_move=_speed_jump;
		}
	}
	
	if (input_check_pressed(INPUT_BLUE.UP))
	{
		_move=0-_speed_jump
	}
	if (input_check(INPUT_BLUE.UP))
	{
		_index=0;
	}
	
	if (!IsPositionCollideFrame(x+lengthdir_x(1+sprite_height/2,image_angle-90),y+lengthdir_y(1+sprite_height/2,image_angle-90)) or IsPositionCollideFrame(x+lengthdir_x(0.1+sprite_height/2,image_angle-90),y+lengthdir_y(0.1+sprite_height/2,image_angle-90)))
	{		
	    if (_move<0)
	    {
	        _move=(_move+_gravity_jump)
	        if (!input_check(INPUT_BLUE.UP))
			{
	            _move=0;
			}
		}
	    else
	    {
	        if (_move < 0.01)
			{
				_move = (_move + 0.0025)
			}
	        else if (_move<_gravity_fall_max)
			{
				_move=(_move + _gravity_fall)
			}
			else
			{
				_move=_gravity_fall_max
			}
	    }
	}
	else
	{
		if (_impact)
		{
			_impact=false;
			audio_play_sound(sndDong,0,0);
			create_shake();
		}
	}
	
	var JUMP_SPEED=abs(_move)
	if(JUMP_SPEED>0)
	{
		repeat(JUMP_SPEED*10)
		{
			if(!IsPositionCollideFrame(x+lengthdir_x(sprite_height/2,image_angle-90),y+lengthdir_y(sprite_height/2,image_angle-90)))&&(!IsPositionCollideFrame(x-lengthdir_x(sprite_height/2,image_angle-90),y-lengthdir_y(sprite_height/2,image_angle-90)))
			{
				y+=lengthdir_y(0.1,image_angle-90)*sign(_move);
				x+=lengthdir_x(0.1,image_angle-90)*sign(_move);
			}
		}
		//x=round(x);
		//y=round(y);
	}
}

/// @desc BLOCK_CHECK
x=round(x);
y=round(y);
//Block
if(_follow_board)
{
	x+=battleBoard.x-battleBoard.xprevious;
	y+=battleBoard.y-battleBoard.yprevious;
}

while(IsPositionCollideFrame(x+sprite_width/2,y))
{
	x-=0.01;
}
while(IsPositionCollideFrame(x-sprite_width/2,y))
{
	x+=0.01;
}
while(IsPositionCollideFrame(x,y+sprite_height/2))
{
	y-=0.01;
}
while(IsPositionCollideFrame(x,y-sprite_height/2))
{
	y+=0.01;
}