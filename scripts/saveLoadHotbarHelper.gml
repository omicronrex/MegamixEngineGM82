/// save/load weapon hotbar configuration

var i; for ( i = 1; i <= global.totalWeapons; i+=1)
{
    var weapon_name; weapon_name = object_get_name(global.weaponObject[global.weaponHotbar[i]]);
    weapon_name = sl(weapon_name, "HOTBAR_" + string(i));
    var asset_index; asset_index = asset_get_index(weapon_name);

    // validate input
    if (object_exists(asset_index))
    {
        if (object_get_parent(asset_index) == prtPlayerProjectile)
        {
            global.weaponHotbar[i] = ds_map_get(global.weaponID,asset_index);
            continue;
        }
    }

    global.weaponHotbar[i] = -1;
}

// sanitize -=1 ensures all weapons appear exactly once in weapon hotbar

// remove duplicates:
var i; for ( i = 1; i <= global.totalWeapons; i+=1)
{
    // replace undefined values with a proper missing entry
    if (is_undefined(global.weaponHotbar[i]))
        global.weaponHotbar[i] = -1;

    // skip missing values for now:
    if (global.weaponHotbar[i] == -1)
        continue;

    // check if this is first appearance:
    if (indexOf(global.weaponHotbar, global.weaponHotbar[i]) != i)
    {
        show_debug_message("Hotbar duplicate found @" + string(i));
        var j; for ( j = i; j < global.totalWeapons; j+=1)
        {
            global.weaponHotbar[j] = global.weaponHotbar[j + 1];
        }
        global.weaponHotbar[global.totalWeapons] = -1;
        i-=1;
    }
}

// add missing weapons:
var i; for ( i = 0; i <= global.totalWeapons; i+=1)
{
    if (indexOf(global.weaponHotbar, i) == -1)
    {
        show_debug_message("No hotbar entry found for " + string(i));
        global.weaponHotbar[indexOf(global.weaponHotbar, -1)] = i;
    }
}
