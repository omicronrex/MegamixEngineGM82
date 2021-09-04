#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
/// An elevator from MM7 Wily 4. If you're fully standing on it, you can press Up or Down to move it around.
event_inherited();

contactDamage = 0;
canHit = false;
isSolid = 1;
blockCollision = 0;
grav = 0;
bubbleTimer = -1;

shiftVisible = 1;

despawnRange = -1;
respawnRange = -1;

image_speed = 0;

// Enemy-specific variables
active = false;
dir = 0;
spd = 2;
deltaY = 0;
child = noone;

lockPool = -1;

// @cc the amount of blocks the elevator will go down every input
range = 64;

// @cc the coordinates of the upper boundary of the elevator's range (default starting position)
yMin = ystart;

// @cc the coordinates of the lower boundary of the elevator's range (default ystart plus 4 times its range ala MM7, this is set in the step event unless changed via creation code)
yMax = -1;

// @cc if false, this object's positon will not get reset upon leaving the screen
resetMe = true;
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();

if (!global.frozen && !dead && !global.timeStopped)
{
    if (child == noone)
    {
        child = instance_create(x, y, objControllableLiftOverlay);
        child.parent = id;
    }

    if (yMax == -1)
    {
        yMax = ystart + (range * 4);
    }
    if (!active)
    {
        with (objMegaman)
        {
            if (!playerIsLocked(PL_LOCK_MOVE) && ground)
            {
                if (place_meeting(other.x, other.y - gravDir, other.id)
                    && !place_meeting(x, y, other.id))
                {
                    if (global.keyUp[playerID] || global.keyDown[playerID])
                    {
                        with (other)
                        {
                            dir = (global.keyDown[other.playerID] - global.keyUp[other.playerID]);

                            // if its already at its max for that position...Dont
                            // OR! don't... if megaman isnt fully on the elevator
                            if ((dir == -1 && y <= yMin) || (dir == 1 && y >= yMax)
                                || (other.bbox_left < x) || (other.bbox_right + 1 > x + sprite_width))
                            {
                                exit;
                            }

                            other.xspeed = 0;
                            active = true;

                            // lock player movement
                            lockPool = lockPoolLock(
                                other.localPlayerLock[PL_LOCK_MOVE],
                                other.localPlayerLock[PL_LOCK_TURN],
                                other.localPlayerLock[PL_LOCK_SLIDE],
                                other.localPlayerLock[PL_LOCK_SHOOT],
                                other.localPlayerLock[PL_LOCK_JUMP],
                                other.localPlayerLock[PL_LOCK_CHARGE],
                                other.localPlayerLock[PL_LOCK_CLIMB],
                                other.localPlayerLock[PL_LOCK_GROUND]);
                        }
                    }
                }
            }
        }
    }
    else
    {
        yspeed = spd * dir;
        deltaY += spd;
        child.y = y;

        // stopping AI
        if ((dir == -1 && y + yspeed < yMin) || (dir == 1 && y + yspeed > yMax)
            || (deltaY >= range + spd))
        {
            // hitting max behavior only
            if ((dir == -1 && y + yspeed < yMin) || (dir == 1 && y + yspeed > yMax))
            {
                // back in bounds
                if (dir == -1)
                {
                    y = yMin;
                }
                else
                {
                    y = yMax;
                }
            }

            // stop
            yspeed = 0;
            lockPool = lockPoolRelease(lockPool);
            lockPool = -1;

            // reset
            if (!resetMe)
            {
                ystart = y;
            }
            dir = 0;
            active = false;
            deltaY = 0;
        }
    }
}
else if (dead)
{
    with (child)
    {
        instance_destroy();
    }
    child = noone;
    active = false;
    dir = 0;
    lockPool = -1;
    deltaY = 0;
}
