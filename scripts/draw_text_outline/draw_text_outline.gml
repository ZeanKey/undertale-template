// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function draw_text_outline(paraX, paraY, paraStr, paraWidth, paraOutlineColor, paraTextColor){
	draw_set_color(paraOutlineColor);
	var PRECISE = 4;
	var CUR_ANGLE;
	for (var INDEX = 0; INDEX < PRECISE; INDEX ++) {
		CUR_ANGLE = 360 / PRECISE * INDEX;
		draw_text(	paraX + lengthdir_x(paraWidth, CUR_ANGLE),
					paraY + lengthdir_y(paraWidth, CUR_ANGLE), paraStr);
	}
	draw_set_color(paraTextColor);
	draw_text(paraX, paraY, paraStr);
}