/// @desc Cache Init
function Button(paraX, paraY, paraPos, paraObject) constructor{
	_x = paraX;
	_y = paraY;
	_pos = paraPos;
	_object = paraObject;
	Create = function () {
		return instance_create_depth(_x, _y, DEPTH.UI_HIGH, _object);
	};
}

function Enemy(paraX, paraY, paraPos, paraObject) constructor{
	_x = paraX;
	_y = paraY;
	_pos = paraPos;
	_object = paraObject;
	Create = function () {
		return instance_create_depth(_x, _y, DEPTH.ENEMY, _object);
	};
}

function Callline(paraName, paraCall) constructor {
	Call = paraCall;
	IsEnable = true;
}

Cache = {
	Encounter  : id,
	TurnObject : undefined,
	DialogText : "",
	Update : function (paraEncounterCache) {
		with (Encounter) event_user(paraEncounterCache);
	}
};

Buttons = {
	_content : [],
	Define : function (paraX, paraY, paraPos, paraObject) {
		array_push(_content, new encounter.Button(paraX, paraY, paraPos, paraObject));
	},
	Generate : function () {
		var CUR_BUTTON;
		for (var INDEX = 0; INDEX < array_length(_content); INDEX ++) {
			CUR_BUTTON = _content[INDEX];
			battle.Buttons.Add(CUR_BUTTON.Create(), CUR_BUTTON._pos);
		}
	},
	Free : function () {
		for (var INDEX = 0; INDEX < array_length(_content); INDEX ++) {
			delete _content[INDEX];
			array_delete(_content, INDEX, 1);
			INDEX --;
		}
	},
};

Enemies = {
	_content : [],
	Define : function (paraX, paraY, paraPos, paraObject) {
		array_push(_content, new encounter.Enemy(paraX, paraY, paraPos, paraObject));
	},
	Generate : function () {
		var CUR_ENEMY;
		for (var INDEX = 0; INDEX < array_length(_content); INDEX ++) {
			CUR_ENEMY = _content[INDEX];
			battle.Enemies.Add(CUR_ENEMY.Create(), CUR_ENEMY._pos);
		}
	},
	Free : function () {
		for (var INDEX = 0; INDEX < array_length(_content); INDEX ++) {
			delete _content[INDEX];
			array_delete(_content, INDEX, 1);
			INDEX --;
		}
	},
};

Mercy = {
	Color : "{Color Yellow}",
	Events : {
		_content	: ds_map_create(),
		_order		: ds_list_create(),
		Add : function (paraName, paraCall = function () {}, paraPos = ds_map_size(_content)) {
			ds_map_add(_content, paraName, new encounter.Callline(paraName, paraCall));
			ds_list_insert(_order, paraPos, paraName);
		},
		Call : function (paraName) {
			ds_map_find_value(_content, paraName).Call();
		},
		GetNames : function () {
			return _order;
		}
	},
	Free : function () {
		ds_map_destroy(Events._content);
		ds_list_destroy(Events._order);
	}
};

TyperPosition = {
	Space	: 0,
	Dialog	: new Vector2D(0, 0),
	Bar		: new Vector2D(0, 0),
	Page	: new Vector2D(0, 0)
};