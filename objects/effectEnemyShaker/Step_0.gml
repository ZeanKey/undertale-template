_shake-=0.5;
_timer+=1.2;

_enemy.x=_oriX+sin(_timer)*_shake;

if (_shake==0)
{
	instance_destroy();
	_enemy.x=_oriX;
}