#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();

contactDamage = 0;

type = 'coil';

dir = 1;

with (parent)
{
    other.dir = image_xscale;
}

despawnRange = -1;

canNeverLand = 0;

mySpeed = 8;

canHit = false;

teleportTimer = 0;
upordown = 'down';

alarm[0] = 1;

//Play correct sounds
if (global.teleportSound)
{
    warpInSFX = sfxTeleportInClassic;
    warpOutSFX = sfxTeleportOutClassic;
}
else
{
    warpInSFX = sfxTeleportIn;
    warpOutSFX = sfxTeleportOut;
}
#define Destroy_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();

with (objRushTeleportBlock)
{
    instance_destroy();
}
#define Alarm_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if (upordown == 'up')
{
    yspeed = 0;
}
else
{
    yspeed = mySpeed * image_yscale;

    with (parent)
    {
        var i = instance_create(x - 8 - 16, y, objRushTeleportBlock);
        i.image_xscale = 3;
        i.image_yscale = image_yscale;
    }
}
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();

if (!global.frozen)
{
    if ((yspeed > 0 && y > view_yview + view_hview)
        || (yspeed < 0 && y < view_yview))
    {
        despawnRange = 0;
    }

    if (yspeed != 0 && upordown == 'down')
    {
        if (type == 'jet')
        {
            if (instance_exists(parent))
            {
                with (objRushTeleportBlock)
                {
                    y = round(other.parent.y + 14 * other.image_yscale);
                }
            }
        }

        if (!canNeverLand)
        {
            if (place_meeting(x, y, objRushTeleportBlock))
            {
                if (!checkSolid(0, 0))
                {
                    if (type == 'jet')
                    {
                        yspeed = 0;
                        y = instance_place(x, y, objRushTeleportBlock).y;
                    }
                    else
                    {
                        blockCollision = 1;
                    }
                }
                else
                {
                    canNeverLand = 1;
                }
            }
        }
    }
    else
    {
        blockCollision = 0;

        if (upordown == 'down')
        {
            if (teleportTimer == 1)
            {
                image_index = 0;
                playSFX(warpInSFX);
            }
            if (teleportTimer == 3)
            {
                image_index = 1;
            }
            else if (teleportTimer == 6)
            {
                image_index = 0;
            }
            else if (teleportTimer == 9)
            {
                image_index = 2;
            }
            else if (teleportTimer == 13)
            {
                i = 0;
                global.playerProjectileCreator = parent;
                if (type == 'jet')
                {
                    i = instance_create(x, y - 16 * image_yscale, objRushJet);
                }
                if (type == 'coil')
                {
                    i = instance_create(x, y, objRushCoil);
                }
                if (type == 'cycle')
                {
                    i = instance_create(x, y, objRushCycle);
                }
                if (type == 'sakugarne')
                {
                    i = instance_create(x, y - 16 * image_yscale, objSakugarne);
                }
                if (i)
                {
                    i.image_xscale = dir;
                    i.image_yscale = image_yscale;
                    i.grav *= sign(image_yscale);
                    i.parent = parent;
                }
                instance_destroy();
            }
        }
        else
        {
            if (teleportTimer == 0)
            {
                image_index = 2;
                playSFX(warpOutSFX);
            }
            if (teleportTimer == 3)
            {
                image_index = 0;
            }
            else if (teleportTimer == 6)
            {
                image_index = 1;
            }
            else if (teleportTimer == 9)
            {
                image_index = 0;
            }
            else if (teleportTimer == 13)
            {
                yspeed = -mySpeed * image_yscale;
            }
        }
        teleportTimer += 1;
    }
}

if (global.teleportSound)
{
    warpInSFX = sfxTeleportInClassic;
    warpOutSFX = sfxTeleportOutClassic;
}
else
{
    warpInSFX = sfxTeleportIn;
    warpOutSFX = sfxTeleportOut;
}
