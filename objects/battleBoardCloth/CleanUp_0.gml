ds_list_destroy(points);
ds_list_destroy(joints);

if surface_exists(_surfBox)
{
	surface_free(_surfBox);
}