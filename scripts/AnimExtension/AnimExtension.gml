#macro LINEAR_FUNCTION global.func_linear
#macro SINE_FUNCTION global.func_sine_ext
#macro COSINE_FUNCTION global.func_cosine_ext

enum TIME_LIMIT
{
	CONTINUOUS = -1
}

function variable_get_general(paraTarget, paraVarName)
{
	var RESULT = undefined;
	
	if variable_struct_exists(paraTarget, paraVarName)
	{
		RESULT = variable_struct_get(paraTarget, paraVarName);
	}
	else if instance_exists(paraTarget)
	{
		if variable_instance_exists(paraTarget, paraVarName)
		{
			RESULT = variable_instance_get(paraTarget, paraVarName);
		}	
	}
	else if paraTarget == global
	{
		if variable_global_exists(paraVarName)
		{
			RESULT = variable_global_get(paraVarName);
		}
	}
	
	return RESULT;
}

function animexecutor_create_sine(paraTarget, paraVarName, paraDelta, paraTime) {
	var ARG_K = paraDelta;
	var ARG_X = pi / paraTime;
	var ARG_B = variable_get_general(paraTarget, paraVarName);
	
	var ARGS = [ARG_K, ARG_B, ARG_X];
	
	animexecutor_create(paraTarget, paraVarName, SINE_FUNCTION, ARGS, paraTime);
}

function animexecutor_create(paraTarget, paraVarName, paraFunc, paraArgs, paraTimeLimit) {
	var FUNC_PACK	= [paraFunc, paraTimeLimit];
	var EXECUTOR	= instance_create_depth(0, 0, 0, animExecutor);
	
	with EXECUTOR {
		_funcPack	= FUNC_PACK;
		_arrArgs	= paraArgs;
		_inst		= paraTarget;
		_varName	= paraVarName;
	}
	
	return EXECUTOR;
}

function animexecutor_remove(paraTarget, paraVarName, paraFunc = -1, paraArgs = -1)
{
	with animExecutor {
		if _inst == paraTarget
		{
			if _varName == paraVarName
			{
				if paraFunc == -1
				{
					instance_destroy();
				}
				else if _funcPack[0] == paraFunc
				{
					if paraArgs == -1
					{
						instance_destroy();
					}
					else if array_equals(paraArgs, _arrArgs)
					{
						
						instance_destroy();
					}
				}
			}
		}
	}
}