#macro BULLET_CONFIG_VARIABLE	"__var_table",
#macro BULLET_CONFIG_EVENT		"__ev_table",

__script_initialized = true;

enum BULLET_TYPE {
	WHITE,
	BLUE,
	ORANGE,
}

function __default_render__() {
	draw_self();
}

/// @function			BulletConfig(*variable_table, *event_table, *parent_configs...)
/// @param	{Struct}	var_table
/// @param	{Struct}	ev_table
/// @return {Struct.BulletConfig}
function BulletConfig(paraVarTable = {}, paraEvTable = {}) constructor {
	__var_table = paraVarTable;
	__ev_table	= paraEvTable;
	if (argument_count > 2) {
		var curConfig;
		for (var i = 2; i < argument_count; i ++) {
			curConfig = argument[i];
			curConfig.ApplyOnConfig(self);
		}
	}
	Get = function (paraTableIndex, paraName) {
		return self[$ paraTableIndex][$ paraName];
	};
	Set = function (paraTableIndex, paraName, paraValue) {
		self[$ paraTableIndex][$ paraName] = paraValue;
	};
	Inherit = function (paraConfig) {
		paraConfig.ApplyOnConfig(self);
	};
	ApplyRaw = function (paraStructVars, paraStructEvs) {
		struct_foreach(__var_table, method({Table : paraStructVars}, function (_name, _value) {
			Table[$ _name] = _value;
		}));
		struct_foreach(__ev_table, method({Table : paraStructEvs}, function (_name, _value) {
			var tmpEv = Table[$ _name];
			if (tmpEv == undefined) {
				tmpEv = new Event();
				Table[$ _name] = tmpEv;
			}
			tmpEv.AddEvent(_value);
		}));
	};
	ApplyOnConfig = function (paraDest) {
		ApplyRaw(paraDest.__var_table, paraDest.__ev_table);
	};
	ApplyOnBullet = function (paraDest) {
		var tmpStruct = paraDest;
		if (not is_struct(paraDest)) {
			with (paraDest) {
				tmpStruct = self;
			}
		}
		ApplyRaw(tmpStruct, paraDest.Events);
	};
}

Bullet = {};

#region Configs
Bullet.Configs = {};
#region Config - Free when out of the room
var tmpVarTable = {
	__view_edge : 100,
	__view_free_enable : true,
	SetOutViewAutoFreeEnable : function(paraInst, paraEnable) {
		paraInst.__view_free_enable = paraEnable;
	},
};
var tmpEvTable	= {
	PreStep : new Event(),
}
tmpEvTable.PreStep.AddCallback(-1, function (paraBullet) {
	if (not __view_free_enable) then return false;
	
	var tmpEdge = paraBullet.__view_edge;
	if (clamp(paraBullet.x, -tmpEdge, room_width + tmpEdge) != paraBullet.x) {
		instance_destroy();
		return false;
	}
	if (clamp(paraBullet.y, -tmpEdge, room_height + tmpEdge) != paraBullet.y) {
		instance_destroy();
		return false;
	}
});
Bullet.Configs.OutViewFree = new BulletConfig(tmpVarTable, tmpEvTable);
#endregion

#region Config - Color bullet collision
var tmpVarTable = {
	Mode : BULLET_TYPE.WHITE,
};
var tmpEvTable	= {
	Collision	: new Event(),
	PreDraw 	: new Event(),
};
tmpEvTable.Collision.AddCallback(-1, function (paraBullet) {
	switch (paraBullet.Mode) {
		case BULLET_TYPE.WHITE:
			
		break;
		case BULLET_TYPE.BLUE:
		if (battleSoul.x != battleSoul.xprevious) || (battleSoul.y != battleSoul.yprevious) {
			
		}
		break;
		case BULLET_TYPE.ORANGE:
		if (battleSoul.x == battleSoul.xprevious) && (battleSoul.y == battleSoul.yprevious) {
			
		}
		break;
	}
});
tmpEvTable.PreDraw.AddCallback(-1, function (paraBullet) {
	with (paraBullet) {
		switch (paraBullet.Mode) {
			case BULLET_TYPE.WHITE:
			image_blend = UT_WHITE;
			break;
			case BULLET_TYPE.BLUE:
			image_blend = UT_BLUE;
			break;
			case BULLET_TYPE.ORANGE:
			image_blend = UT_ORANGE;
			break;
		}
	}
})
Bullet.Configs.ColorCollision = new BulletConfig(tmpVarTable, tmpEvTable);
#endregion

#endregion

#region Extensions
Bullet.Extensions = {};
Bullet.Extensions.Physics = {
	Apply : function (paraBullet) {
		paraBullet.__physics = {};
		var PHY = paraBullet.__physics;
		PHY.__force_collector = {
			__phy : PHY,
			__container : [],
			Add : function (paraVec) {
				array_push(__container, paraVec.Value());
				return (array_length(__container) - 1);
			},
			Remove : function (paraIndex) {
				__container[paraIndex] = global.Vector.Zero.Value();
			},
			Eval : function () {
				var tmpLen = array_length(__container);
				var tmpSum = new Vector2D(0, 0);
				var curForce;
				for (var i = 0; i < tmpLen; i ++) {
					curForce = __container[i];
					tmpSum.Add(curForce);
				}
				tmpSum.Div(__phy.__mass);
				__phy.__spdX += tmpSum.X;
				__phy.__spdY += tmpSum.Y;
				__container = [];
			},
		};
		PHY.__mass = 1;
		PHY.__spdX = 0;
		PHY.__spdY = 0;
		paraBullet.Events.EvUpdate.AddCallback(-1, method(paraBullet, function () {
			__physics.__force_collector.Eval();
		}));
	},
	Remove : function (paraBullet) {
		paraBullet.__physics = 0;
	},
};

#endregion

#region Prefabs
Bullet.Prefabs = {};

#endregion

ScriptBulletBone();
ScriptBulletBlaster();