/// @function			Template(*variable_table, *event_table, *parent_configs...)
/// @param	{Struct}	var_table
/// @param	{Struct}	ev_table
/// @return {Struct.Template}
function Template(varTable = {}, evTable = {}) constructor {
	__var_table = varTable;
	__ev_table	= evTable;
	if (argument_count > 2) {
		var curConfig;
		for (var i = 2; i < argument_count; i ++) {
			curConfig = argument[i];
			curConfig.ImplOnTemplate(self);
		}
	}
	Get = function (idx, name) {
		return self[$ idx][$ name];
	};
	Set = function (idx, name, val) {
		self[$ idx][$ name] = val;
	};
	Inherit = function (tmpl) {
		tmpl.ImplOnTemplate(self);
	};
	ImplRaw = function (varTable, evTable) {
		struct_foreach(__var_table, method({ Table : varTable }, function (_name, _value) {
			Table[$ _name] = _value;
		}));
		struct_foreach(__ev_table, method({ Table : evTable }, function (_name, _value) {
			var tmpEv = Table[$ _name];
			if (tmpEv == undefined) {
				tmpEv = new Event();
				Table[$ _name] = tmpEv;
			}
			tmpEv.AddEvent(_value);
		}));
	};
	ImplOnTemplate = function (dest) {
		ImplRaw(dest.__var_table, dest.__ev_table);
	};
	ImplOnInst = function (dest) {
		var tmpStruct = dest;
		if (not is_struct(dest)) {
			with (dest) {
				tmpStruct = self;
			}
		}
		ImplRaw(tmpStruct, dest.Events);
	};
	Impl = function (dest) {
		if (is_instanceof(dest, Template)) {
			ImplOnTemplate(dest);
		}
		if (instance_exists(dest) and not is_struct(dest)) {
			if (dest.object_index == GMObject) {
				ImplOnInst(dest);
			}
		}
	}
}
