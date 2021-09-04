/// getRoom(name, [external location], [hash])
// retrives the room of the given name, loading it externally
// if the room doesn't exist.
// returns -1 if failed to retrieve the room.

var roomInternalName; roomInternalName = argument[0];
assert(is_string(roomInternalName), "getRoom must be supplied with the internal room name as a string");

asset=execute_string("return "+roomInternalName)

if (room_exists(asset)) if (room_get_name(asset)==roomInternalName) return asset

show_error("invalid room name: "+roomInternalName,1)
return noone
