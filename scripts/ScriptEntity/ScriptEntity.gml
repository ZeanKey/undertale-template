function EntitySpriteRenderer(paraX, paraY, paraSprite, paraIndex, paraScale, paraOffset, paraAngle) constructor {
	_sprite = paraSprite;
	_index	= paraIndex;
	_scale	= paraScale;
	_posX	= paraX;
	_posY	= paraY;
	_offset = paraOffset;
	_angle	= paraAngle;
	Render = function () {
		draw_sprite_ext(_sprite, _index,
				_posX + _offset.X,
				_posY +	_offset.Y,
				_scale.X, _scale.Y,
				_angle, -1, 1);
	};
}

function EntityFrame(paraIndex, paraScale, paraOffset, paraAngle) constructor {
	Index	= paraIndex;
	Scale	= paraScale;
	Offset	= paraOffset;
	Angle	= paraAngle;
}

function EntityAnimation(paraName, paraSprite, paraSize, paraPlayMode) constructor{
	static FRAME_DEFAULT = new EntityFrame(0, new Vector2D(0, 0), new Vector2D(0, 0), 0);
	_frames	= array_create(paraSize, -1);
	CurFrame		= FRAME_DEFAULT;
	FrameIndex		= 0;
	FrameDefault	= FRAME_DEFAULT;
	
	IsOneShotFinished = false;
	
	Name	= paraName;
	Sprite	= paraSprite;
	Size	= paraSize;
	SeqMode = paraPlayMode;
	SeqDir	= 1;
	
	Reset = function () {
		SeqDir = 1;
		FrameIndex = 0;
		CurFrame = FrameDefault;
		IsOneShotFinished = false;
	};
	Render = function (paraX, paraY) {
		draw_sprite_ext(Sprite, CurFrame.Index,
						paraX + CurFrame.Offset.X,
						paraY + CurFrame.Offset.Y,
						CurFrame.Scale.X, CurFrame.Scale.Y,
						CurFrame.Angle, -1, 1);
	};
	AddFrame = function (paraIndex, paraFrame) {
		if (is_instanceof(paraFrame, EntityFrame)) {
			if (paraIndex < Size) {
				_frames[paraIndex] = paraFrame;
			}
		}
	};
	SetDefaultFrame = function (paraFrame) {
		if (is_instanceof(paraFrame, EntityFrame)) {
			FrameDefault = paraFrame
		}
	};
	Step = function () {
		FrameIndex += SeqDir;
		switch (SeqMode) {
			case seqplay_oneshot:
			if (FrameIndex >= Size - 1) {
				FrameIndex = Size - 1;
				SeqDir = 0;
				IsOneShotFinished = true;
			}
			break;
			case seqplay_loop:
			if (FrameIndex >= Size) {
				FrameIndex = 0;
			}
			break;
			case seqplay_pingpong:
			if (FrameIndex >= Size - 1) {
				FrameIndex = Size - 1;
				SeqDir *= -1;
			}
			else if (FrameIndex <= 0) {
				FrameIndex = 0;
				SeqDir *= -1;
			}
			break;
		}
		var FRAME_GET = _frames[FrameIndex];
		if (FRAME_GET != -1) {
			CurFrame = FRAME_GET;
		}
	};
}

function EntitySprite() constructor {
	_anims = {};
	
	DefaultAnim = -1;
	CurAnim = -1;
	
	GetAnim = function (paraName) {
		if (variable_struct_exists(_anims, paraName)) {
			return variable_struct_get(_anims, paraName);
		}
		return false;
	};
	GetCurrentAnim = function () {
		if (CurAnim == -1) {
			if (is_struct(DefaultAnim) && is_instanceof(DefaultAnim, EntityAnimation)) {
				return DefaultAnim;
			}
			return -1;
		}
		return CurAnim;
	};
	AddAnim = function (paraAnim) {
		if (is_instanceof(paraAnim, EntityAnimation)) {
			variable_struct_set(_anims, paraAnim.Name, paraAnim);
		}
	};
	SetDefaultAnim = function (anmName) {
		var anmGet = GetAnim(anmName);
		if (anmGet != false) {
			DefaultAnim = anmGet;
		}
		return anmGet;
	}
	GetCurrentSprite = function () {
		if (is_struct(CurAnim) && is_instanceof(CurAnim, EntityAnimation)) {
			return CurAnim.Sprite;
		}
		return sprDefault;
	};
	GetCurrentSpriteRenderer = function (paraX, paraY) {
		var tmpAnim = CurAnim;
		var tmpFrame  = tmpAnim.CurFrame;
		return (new EntitySpriteRenderer(paraX, paraY, tmpAnim.Sprite, tmpFrame.Index, tmpFrame.Scale, tmpFrame.Offset, tmpFrame.Angle));
	};
	Update = function () {
		var anmGet = GetCurrentAnim()
		if (anmGet != -1) {
			anmGet.Step();
			if (anmGet.SeqMode == seqplay_oneshot && anmGet.IsOneShotFinished) {
				PlayDefaultAnim(true);
			}
		}
	};
	Render = function (paraX, paraY) {
		var anmGet = GetCurrentAnim()
		if (anmGet != -1) {
			anmGet.Render(paraX, paraY);
		}
	};
	Play = function(paraName, paraFresh = false) {
		var ANIM_GET = GetAnim(paraName);
		if (ANIM_GET != false) {
			if (not paraFresh) {
				var curAnim = GetCurrentAnim();
				if (curAnim != -1) {
					if (paraName == curAnim.Name) {
						return false;
					}
				}
			}
			CurAnim = ANIM_GET;
			ANIM_GET.Reset();
		}
	};
	PlayDefaultAnim = function (forceFresh = false) {
		if (DefaultAnim != -1) {
			if (not forceFresh) {
				var curAnim = GetCurrentAnim();
				if (curAnim != -1) {
					if (paraName == curAnim.Name) {
						return false;
					}
				}
			}
			CurAnim = DefaultAnim;
			DefaultAnim.Reset();
		}
	};
}
