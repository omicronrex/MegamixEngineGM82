#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
// Note: if the block leftmost block has a different sprite_index, then all the falling blocks next to it will have the same sprite.

event_inherited();

contactDamage = 0;
canHit = false;

isSolid = 2;

blockCollision = 0;
grav = 0;
bubbleTimer = -1;

respawn = true;

wait = 30;
startWait = wait;

active = false;
count = 1;

shiftVisible = 1;

if (!place_meeting(x - 1, y, objFallingPlatform))
{
    while (instance_place(x + 16 * count, y, objFallingPlatform))
    {
        i = instance_place(x + 16 * count, y, objFallingPlatform);
        i.sprite_index = sprite_index;
        count += 1;
    }
}
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();

if (!global.frozen && !dead && !global.timeStopped)
{
    if (active)
    {
        if (wait <= 0)
        {
            yspeed = abs(yspeed);
            grav = gravAccel;
            yspeed *= dir;
        }
        else
        {
            wait -= 1;
        }
    }
    else
    {
        with (objMegaman)
        {
            if (ground)
            {
                if (place_meeting(x, y + gravDir, other.id)
                    && !place_meeting(x, y, other.id))
                {
                    other.active = true;
                    other.dir = gravDir;
                }
            }
        }
    }
}
else if (dead)
{
    wait = startWait;
    active = false;
    count = 1;
    grav = 0;
}
