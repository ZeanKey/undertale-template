_load = true;
_effFakeLines = [];
_effClean = false;
_effEnd = false;

var TIME_S = 80;
var TIME_E = 60;
var TIME_RANGE = 30;
var TIME_E_DELAY = TIME_S + TIME_RANGE;
alarm[0] = TIME_E + TIME_RANGE + TIME_E_DELAY;

var ARR_SIGN_R = array_create(floor(h / 2), -1);
repeat ceil(h / 2)
{
	array_push(ARR_SIGN_R, 1);
}
ARR_SIGN_R = array_shuffle(ARR_SIGN_R);

var ARR_SIGN_C = array_create(floor(w / 2), -1);
repeat ceil(w / 2)
{
	array_push(ARR_SIGN_C, 1);
}
ARR_SIGN_C = array_shuffle(ARR_SIGN_C);

// Honrizontal lines
var CUR_P_S, CUR_P_E, CUR_L, SIGN, TS_C, TS_R, TE_C, TE_R;

for (var C_R = 1; C_R < w - 1; C_R ++)
{
	SIGN = ARR_SIGN_R[0];
	array_delete(ARR_SIGN_R, 0 ,1);
	TS_R = C_R;
	TE_R = C_R;
	TS_C = SIGN == -1 ? w - 1 : 0;
	TE_C = SIGN == -1 ? 0 : w - 1;
	CUR_P_S = new SimplePoint(320 + SIGN * (420 + random(300)), y + C_R * _blankRow);
	CUR_P_E = new SimplePoint(320 + SIGN * (720 + random(300)), y + C_R * _blankRow);
	CUR_P_S.ToPoint(TS_R, TS_C, TIME_S + random(TIME_RANGE));
	CUR_P_E.ToPoint(TE_R, TE_C, TIME_E + random(TIME_RANGE), TIME_E_DELAY);
	CUR_L = new SimpleLine(CUR_P_S, CUR_P_E);
	array_push(_effFakeLines, CUR_L)
}

for (var C_C = 1; C_C < h - 1; C_C ++)
{
	SIGN = ARR_SIGN_C[0];
	array_delete(ARR_SIGN_C, 0 ,1);
	TS_R = SIGN == -1 ? h - 1 : 0;
	TE_R = SIGN == -1 ? 0 : h - 1;
	TS_C = C_C;
	TE_C = C_C;
	CUR_P_S = new SimplePoint(x + C_C * _blankColumn, 240 + SIGN * (240 + random(300)));
	CUR_P_E = new SimplePoint(x + C_C * _blankColumn, 240 + SIGN * (540 + random(300)));
	CUR_P_S.ToPoint(TS_R, TS_C, TIME_S + random(TIME_RANGE));
	CUR_P_E.ToPoint(TE_R, TE_C, TIME_E + random(TIME_RANGE), TIME_E_DELAY);
	CUR_L = new SimpleLine(CUR_P_S, CUR_P_E);
	array_push(_effFakeLines, CUR_L)
}