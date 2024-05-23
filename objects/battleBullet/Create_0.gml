/// @desc Init
IsOnBoard = false;

__render__ = __default_render__;

Events = {
	Collision	: new Event(),
	Create		: new Event(),
	Custom		: new Event(),
	PreStep 	: new Event(),
	Step		: new Event(),
	PostStep	: new Event(),
	PreDraw		: new Event(),
	Draw		: new Event(),
	CleanUp		: new Event(),
};