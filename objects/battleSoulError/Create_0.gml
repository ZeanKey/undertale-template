// Inherit the parent event
event_inherited();

// Info - Soul mode
SoulMode = SOUL_MODE.ERROR;

// Info - Cloth
_lockedX = 320;
_lockedY = 320;

_pointLocked = noone;
_pointSoul = noone;

// Init - Cloth

function Point(xx, yy, locked = false) constructor {
	self.xx = xx;
	self.yy = yy;
	self.preX = xx;
	self.preY = yy;
	self.locked = locked;
	distanceToMouse = 0;
}

function Joint(pointA, pointB, ropeLength) constructor {
	self.pointA = pointA;
	self.pointB = pointB;
	self.ropeLength = ropeLength;
}

points = ds_list_create();
joints = ds_list_create();

grav = 0.2;

nearestPoint = -1;
selectedPoint = -1;

// Set - Cloth
event_user(10);