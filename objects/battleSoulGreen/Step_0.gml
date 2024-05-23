if(input_check(INPUT.UP))
{
	_targetDir=90;
}
if(input_check(INPUT.DOWN))
{
	_targetDir=270;
}
if(input_check(INPUT.LEFT))
{
	_targetDir=180;
}
if(input_check(INPUT.RIGHT))
{
	_targetDir=0;
}

if (_targetLastDir!=_targetDir)
{
	_untimer=10;
}

if (_untimer>0)
{
	var BDIR=_targetDir-_defDir;
	if (BDIR>180)
	{
		BDIR=BDIR-360;
	}
	
	if (BDIR<-180)
	{
		BDIR=360+BDIR;
	}
	_defDir+=(BDIR)/4;
	_untimer-=1;
	if (_untimer==0)
	{
		_defDir=_targetDir;
	}
}

_targetLastDir=_targetDir;

if (instance_exists(_def))
{
	_def.image_angle=_defDir;
	_def.x=x;
	_def.y=y;
	_def.image_index=_sub;
}

// Inherit the parent event
event_inherited();


