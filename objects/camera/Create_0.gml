/// @desc Init
event_user(0);

Surface	= -1;
Camera	= camera_create_view(	x, y, 
								Width / ScaleX, Height / ScaleY,
								Angle, Target, -1, -1,
								Width / ScaleX / 2, Height / ScaleY / 2);