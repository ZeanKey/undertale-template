/// @desc
__save = NULL_SAVE;
__slot = -1;


__callbacks = {};

_TextToStruct = function (paraFName) {
	var tmpFile = file_text_open_read(paraFName);
	var tmpStrGet = "";
	while (not file_text_eof(tmpFile)) {
		tmpStrGet += file_text_readln(tmpFile);
	}
	var tmpStruct = json_parse(tmpStrGet);
	file_text_close(tmpFile);
	return tmpStruct;
};

_GetFileName = function (paraSlot) {
	return $"{SAVE_FILE_PREFIX}{paraSlot}{SAVE_FILE_POSTFIX}";
};

Bind = function (paraKey, paraType, paraSave, paraLoad) {
	__callbacks[$ paraKey] = {
		Type : paraType,
		Save : paraSave,
		Load : paraLoad,
	};
};

Init = function () {
	var tmpConfig = _TextToStruct("save_config.json");
	global.__save_template = tmpConfig;
	__callbacks = {};
};

ReIn = function () {
	__save = NULL_SAVE;
	__slot = -1;
};

Exists = function (paraSlot) {
	var tmpFName = _GetFileName(paraSlot);
	if (not file_exists(tmpFName)) {
		return false;
	}
	var tmpSave = _TextToStruct(tmpFName);
	if (not bool(tmpSave[$ "IsValid"] ?? false)) {
		return false;
	}
	return true;
};

IsLoaded = function () {
	return (__slot != -1);
};

Load = function (paraSlot) {
	if (not Exists(paraSlot)) {
		return false;
	}
	
	var tmpFName = _GetFileName(paraSlot);
	
	__save = _TextToStruct(tmpFName);
	__slot = paraSlot;
	
	struct_foreach(__callbacks, function (curKey, curBundle) {
		var curData, curType;
		curType = curBundle.Type;
		if (curType == DATA_TYPE.VAL) {
			curData = __save[$ curKey];
		}
		else if (curType == DATA_TYPE.STRUCT) {
			curData = json_parse(__save[$ curKey]);
		}
		
		curBundle.Load(curData);
	});
	
	return true;
};

Save = function () {
	if (IsLoaded()) {
		struct_foreach(__callbacks, function (curKey, curBundle) {
			var curData, curType;
			curType = curBundle.Type;
			var curData = curBundle.Save();
			
			if (curType == DATA_TYPE.VAL) {
				__save[$ curKey] = curData;
			}
			else if (curType == DATA_TYPE.STRUCT) {
				__save[$ curKey] = json_stringify(curData, true);
			}
		});
	
		var tmpFName = _GetFileName(__slot);
		var tmpSave = file_text_open_write(tmpFName);
		var tmpContent = json_stringify(__save, true);
		file_text_write_string(tmpSave, tmpContent);
		file_text_close(tmpSave);
		return true;
	}
	return false;
};

New = function (paraSlot) {
	var tmpFName = _GetFileName(paraSlot);
	var tmpSave = file_text_open_write(tmpFName);
	file_text_write_string(tmpSave, json_stringify(global.__save_template, true));
	file_text_close(tmpSave);
	return true;
}

Delete = function (paraSlot) {
	if (Exists(paraSlot)) {
		var tmpFName = _GetFileName(paraSlot);
		var tmpSave = file_text_open_write(tmpFName);
		file_text_write_string(tmpSave, "");
		file_text_close(tmpSave);
		return true;
	}
	return false;
};





