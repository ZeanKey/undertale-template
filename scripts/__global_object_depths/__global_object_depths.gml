function __global_object_depths() {
	// Initialise the global array that allows the lookup of the depth of a given object
	// GM2.0 does not have a depth on objects so on import from 1.x a global array is created
	// NOTE: MacroExpansion is used to insert the array initialisation at import time
	gml_pragma( "global", "__global_object_depths()");

	// insert the generated arrays here
	global.__objectDepths[0] = 0; // world
	global.__objectDepths[1] = 0; // debug
	global.__objectDepths[2] = -1000; // effect
	global.__objectDepths[3] = 0; // battleCleaner
	global.__objectDepths[4] = 0; // battleController
	global.__objectDepths[5] = 0; // battleBackground
	global.__objectDepths[6] = 0; // battleBoxRight
	global.__objectDepths[7] = 0; // battleBoxLeft
	global.__objectDepths[8] = 0; // battleBoxUp
	global.__objectDepths[9] = 0; // battleBoxDown
	global.__objectDepths[10] = 0; // battleBoardFrame
	global.__objectDepths[11] = 0; // battleBoard
	global.__objectDepths[12] = 0; // battleButton
	global.__objectDepths[13] = 0; // battleButtonFight
	global.__objectDepths[14] = 0; // battleButtonTest
	global.__objectDepths[15] = 0; // battleButtonChoice
	global.__objectDepths[16] = 0; // battleUI
	global.__objectDepths[17] = 0; // encounterEnemyTest
	global.__objectDepths[18] = 0; // enemy
	global.__objectDepths[19] = 0; // enemyTest
	global.__objectDepths[20] = 0; // turnTest0
	global.__objectDepths[21] = 0; // turn
	global.__objectDepths[22] = 0; // textTyper


	global.__objectNames[0] = "world";
	global.__objectNames[1] = "debug";
	global.__objectNames[2] = "effect";
	global.__objectNames[3] = "battleCleaner";
	global.__objectNames[4] = "battleController";
	global.__objectNames[5] = "battleBackground";
	global.__objectNames[6] = "battleBoxRight";
	global.__objectNames[7] = "battleBoxLeft";
	global.__objectNames[8] = "battleBoxUp";
	global.__objectNames[9] = "battleBoxDown";
	global.__objectNames[10] = "battleBoardFrame";
	global.__objectNames[11] = "battleBoard";
	global.__objectNames[12] = "battleButton";
	global.__objectNames[13] = "battleButtonFight";
	global.__objectNames[14] = "battleButtonTest";
	global.__objectNames[15] = "battleButtonChoice";
	global.__objectNames[16] = "battleUI";
	global.__objectNames[17] = "encounterEnemyTest";
	global.__objectNames[18] = "enemy";
	global.__objectNames[19] = "enemyTest";
	global.__objectNames[20] = "turnTest0";
	global.__objectNames[21] = "turn";
	global.__objectNames[22] = "textTyper";


	// create another array that has the correct entries
	var len = array_length_1d(global.__objectDepths);
	global.__objectID2Depth = [];
	for( var i=0; i<len; ++i ) {
		var objID = asset_get_index( global.__objectNames[i] );
		if (objID >= 0) {
			global.__objectID2Depth[ objID ] = global.__objectDepths[i];
		} // end if
	} // end for


}
