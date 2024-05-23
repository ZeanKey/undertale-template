/// @desc Init
enum INST_TYPE
{
	GLOBAL,
	INSTANCE,
	STRUCT,
	INVALID
}

_funcPack = -1;
_counter = 0;
_arrArgs = [];

_inst = noone;
_varName = "";

function IsValid(paraInst, paraVarName)
{
	var RESULT = INST_TYPE.INVALID;
	
	if paraInst == global
	{
		if variable_global_exists(paraVarName)
		{
			RESULT = INST_TYPE.GLOBAL;
		}
	}
	else if instance_exists(paraInst)
	{
		if variable_instance_exists(paraInst, paraVarName)
		{
			RESULT = INST_TYPE.INSTANCE;
		}
	}
	else if variable_struct_exists(paraInst, paraVarName)
	{
		//RESULT = INST_TYPE.STRUCT;
	}
	
	return RESULT;
}
