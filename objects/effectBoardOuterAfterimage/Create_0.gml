/// @desc
depth = DEPTH.BOARD + 1;
_parent = noone;
_imageLst = [];

CircleImageRenderInitialize = function () {
	self._renderXOffset = -_parent.image_xscale / 2;
	self._renderYOffset = -_parent.image_yscale / 2;
}

CircleImageRender = function () {
	var DES_LIST = [];
	var NO_OFFSET = 0;
	var CIRCLE = noone;
	for (var INDEX = 0; INDEX < array_length(_imageLst); INDEX ++) {
		CIRCLE = _imageLst[INDEX];
		CIRCLE.Update();
		if (CIRCLE._iAlpha == 0) {
			array_push(DES_LIST, INDEX);
			continue
		}
		else {
			CIRCLE.Render();
		}
	}
	
	for (var INDEX = 0; INDEX < array_length(DES_LIST); INDEX ++) {
		array_delete(DES_LIST, INDEX + NO_OFFSET, 1);
		NO_OFFSET --;
	}
}

function CircleImage(parent, effect) constructor {
	self._x = parent.x;
	self._y = parent.y;
	self._iScaleX = parent.image_xscale;
	self._iScaleY = parent.image_yscale;
	self._iAlpha = parent.image_alpha;
	self._parent = parent;
	self._effect = effect;
	
	array_push(effect._imageLst, self);
	
	self.Update = function () {
		self._iAlpha += _parent._afterimageDyingSpd;
		self._y += 10;
		
		if (self._iAlpha < 0) {
			self._iAlpha = 0;
		}
	};
	
	self.Render = function () {
		draw_set_alpha(self._iAlpha);
		draw_surface(_parent._surfBoard, self._x + _effect._renderXOffset, self._y + _effect._renderYOffset);
	};
}