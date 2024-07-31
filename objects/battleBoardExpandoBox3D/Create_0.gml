/// @desc Init
// Inherit the parent event
event_inherited();
outline_init();

isInitialized = false;

shdrParamWidth	= shader_get_uniform(shdrModelRecolor, "board_width");
shdrParamColor	= shader_get_uniform(shdrModelRecolor, "blend_color");

BoardSurface = -1;
BoardColor = c_white;
BoardAlpha = 1.0;
BoardSize = new Vector3D(1, 1, 1);

BoxSpace = -1;
ValidateBoxSpace = function () {
	if (!surface_exists(BoxSpace)) BoxSpace = surface_create(640, 480);
}
TargetBoxSpace = function () {
	ValidateBoxSpace();
	surface_set_target(BoxSpace);
}

SoulInst = noone;

var box = self;

_renderAngle	= 0;
_renderPos		= new Vector2D(0, 0);
_renderSize		= new Vector2D(1, 1);

Transform = new TransformData(new Vector3D(0, 0, 0), new Vector3D(0, 0, 0), new Vector3D(1, 1, 1));
AxisLineLength = 0;
LayerHeight = 0;

GetTransform = function () {
	return matrix_build(
		Transform.Position.X, Transform.Position.Y, Transform.Position.Z, 
		Transform.Rotation.X, Transform.Rotation.Y, Transform.Rotation.Z, 
		Transform.Scale.X, Transform.Scale.Y, Transform.Scale.Z
	);
}

var uvs = sprite_get_uvs(sprPixel, 0);
// position_3d
// texcoord
// colour
// normal
ModelBoxCreate = function (uvs)
{
	var modelBuffer = vertex_create_buffer();
	vertex_begin(modelBuffer, global.format_general);
	// R L F B T D
	vertex_add_face(modelBuffer,[1,-1,-1],	[1,1,-1],	[1,1,1],	[1,-1,1],	uvs, c_white, 1, [1, 0, 0]);
	vertex_add_face(modelBuffer,[-1,1,-1],	[-1,-1,-1],	[-1,-1,1],	[-1,1,1],	uvs, c_white, 1, [-1, 0, 0]);
	vertex_add_face(modelBuffer,[-1,-1,-1],	[1,-1,-1],	[1,-1,1],	[-1,-1,1],	uvs, c_white, 1, [0, -1, 0]);
	vertex_add_face(modelBuffer,[1,1,-1],	[-1,1,-1],	[-1,1,1],	[1,1,1],	uvs, c_white, 1, [0, 1, 0]);
	vertex_add_face(modelBuffer,[1,-1,-1],	[-1,-1,-1],	[-1,1,-1],	[1,1,-1],	uvs, c_white, 1, [0, 0, -1]);
	vertex_add_face(modelBuffer,[-1,-1,1],	[1,-1,1],	[1,1,1],	[-1,1,1],	uvs, c_white, 1, [0, 0, 1]);
	vertex_end(modelBuffer);
	return modelBuffer;
}
ModelAxisLineCreate = function (uvs)
{
	var modelBuffer = vertex_create_buffer();
	vertex_begin(modelBuffer, global.format_general);
	// X axis
	vertex_add_point(modelBuffer, -1,  0,  0, 0, 0, 1, 0, 0, c_green, 1);
	vertex_add_point(modelBuffer,  1,  0,  0, 0, 0, 1, 0, 0, c_green, 1);
	// Y axis
	vertex_add_point(modelBuffer,  0, -1,  0, 0, 0, 1, 0, 0, c_blue, 1);
	vertex_add_point(modelBuffer,  0,  1,  0, 0, 0, 1, 0, 0, c_blue, 1);
	// Z axis
	vertex_add_point(modelBuffer,  0,  0, -1, 0, 0, 1, 0, 0, c_red, 1);
	vertex_add_point(modelBuffer,  0,  0,  1, 0, 0, 1, 0, 0, c_red, 1);
	vertex_end(modelBuffer);
	return modelBuffer;
}
ModelLayerCreate = function (uvs)
{
	var modelBuffer = vertex_create_buffer();
	vertex_begin(modelBuffer, global.format_general);
	//
	vertex_add_point(modelBuffer, -1, 0, -1, 0, 0, 1, 0, 0, c_white, 1);
	vertex_add_point(modelBuffer,  1, 0, -1, 0, 0, 1, 0, 0, c_white, 1);
	vertex_add_point(modelBuffer,  1, 0,  1, 0, 0, 1, 0, 0, c_white, 1);
	vertex_add_point(modelBuffer, -1, 0,  1, 0, 0, 1, 0, 0, c_white, 1);
	vertex_add_point(modelBuffer, -1, 0, -1, 0, 0, 1, 0, 0, c_white, 1);
	vertex_end(modelBuffer);
	return modelBuffer;
}

ModelBuffer = ModelBoxCreate(uvs);
ModelAxisLineBuffer = ModelAxisLineCreate(uvs);
ModelLayer = ModelLayerCreate(uvs);

Render = {
	Box : box,
	Mask : function () {
		
	},
	Frame : function () {

	},
	Inner : function () {

	}
};