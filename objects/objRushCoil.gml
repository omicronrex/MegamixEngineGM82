#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();

contactDamage = 0;

canHit = false;

image_speed = 7 / 60;

blockCollision = 1;
grav = gravAccel;
bubbleTimer = 0;

timer = 4 * 60;
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();

if (!global.frozen)
{
    if (sprite_index == sprRush)
    {
        with (prtEntity)
        {
            if (dead)
            {
                continue;
            }

            if (global.factionStance[other.faction, faction])
            {
                continue;
            }

            if (grav == 0)
            {
                continue;
            }

            if (yspeed * other.image_yscale > 0)
            {
                if (blockCollision)
                {
                    if (faction != 0)
                    {
                        if (place_meeting(x, y, other))
                        {
                            if (!place_meeting(x, y - yspeed, other))
                            {
                                with (other)
                                {
                                    if (parent == other)
                                    {
                                        global.ammo[playerID, global.weapon[playerID]] = max(0, global.ammo[playerID, global.weapon[playerID]] - 2 / (global.energySaver + 1));
                                        other.canMinJump = false;
                                        other.climbing = 0;
                                        other.yspeed = -7.5 * image_yscale;
                                    }
                                    else
                                    {
                                        other.yspeed = -5 * image_yscale;
                                    }

                                    sprite_index = sprRushCoil;
                                    timer = 60;
                                }
                            }
                        }
                    }
                }
            }
        }
    }

    if (!ground)
    {
        timer = 1;
    }

    if (timer)
    {
        timer--;
        if (!timer)
        {
            // Teleport away
            i = instance_create(x, y, objRushTeleport);
            i.upordown = 'up';
            i.parent = parent;
            i.image_yscale = image_yscale;

            canCoil = false;
            instance_destroy();
        }
    }
}
#define Other_22
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
weaponSetup("RUSH COIL", -2, -2, sprWeaponIconsRushCoil);
#define Other_24
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if (global.keyShootPressed[playerID] && !playerIsLocked(PL_LOCK_SHOOT))
{
    if (!instance_exists(objRushCoil) && !instance_exists(objRushTeleport)
    && global.ammo[playerID, global.weapon[playerID]] > 0)
    {
        i = fireWeapon(26, 0, objRushTeleport, 4, 0, 0, 0);
        with (i)
        {
            type = 'coil';
            y = view_yview;
            if (image_yscale < 0)
            {
                y += view_hview;
            }
        }
    }
    else
    {
        i = fireWeapon(16, 0, objBusterShot, 4, 0, 1, 0);
        if (i)
        {
            i.xspeed = image_xscale * 5; // zoom
        }
    }
}
#define Draw_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
// set proper image to use
if (sprite_index == sprRush)
{
    ximg = 15 + image_index;
}
else
{
    ximg = 17;
}

drawPlayer(0, costumeID, ximg, 8, x, y - 16 * image_yscale, image_xscale, image_yscale);
