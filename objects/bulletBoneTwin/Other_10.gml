///@desc Spawn Bone
_boneLst[0] = boneCreate(_attPos[0], _attPos[1], _attCol, _attDir, _attLen, _attTime); 
_boneLst[1] = boneCreate(_attPos[0], _attPos[1], _attCol, _attDir, _attLen, _attTime); 

_boneLst[0]._isBoneOut = true;
_boneLst[1]._isBoneOut = true;
_boneLst[0]._isBoneAutoDestroy = true;
_boneLst[1]._isBoneAutoDestroy = true;
_boneHasSpawned = true;