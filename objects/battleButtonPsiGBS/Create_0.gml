/// @description Insert description here
// You can write your code in this editor

// Inherit the parent event
event_inherited();

image_xscale=2;
image_yscale=2;
image_alpha=0.5;

_scale=2;
_inst=0;

_xOri=x;
_yOri=y;

x=0;
y=0;

_arr1=[];
_arr2=[];

_psiOffense=["PSI Rockin"];
_psiRecover=["Life Up","Healing"];
_psiAssist=["Shield"];

function menuCreateTyper(tx,ty,ttext)
{
	var TYP=instance_create(tx,ty,textTyper);
	TYP._str=ttext;
	menuTextProcess(TYP);
	return(TYP);
}

function menuTextProcess(targetId)
{
	targetId._mode=TYPER_MODE.CUSTOM;
	targetId._color=c_white;
	targetId._instant=true;
	targetId._speed=1;
	targetId._addY=40;
	targetId._skip=0;
	targetId._font=FONT.NORMAL;
}