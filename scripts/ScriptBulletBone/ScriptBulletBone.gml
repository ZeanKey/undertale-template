if (not variable_global_exists("__script_initialized")) then return true;

enum BONE_ORIGIN {
	CENTER,
	SIDE,
	FLIP_SIDE,
}
var Metatable;

Bullet.Bone = {};
Bullet.BoneWall = {};

#region Bone
var Bone = Bullet.Bone;
	
Bone.Configs = {};
Bone.Configs.Metatable = { Variables : { }, Events : { } };
Metatable = Bone.Configs.Metatable;

Bone.Configs.Regular = new BulletConfig(Metatable.Variables, Metatable.Events, Bullet.Configs.ColorCollision);

Bone.Create = function (paraX, paraY, paraConfig = -1) {
	var tmpInst = instance_create_depth(paraX, paraY, 0, bulletBone);
	if (is_instanceof(paraConfig, BulletConfig)) then paraConfig.ApplyOnBullet(tmpInst);
	tmpInst.Events.Create.Call(-1, tmpInst);
	return tmpInst;
};
Bone.CreateRegular = function (posX, posY, rot, length, mode = BULLET_TYPE.WHITE, origin = BONE_ORIGIN.CENTER, isOnBoard = true, config = -1) {
	var bone = global.Bullet.Bone.Create(posX, posY, new BulletConfig({
		Size : length,
		IsOnBoard : isOnBoard,
	}, {
		Create : new Event(method({ Origin: origin }, function (paraBullet) {
			paraBullet.SetOrigin(Origin);
		}))
	}, global.Bullet.Bone.Configs.Regular));
	bone.Mode = mode;
	bone.image_angle = rot;
	if (is_instanceof(config, BulletConfig)) then config.ApplyOnBullet(bone);
	return bone;
};

Bone.CreateCross = function (posX, posY, rot, length, num, mode = BULLET_TYPE.WHITE, isOnBoard = true, config = -1) {
	static _Config = new BulletConfig({
		IsOnBoard : true,
	}, {
		Step : new Event(function (inst) {
			array_foreach(inst.BoneList, method({ CrossBone: inst }, function (curBone, index) {
				curBone.Size = CrossBone.Length;
				curBone.Mode = CrossBone.Mode;
				curBone.image_angle = CrossBone.image_angle + curBone.__crossBoneIdx * CrossBone._deltaAngle;
				curBone.x = CrossBone.x;
				curBone.y = CrossBone.y;
				curBone.IsOnBoard = CrossBone.IsOnBoard;
			}));
		}),
		CleanUp : new Event(function (inst) {
			array_foreach(inst.BoneList, function (curBone, _) {
				instance_destroy(curBone);
			});
		}),
	});
	var bone = instance_create(posX, posY, bulletCustom);
	_Config.ApplyOnBullet(bone);
	if (config != -1) then config.ApplyOnBullet(bone);
	bone.BoneList = [];
	bone._deltaAngle = 180 / num;
	with (bone) {
		for (var i = 0; i < num; i ++) {
			var curBone = global.Bullet.Bone.CreateRegular(x, y, rot + i * _deltaAngle, length, mode, BONE_ORIGIN.CENTER, isOnBoard);
			curBone.__crossBoneIdx = i;
			array_push(bone.BoneList, curBone)
		}
	}
	bone.Length = length;
	bone.Mode = mode;
	bone.image_angle = rot;
	bone.IsOnBoard = isOnBoard;
	return bone;
}
#endregion

#region BoneWall
var BoneWall = Bullet.BoneWall;

BoneWall.PosConfigGenIter = function (posX, posY, length, rot = 0, align = 0, space = 18) {
	var result = [];
	var baseLn = [];
	var iterVec = global.Vector.Polar(rot, space);
	var curVec = new Vector2D(posX, posY);
	switch (align) {
		case 0:
		break;
		case 1:
		curVec.Add(global.Vector.Polar(rot, length / 2));	
		break;
		case 2:
		curVec.Add(global.Vector.Polar(rot, length));	
		break;
	}
	for (var xStart = 0; xStart <= length; xStart += space) {
		array_push(result, curVec.Value());
		curVec.Add(iterVec);
	}
	array_push(baseLn, array_first(result).Value());
	array_push(baseLn, array_last(result).Value());
	return {
		Pos : result,
		Rot : rot,
		BaseLn : baseLn,
	};
};
BoneWall.PosConfigGenFill = function (posX, posY, length, rot = 0, align = 0, space = 18) {
	var result = [];
	var baseLn = [];
	var iterVec = global.Vector.Polar(rot, space);
	var curVec = new Vector2D(posX, posY);
	var num = round(length / space)
	var numLen = num * space;
	
	switch (align) {
		case 0:
		break;
		case 1:
		curVec.Add(global.Vector.Polar(rot, -numLen / 2));	
		break;
		case 2:
		curVec.Add(global.Vector.Polar(rot, -numLen));	
		break;
	}
	for (var i = 0; i <= num; i ++) {
		array_push(result, curVec.Value());
		curVec.Add(iterVec);
	}
	array_push(baseLn, array_first(result).Value());
	array_push(baseLn, array_last(result).Value());
	return {
		Pos : result,
		Rot : rot,
		BaseLn : baseLn,
	};
}

BoneWall.Configs = {};
BoneWall.Configs.Metatable = { Variables : { }, Events : { } };
Metatable = BoneWall.Configs.Metatable;

BoneWall.Configs.Regular = new BulletConfig(Metatable.Variables, Metatable.Events, new BulletConfig({ }, {
		Create : new Event(function (inst) {
			with (inst) {
				WarningExpand = method(inst, function (warningTime, time, tween = 0, ease = 0) {
					var warningBox = instance_create(0, 0, bulletBoneWallWarningBox);
					warningBox.alarm[0] = warningTime;
					warningBox.Points = RectBox;
					var context = self;
					warningBox.FinFn = method({ Time : time, Tween : tween, Ease : ease , BoneWall : context}, function () {
						BoneWall.Expand(Time, Tween, Ease);
					});
				});
				Expand = method(inst, function (time, tween = 0, ease = 0) {
					array_foreach(PosConfig.Pos, method(self, function (pos, _) {
						var curBone = global.Bullet.Bone.CreateRegular(pos.X - lengthdir_x(7, image_angle), pos.Y - lengthdir_y(7, image_angle), image_angle, 0, Mode, BONE_ORIGIN.SIDE, IsOnBoard);
						array_push(BoneList, curBone);
					}));
					Anim_Target(id, "Length", LengthIdeal, time, tween, ease);
				});
				Collapse = method(inst, function (time, tween = 0, ease = 0) {
					AnimTarget(id, "Length", 0, time, tween, ease, 0, method(self, function () {
						instance_destroy();
					}));
				});
			}
		}),
		Step : new Event(function (inst) {
			array_foreach(inst.BoneList, method({ BoneWall: inst }, function (curBone, _) {
				curBone.Size = BoneWall.Length;
			}));
		}),
	}
));

BoneWall.Create = function (length, posConfig, dir, mode = BULLET_TYPE.WHITE, isOnBoard = true, config = -1) {
	var deltaVec = global.Vector.Polar(dir, length + 7);
	var inst = instance_create_depth(0, 0, 0, bulletBoneWall);
	inst.image_angle = dir;
	inst.PosConfig		= posConfig;
	inst.Length			= 0;
	inst.LengthIdeal	= length;
	inst.IsOnBoard		= isOnBoard;
	inst.RectBox		= [	posConfig.BaseLn[0], posConfig.BaseLn[1],
							posConfig.BaseLn[1].Value().Add(deltaVec),
							posConfig.BaseLn[0].Value().Add(deltaVec)];
	inst.Mode			= mode;
	if (is_instanceof(config, BulletConfig)) then config.ApplyOnBullet(inst);
	inst.Events.Create.Call(-1, inst);
	return inst;
};

BoneWall.CreateRegular = function (length, posConfig, dir, isOnBoard = true, config = -1) {
	var inst = global.Bullet.BoneWall.Create(length, posConfig, dir, isOnBoard, global.Bullet.BoneWall.Configs.Regular);
	if (is_instanceof(config, BulletConfig)) then config.ApplyOnBullet(inst);
	return inst;
}
#endregion

