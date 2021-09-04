#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();
canHit = false;

isSolid = 1;

phase = 1;
timer = 0;
canFall = false;
fallTimer = 60;

shiftVisible = 1;

blockCollision = 0;
grav = 0;
bubbleTimer = -1;
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();

if (!global.frozen && !dead && !global.timeStopped)
{
    switch (phase)
    {
        case 1: // Checks for Mega Man
            ys = y;
            yspeed = 1;
            blockCollision = 0;
            y = ys;
            if (yspeed != 0)
            {
                with (target)
                {
                    if (gravDir == 1 && ground)
                    {
                        if (place_meeting(x, y + gravDir, other.id))
                        {
                            other.phase = 2;
                            other.getY = other.y + 16;
                            other.xs = other.x;
                            other.xspeed = 1;
                        }
                    }
                }
                yspeed = 0;
            }
            break;
        case 2: // shake
            timer += 1;
            blockCollision = 0;
            if (sign(x - xs) == sign(xspeed))
            {
                xspeed = -xspeed;
            }
            if (timer > fallTimer)
            {
                if (x == xs)
                {
                    phase = 3;
                    timer = 0;
                    xspeed = 0;
                }
            }
            break;
        case 3: // Sink
            yspeed = min(2.65, getY - y);
            blockCollision = 0;
            if (y == getY)
            {
                yspeed = 0;
                phase = 1;
            }
            break;
    }
}
else if (dead)
{
    phase = 1;
    timer = 0;
    blockCollision = 0;
}
