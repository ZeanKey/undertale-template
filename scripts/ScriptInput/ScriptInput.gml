enum INPUT {
	NULL,
	CONFIRM,
	CANCEL,
	MENU,
	UP,
	DOWN,
	LEFT,
	RIGHT
}

function __InputAction() constructor {
	__events = {
		Pressed		: new Event(),
		Activated	: new Event(),
		Released	: new Event(),
	};
	__triggerCollector = false;
	BindKey = function (paraKey) {
		__events.Pressed.AddCallback(method({Action : self, Key : paraKey}, function () {
			if (keyboard_check_pressed(Key)) {
				Action.__triggerCollector = true;
			}
		}));
		__events.Activated.AddCallback(method({Action : self, Key : paraKey}, function () {
			if (keyboard_check(Key)) {
				Action.__triggerCollector = true;
			}
		}));
		__events.Released.AddCallback(method({Action : self, Key : paraKey}, function () {
			if (keyboard_check_released(Key)) {
				Action.__triggerCollector = true;
			}
		}));
	};
	IsPressed = function () {
		__triggerCollector = false;
		__events.Pressed.Call();
	};
	IsActivated = function () {
		__triggerCollector = false;
		__events.Activated.Call();
	};
	IsReleased = function () {
		__triggerCollector = false;
		__events.Released.Call();
	};
}

Input = {
	__actions : {},
};

Input.Define = function (paraIndex) {
	Input.__actions[$ paraIndex] = new __InputAction();
};
Input.Action = function (paraIndex) {
	return Input.__actions[$ paraIndex];
}