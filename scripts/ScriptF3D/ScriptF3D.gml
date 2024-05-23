// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function f3d(objPoint,viewPoint,objDep,viewDep)
{
	//视角位置(X或Y) 视角坐标(X或Y) 物体深度 视角深度
	return (viewPoint - viewDep * (viewPoint - objPoint) / (viewDep + objDep));
}

function draw_sprite_f3d(spr,sub,alpha,spriteX,spriteY,spriteMainDepth,ViewX,ViewY,viewDep,depth1,depth2,depth3,depth4)
{
	var oriX1=spriteX-sprite_get_xoffset(spr);
	var oriX2=oriX1+sprite_get_width(spr);
	
	var X1=f3d(oriX1,ViewX,spriteMainDepth+depth1,viewDep);
	var X2=f3d(oriX2,ViewX,spriteMainDepth+depth2,viewDep);
	var X3=f3d(oriX2,ViewX,spriteMainDepth+depth3,viewDep);
	var X4=f3d(oriX1,ViewX,spriteMainDepth+depth4,viewDep);
	
	var oriY1=spriteY-sprite_get_yoffset(spr);
	var oriY2=oriY1+sprite_get_height(spr);
	
	var Y1=f3d(oriY1,ViewY,spriteMainDepth+depth1,viewDep);
	var Y2=f3d(oriY1,ViewY,spriteMainDepth+depth2,viewDep);
	var Y3=f3d(oriY2,ViewY,spriteMainDepth+depth3,viewDep);
	var Y4=f3d(oriY2,ViewY,spriteMainDepth+depth4,viewDep);
	
	draw_sprite_pos_fixed(spr,sub,X1,Y1,X2,Y2,X3,Y3,X4,Y4,-1,alpha);
}

function draw_surface_f3d(name,alpha,spriteX,spriteY,spriteMainDepth,ViewX,ViewY,viewDep,depth1,depth2,depth3,depth4)
{
	var oriX1=spriteX;
	var oriX2=oriX1+surface_get_width(name);
	
	var X1=f3d(oriX1,ViewX,spriteMainDepth+depth1,viewDep);
	var X2=f3d(oriX2,ViewX,spriteMainDepth+depth2,viewDep);
	var X3=f3d(oriX2,ViewX,spriteMainDepth+depth3,viewDep);
	var X4=f3d(oriX1,ViewX,spriteMainDepth+depth4,viewDep);
	
	var oriY1=spriteY;
	var oriY2=oriY1+surface_get_height(name);
	
	var Y1=f3d(oriY1,ViewY,spriteMainDepth+depth1,viewDep);
	var Y2=f3d(oriY1,ViewY,spriteMainDepth+depth2,viewDep);
	var Y3=f3d(oriY2,ViewY,spriteMainDepth+depth3,viewDep);
	var Y4=f3d(oriY2,ViewY,spriteMainDepth+depth4,viewDep);
	
	draw_surface_pos_fixed(name,X1,Y1,X2,Y2,X3,Y3,X4,Y4,-1,alpha);
}