///@desc Enemy & Button
battle_createEnemy(320,240,ENEMY.SPACE,0);

battle_createButton(87,  453, battleButtonFight, 0);
battle_createButton(240, 453, battleButtonAct,	 1);
battle_createButton(400, 453, battleButtonItem,  2);
battle_createButton(555, 453, battleButtonMercy, 3);

battle_setKarmaMode(true);