/// @desc Init
function Pack(paraDefault = undefined) constructor {
	_content = paraDefault;
	static Set = function (paraVal) {
		_content = paraVal;
	};
	static Value = function () {
		return _content;
	};
};

function EventPack(paraDefine = function () {}) : Pack() constructor {
	_define = paraDefine;
	Generate = function () {
		var ARG_ARR = [];
		for (var INDEX = 0; INDEX < argument_count; INDEX ++) {
			array_push(ARG_ARR, argument[INDEX]);
		}
		method_call(_define, array_concat([self], ARG_ARR));
	}
	static Method = Value;
}

Property = {
	Name	: "",
	Info	: "",
	Class	: 0
};

Events = {
	Use		: new EventPack(),
	Info	: new EventPack(),
	Drop	: new EventPack(),
}


