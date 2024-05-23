///@desc Init
event_inherited();

Index			= -1;
IsActivated		= true;
IsControlled	= false;

_stateOrigin	= false;

_dir = DIR.DOWN;
_accessible[DIR.UP]		= true;
_accessible[DIR.DOWN]	= true;
_accessible[DIR.LEFT]	= true;
_accessible[DIR.RIGHT]	= true;

Animations = new EntitySprite();

TryInteract = function (paraEntity, paraSide) {
	if (IsActivated) {
		if (_accessible[paraSide]) {
			Interact(paraEntity, paraSide);
		}	
	}
};

Interact = function (paraEntity) {
	
};