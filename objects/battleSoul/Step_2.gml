/// @desc Update Soul Mode & Destruction
// Destroys if in player's turn
if (battle.GetTurnClass() != TURN_CLASS.ENEMY) then instance_destroy();