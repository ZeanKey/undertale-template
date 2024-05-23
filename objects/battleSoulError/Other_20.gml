_pointLocked = new Point(_lockedX, _lockedY, true);

_pointSoul = new Point(x, y, false);

ds_list_add(points, _pointLocked);
ds_list_add(points, _pointSoul);

_joint = new Joint(_pointSoul, _pointLocked, 15);

ds_list_add(joints, _joint);

