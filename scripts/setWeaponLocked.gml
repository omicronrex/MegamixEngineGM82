/// setWeaponLocked(object, [locked?])
// object: which weapon object to set locked/unlocked
// locked? whether to lock (default, true) or unlock (false), or hidden (2)

var obj; obj = argument[0];
var locked; locked = true;
if (argument_count > 1)
{
    locked = argument[1];
}

var wasHidden; wasHidden = global.weaponLocked[ds_map_get(global.weaponID,obj)] == 2;

global.weaponLocked[ds_map_get(global.weaponID,obj)] = locked;

// sort freshly unlocked hidden weapons to bottom of hotbar
if (wasHidden)
{
    var found; found = false;
    var i; for (i = 0; i < global.totalWeapons; i+=1)
    {
        if (i == ds_map_get(global.weaponID,obj))
        {
            found = true;
        }
        if (found)
        {
            swap(global.weaponHotbar, i, i + 1);
        }
    }
}
