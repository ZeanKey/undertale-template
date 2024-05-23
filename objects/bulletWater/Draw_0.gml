/// @desc Draw Surface
var CUR_POINT1, CUR_POINT2, COUNT;
draw_set_color(image_blend);
draw_set_alpha(image_alpha);

//surface_set_target(Battle_GetBoardSurface());
for (COUNT = 0; COUNT < _surfPointNum - 1; COUNT += 1)
{
    CUR_POINT1 = ds_list_find_value(_surfPointLst, COUNT);
    CUR_POINT2 = ds_list_find_value(_surfPointLst, COUNT + 1);    
    draw_triangle(  CUR_POINT1.x, CUR_POINT1.y,
                    CUR_POINT1.x, _surfPosY,
                    CUR_POINT2.x, _surfPosY,
                    false
                    );
    draw_triangle(  CUR_POINT1.x, CUR_POINT1.y,
                    CUR_POINT2.x, CUR_POINT2.y,
                    CUR_POINT2.x, _surfPosY,
                    false
                    );
}
//surface_reset_target();






