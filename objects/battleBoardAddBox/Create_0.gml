/// @desc Init
// Inherit the parent event
event_inherited();

var BOX = self;

_sprMask	= sprBoardBoxMask;
_sprFrame	= sprBoardBoxFrame;
_sprInner	= sprBoardBoxInner;

_renderAngle	= 0;
_renderPos		= new Vector2D(0, 0);
_renderSize		= new Vector2D(1, 1);
_frameCollider	= instance_create_depth(x, y, depth, battleBoardFrameAdd);

Size = new Vector2D(1, 1);

Scale = {
	Box : BOX,
	Inner : function (paraLen) {
		return paraLen / 2 - 5;
	},
	Outer : function (paraLen) {
		return paraLen / 12;
	},
	Update : function () {
		with (Box) {
			_renderPos.X = x;
			_renderPos.Y = y;
			_renderAngle = image_angle;
			_renderSize.X = Size.X;
			_renderSize.Y = Size.Y;
			image_xscale = Scale.Inner(_renderSize.X);
			image_yscale = Scale.Inner(_renderSize.Y);
			
			_frameCollider.x = x;
			_frameCollider.y = y;
			_frameCollider.image_angle = image_angle;
			_frameCollider.image_xscale = Scale.Outer(_renderSize.X);
			_frameCollider.image_yscale = Scale.Outer(_renderSize.Y);
		}
	},
}

Render = {
	Box : BOX,
	Mask : function () {
		with (Box) draw_sprite_ext(	_sprMask, image_index,
									_renderPos.X, _renderPos.Y, Scale.Outer(_renderSize.X), Scale.Outer(_renderSize.Y),
									_renderAngle, image_blend, 1);
	},
	Frame : function () {
		with (Box) draw_sprite_ext(	_sprFrame, image_index,
									_renderPos.X, _renderPos.Y, Scale.Outer(_renderSize.X), Scale.Outer(_renderSize.Y),
									_renderAngle, image_blend, 1);
	},
	Inner : function () {
		with (Box) draw_sprite_ext(	_sprInner, image_index,
									_renderPos.X, _renderPos.Y, Scale.Inner(_renderSize.X), Scale.Inner(_renderSize.Y),
									_renderAngle, image_blend, 1);
	}
};