/// @desc
// Start
// Get the type of the instance
var TYPE = IsValid(_inst, _varName);

if TYPE == INST_TYPE.INVALID or _funcPack == -1
{
	instance_destroy();
	exit;
}

// Get the value of the function
var VAL = (_funcPack[0])(_counter, _arrArgs);

// Set the value to the target
if TYPE == INST_TYPE.INSTANCE
{
	if (not instance_exists(_inst)) {
		instance_destroy();
		exit;
	}
	variable_instance_set(_inst, _varName, VAL);
}
else if TYPE == INST_TYPE.STRUCT
{
	variable_struct_set(_inst, _varName, VAL);
}
else if TYPE == INST_TYPE.GLOBAL
{
	variable_global_set(_varName, VAL);
}

// End
if _funcPack[1] != TIME_LIMIT.CONTINUOUS
{
	if _counter >= _funcPack[1]
	{
		instance_destroy();
	}
}

_counter ++;