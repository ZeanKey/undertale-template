function Inventory(paraLimit) constructor {
	_content = ds_list_create();
	GenSaveAccessor = {
		__inv : other,
		Set : function () {
			return method(__inv, function (paraList) {
				if (paraList != -1) {
					var tmpList = ds_list_create();
					ds_list_clear(_content)
					ds_list_read(tmpList, paraList);
					for (var i = 0; i < ds_list_size(tmpList); i ++) {
						Add(tmpList[| i]);
					}
					ds_list_destroy(tmpList);
				}
			});
		},
		Get : function () {
			return method(__inv, function () {
				var tmpVal;
				var tmpList = ds_list_create();
				for (var i = 0; i < ds_list_size(_content); i ++) {
					ds_list_add(tmpList, _content[| i].Index);
				}
				tmpVal = ds_list_write(tmpList);
				ds_list_destroy(tmpList);
				return tmpVal;
			});
		}
	};
	Limit = paraLimit;
	Add = function (paraItemIndex, paraPos = -1) {
		var POS = paraPos;
		var ITEM = WORLD_ITEM.Find(paraItemIndex);
		if (POS == -1) then POS = ds_list_size(_content);
		ds_list_insert(_content, POS, ITEM);
	};
	AddRaw = function (paraItem, paraPos = -1) {
		var POS = paraPos;
		if (POS == -1) then POS = ds_list_size(_content);
		ds_list_insert(_content, POS, paraItem);
	};
	Get = function (paraPos) {
		return _content[| paraPos];
	};
	Remove = function (paraPos) {
		ds_list_delete(_content, paraPos);
	};
	Size = function () {
		return ds_list_size(_content);
	};
	Copy = function () {
		var ARRAY = [];
		for (var INDEX = 0; INDEX < Size(); INDEX ++) {
			array_push(ARRAY, _content[| INDEX]);
		}
		return ARRAY;
	};
}

function GamePlayerCollectibleSlot() constructor{
    _item = undefined;
    Equip = function (paraItemIndex) {
        if (not is_undefined(_item)) then WORLD_PLAYER.Storage.Add(_item.Index);
		_item = WORLD_ITEM.Find(paraItemIndex);
    };
    Set = function (paraItemIndex) {
		_item = WORLD_ITEM.Find(paraItemIndex);
    };
    GetItemRef = function () {
        if (is_undefined(_item)) then return undefined;
        return _item;
    };
    GetItemIndex = function () {
        if (is_undefined(_item)) then return undefined;
        return _item.Index;
    };
    GetItemName = function () {
        if (is_undefined(_item)) then return undefined;
        return _item.Property.Name;
    };
};

function GamePlayer() constructor {
    Profile = {};
	with (Profile) {
	    Name    = "";
    	HP	    = 20;
    	MaxHP	= 20;
    	Atk		= 0;
    	Def		= 0;
    	Exp		= 0;
    	Lv		= 1;
    	Kills	= 0;
    	Gold	= 0;
	}
		
	Slots = {};
	Slots.Weapon = new GamePlayerCollectibleSlot();
	with (Slots.Weapon) {
	    GetValue = function () {
    		if (is_undefined(_content)) then return 0;
    		return _content.Property.ATK;
    	};
    	Attack = function (paraIndex) {
    		if (is_undefined(_content)) {
    			instance_create_depth(0, 0, 0, battleAttackNone).Index = paraIndex;
    		}
    		else {
    			_content.Use(paraIndex, 2);
    		}
	    };
	}
	Slots.Armor = new GamePlayerCollectibleSlot();
	with (Slots.Armor) {
	    GetValue = function () {
    		if (is_undefined(_content)) then return 0;
    		return _content.Property.DEF;
    	};
	}
	
	Storage = new Inventory(8);
	
	ReduceHP = function () {
	    
	};
	Die	= function () {
		
	};
};