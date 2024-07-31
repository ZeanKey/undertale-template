/// @desc Destroy Frame
if (surface_exists(BoardSurface))
	surface_free(BoardSurface);
if (surface_exists(BoxSpace))
	surface_free(BoxSpace);
vertex_delete_buffer(ModelBuffer);
vertex_delete_buffer(ModelAxisLineBuffer);
vertex_delete_buffer(ModelLayer);

