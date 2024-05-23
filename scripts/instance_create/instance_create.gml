/// @description Creates an instance of a given object at a given position.
/// @param x The x position the object will be created at.
/// @param y The y position the object will be created at.
/// @param obj The object to create an instance of.
function instance_create(paraX, paraY, paraObj) {
	return instance_create_depth(paraX, paraY, 0, paraObj);
}
