///@desc Draw Damage Bar
if (not _isInitialized) then exit;

_renderPos.Y = y - sin(_counter) * 20;

draw_reset();
draw_set_font(fontHachiro24);
draw_set_halign(fa_middle);
draw_set_valign(fa_center);
draw_text_outline(_renderPos.X, _renderPos.Y, _text, 2, c_black, c_white);
