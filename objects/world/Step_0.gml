/// @desc Update
GameTiming += delta_time;

if (keyboard_check_pressed(ord("O"))) {
	if (room == roomBattle) {
		room_goto(roomLaunch);
	}
}
