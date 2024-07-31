/// @desc
if (instance_exists(battleBoardExpandoBox3D))
{
	var target = battleBoardExpandoBox3D.id;
	target.TargetBoxSpace();
	global.Bullet3DServer.DrawBone(Size, 
		matrix_multiply(matrix_multiply(matrix_build(
			Position.X, Position.Y, Position.Z, 
			Rotation.X, Rotation.Y, Rotation.Z,
			1, 1, 1), ParentTransform
		), target.GetTransform())
	);
	surface_reset_target();
}
