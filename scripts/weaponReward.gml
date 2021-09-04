/// weaponReward(weapon)
// adds the given weapon to the list of rewards for the level

var obj; obj = argument0;

if (obj != noone)
{
    if (global.weaponLocked[getWeaponID(obj)])
    {
        arrayAppendUnique(global.levelReward, obj);
        setWeaponLocked(obj, false);
    }
}
