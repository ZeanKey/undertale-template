/// @desc Destroy
event_inherited();
if (_resumenable) {
	entityPlayer.IsUICaptured = false;
	entityPlayer.Movenable.Set("UI", true);
}
ds_map_destroy(_textbase);