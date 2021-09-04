#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
/// An item that, upon touching, will unlock, lock, or force-set you to a specific weapon depending on what you set.
// The default is to unlock the weapon.

event_inherited();

grabable = 0;
heavy = 1;
respawnupondeath = 0;

// @cc the weapon object to lock on room start + unlock when touched
weapon = 0;

// @cc if this is set to true, the weapon will be locked instead of unlocked when obtained
lockWeapon = false;

// @cc if this is set to true, it'll lock you TO the weapon in this capsule (ala IC, Hardccore Parkour etc) instead of just unlocking it
lockToWeapon = false;

// @cc if this is true along with lockToWeapon, the buster will be locked along with all other weapons.
lockBuster = true;

// @cc if this is set to true, the unlocked weapon will also gain infinite energy
infiniteEnergy = false;

// @cc if this is set to true, will appear as a level reward at the end of the stage
levelReward = false;

//@cc destroy if already unlocked
destroyIfUnlocked = false;

// other variables
flashTimer = 0;
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();

if (destroyIfUnlocked && !global.weaponLocked[ds_map_get(global.weaponID,weapon)])
{
    instance_destroy();
}
#define Other_10
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
playSFX(sfxImportantItem);

weaponID = ds_map_get(global.weaponID,weapon);

if (levelReward)
{
    weaponReward(weapon);
}

// lock all weapons
if (lockToWeapon)
{
    for (i = 0; i <= global.totalWeapons; i += 1)
    {
        if ((i == 0 && lockBuster) || (i != 0))
        {
            global.weaponLocked[i] = true;
        }
    }
}

// unlock the capsule's weapon
global.weaponLocked[weaponID] = lockWeapon;

// set infinite energy
if (infiniteEnergy)
{
    global.infiniteEnergy[weaponID] = true;
}

// set players to use the weapon
with (objMegaman)
{
    global.weapon[playerID] = other.weaponID;
    playerPalette();
}

instance_destroy();
#define Draw_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
weaponID = ds_map_get(global.weaponID,weapon);


if (!dead)
{
    if (sprite_index == sprWeaponIconsMegaBuster)
    {
        var icon; icon = global.weaponIcon[weaponID];

        // original sprite
        draw_sprite_ext(icon, 0, x, y, image_xscale, image_yscale, image_angle, c_white, 1);

        if (!lockWeapon)
        {
            // whitemasks
            draw_sprite_ext(icon, 1, x, y, image_xscale, image_yscale, image_angle, global.weaponPrimaryColor[weaponID], 1);
            draw_sprite_ext(icon, 2, x, y, image_xscale, image_yscale, image_angle, global.weaponSecondaryColor[weaponID], 1);

            // extra
            draw_sprite_ext(icon, 3, x, y, image_xscale, image_yscale, image_angle, c_white, 1);
        }

        // flash if it's a locker
        if (lockToWeapon)
        {
            flashTimer+=1;

            if (flashTimer >= 30)
            {
                d3d_set_fog(true, c_white, 0, 0);
                drawSelf();
                d3d_set_fog(false, 0, 0, 0);

                if (flashTimer == 35)
                {
                    flashTimer = 0;
                }
            }
        }
    }
    else
    {
        drawSelf();
    }
}
