///@desc Cache Update Turn
// Assume that we may not generate turn in a linar sequence,
// I use the switch structure instead.
var TURN_OBJECT = undefined;

switch (battle.TurnIndex) {
	case 0:
	TURN_OBJECT = turnSpaceDream;
	break;
}

if (is_undefined(TURN_OBJECT)) then show_error("Encounter - Turn Object doesn't exist.", true);

Cache.TurnObject = TURN_OBJECT

