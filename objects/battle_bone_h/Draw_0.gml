/// @description Insert description here
// You can write your code in this editor
if(variable_instance_exists(id,"idir"))
{
	if(idir==DIR.RIGHT)
	{
		if(variable_instance_exists(id,"cSize"))
		{
			x=xstart+cSize-size;
		}
		else
		{
			x=xstart+size;
		}
	}
}

if(out = 0){
	depth = DEPTH.BULLET;
}
else{
	depth = DEPTH.BULLET_OUTSIDE_HIGH;
}

var color;
if(mode = 0){
	color = make_color_rgb(255,255,255);
}
if(mode = 1){
	color = make_color_rgb(20,196,255);
}
if(mode = 2){
	color = make_color_rgb(248,148,29);
}

if(out = 0){
	surface_set_target(Battle_GetBoardSurface()){
		draw_set_color(color);
		draw_sprite_ext(sprBattleBonepartZhaZha,_boneHeadIndex,x,y+7,1,1,90,color,1);
		draw_rectangle(x+10,y-4,x+size,y+1,0);
		draw_sprite_ext(sprBattleBonepartZhaZha,_boneHeadIndex,x+10+size,y-9,1,1,-90,color,1);
	}surface_reset_target();
}
else{
		draw_set_color(color);
		draw_sprite_ext(sprBattleBonepartZhaZha,_boneHeadIndex,x,y+7,1,1,90,color,1);
		draw_rectangle(x+10,y-4,x+size,y+1,0);
		draw_sprite_ext(sprBattleBonepartZhaZha,_boneHeadIndex,x+10+size,y-9,1,1,-90,color,1);
}
if(collision_line(x+5,y-4,x+size+3,y-4,obj,0,0)||collision_line(x+5,y+1,x+size+3,y+1,obj,0,0)){
	event_user(0)
}
//draw_set_color(c_blue)
//draw_line(x+5,y-4,x+size+3,y-4)
//draw_line(x+5,y+1,x+size+3,y+1)