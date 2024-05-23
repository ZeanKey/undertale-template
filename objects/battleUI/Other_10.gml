/// @desc Render
draw_reset();
draw_set_font(fontMNC18);
draw_set_halign(fa_left);
draw_set_valign(fa_top);

// Name
var T_NAME = WORLD_PLAYER.Name + "   LV " + string(WORLD_PLAYER.Lv);
draw_text(x, y + 1, T_NAME);
// HP Sign
draw_sprite(sprBattleUIHp, 0, x + 214, y + 5);

// HP Bar
Render.Bar(WORLD_PLAYER.MaxHP, Color.BarBack);
Render.Bar(WORLD_PLAYER.HP.Value, Color.BarFront);

// HP Number
var T_SPACE = "";
var T_NUM_X = 259;
if (instance_exists(battleDamage)) then T_NUM_X += 36;
var T_NUMBER = T_SPACE + string(WORLD_PLAYER.HP.Value) + " / " + string(WORLD_PLAYER.MaxHP);
draw_text(x + T_NUM_X + WORLD_PLAYER.MaxHP * 1.25, y + 1, T_NUMBER);

// Cutom
with (battleDamage) {
	Render();
}

