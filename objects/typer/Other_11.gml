/// @desc Render
RenderEnable = true;

if (_charIndex == -1) then exit;

// Event call - Pre Render
Events.PreRender.Call(self);

// Main render
if (RenderEnable) {
	for (var INDEX = 0; INDEX < array_length(_textChars); INDEX ++) {
		_textChars[INDEX].Render();
	}
}

// Event call - Post Render
Events.PostRender.Call(self);


