// Inherit the parent event
event_inherited();

array_foreach(BoneList, function (curBone, _) {
	instance_destroy(curBone);
});