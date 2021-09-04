#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
/// A moving platform that moves in an arc, the distance and its direction an be customized
// note: if you want the platform to not fall, put the next line in the creation code
// sprite_index = sprBrightPlatform
// or
// sprite_index = sprBrightPlatformGreen

// wait = ;
// dir = ; (1 = start on left, -1 start on right)

event_inherited();
canHit = false;

grav = 0;
blockCollision = 0;
bubbleTimer = -1;

isSolid = 2;

respawn = true;

image_speed = 0.2;
offset = 0;

//@cc
wait = 5;

//@cc
distance = 16 * 3;

//@cc
dir = 1;

//@cc
init = 1;

phase = 0;
waitMemory = wait;
startDistance = distance;
startDirection = dir;
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if (init)
{
    init = 0;

    waitMemory = wait;
    startDistance = distance;
    startDirection = direction;

    x = x + (cos(((offset * 360) / 180) * pi) * distance);
    y = (y - 8) - (sin(((offset * 360) / 180) * pi) * distance);

    if (sprite_index != sprBrightPlatformDrop)
    {
        respawnRange = -1;
        despawnRange = -1;
    }
}

event_inherited();

if (!global.frozen && !dead && !global.timeStopped)
{
    if (phase == 0)
    {
        with (target)
        {
            if (place_meeting(x, y + 1, other.id) && ground)
            {
                if (!place_meeting(x, y, other.id))
                {
                    other.phase = 1;
                }
            }
        }
    }
    if (phase != 0)
    {
        if (phase == 1)
        {
            if (offset < 0.5)
                offset += 0.5 / (20 + sin(offset * pi * 2) * 80);
            else
                phase = 2;
        }
        if (phase == 2)
        {
            if (sprite_index == sprBrightPlatformDrop)
            {
                if (yspeed < 0)
                    yspeed = 0;
                yspeed += 0.3;
                xspeed = 0;
            }
            else
            {
                yspeed = 0;
                if (wait > 0)
                    wait -= 1;
                else
                {
                    wait = waitMemory;
                    if (offset > 0)
                        phase = 3;
                    else
                        phase = 1;
                }
            }
        }
        if (phase == 3)
        {
            if (offset > 0)
                offset -= 0.5 / (20 + sin(offset * pi * 2) * 80);
            else
                phase = 2;
        }
    }
    if (phase != 2)
    {
        xspeed = (((xstart + distance * dir)
            + cos((((offset - 0.5) * 360) / 180) * pi)
            * dir * distance)) - x;
        yspeed = ((ystart - 8)
            + abs(sin((((offset - 0.5) * 360) / 180) * pi) * distance)) - y;
    }
}
else if (dead)
{
    phase = 0;
    offset = 0;
}
