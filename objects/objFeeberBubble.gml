#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();

healthpointsStart = 4;
healthpoints = healthpointsStart;

itemDrop = -1;
category = "aquatic";

imgIndex = 0;
damage = false;

myLock = 0;

parent = noone;
animBack = false;
image_speed = 0.1;
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();

if (entityCanStep())
{
    if (instance_exists(target))
    {
        if (collision_rectangle(x - 12, y - 24, x + 12, y, target, false, true))
        {
            target.x = x;
            target.y = y - (sprite_height/2) - 4;
            if (myLock == 0)
            {
                myLock = lockPoolLock(global.playerLock[PL_LOCK_SHOOT],
                    global.playerLock[PL_LOCK_CLIMB],
                    global.playerLock[PL_LOCK_CHARGE]);
            }

            if ((global.keyJumpPressed[target.playerID]) && (!damage)
                || (global.keyShootPressed[target.playerID]) && (!damage)
                || (global.keySlidePressed[target.playerID]) && (target.ground) && (!damage))
            {
                event_user(EV_HURT);
                healthpoints--;
                damage = true;
            }
            else
            {
                damage = false;
            }

            if (healthpoints <= 0)
            {
                dead = true;
                event_user(EV_DEATH);
            }
        }
    }

    // Turn around when hitting wall
    if (xcoll != 0)
    {
        image_xscale *= -1;
    }

    // Stop moving when falling
    if (!ground)
    {
        xspeed = 0;
    }
    else
    {
        xspeed = 1 * image_xscale;
    }

    // Animation
    if (animBack == false)
    {
        imgIndex += image_speed;
        if (imgIndex >= 4)
        {
            animBack = true;
            imgIndex = 3;
        }
    }
    else
    {
        imgIndex -= image_speed;
        if (imgIndex == 1)
        {
            animBack = false;
            imgIndex = 2;
        }
    }
}
else if (dead)
{
    lockPoolRelease(myLock);
    instance_destroy();
}
image_index = imgIndex div 1;
