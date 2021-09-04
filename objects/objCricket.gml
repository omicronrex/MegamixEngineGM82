#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/


event_inherited();
canHit = false;

grav = 0;
blockCollision = 0;

isSolid = 2;

offset = 0;

dir = image_xscale;

startDir = dir;
init = 1;

//@cc how many hops before heading the other direction, -1 will be infinite)
hops = 3;

startHops = -9999;

phase = 0;
timer = 0;

y -= 3;

active = false;
ground = true;
#define Step_1
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();
if(startHops==-9999)
	startHops = hops;
if (!global.frozen && !dead && !global.timeStopped)
{
    if (phase == 0)
    {
        if (instance_exists(target))
        {
            if (place_meeting(x, y - 1, target) && target.ground
                && !place_meeting(x, y, target))
            {
                active = true;
            }
        }
    }

    if (active)
    {
        timer += 1;
        switch (timer)
        {
            case -9:
                yspeed = 0;
                break;
            case -5:
                image_index = 0;
                yspeed = -5;
                break;
            case -4:
                yspeed = 0;
                break;
            case 10:
                image_index = 1;
                yspeed = 5;
                break;
            case 11:
                yspeed = 0;
                break;
            case 30:
                image_index = 2;
                yspeed = -8;
                playSFX(sfxCricket);
                break;
            case 31:
                yspeed = 0;
                break;
            case 33:
                image_index = 3;
                yspeed = -4 - 5;
                break;
            case 34:
                yspeed += 5;
                break;
        }

        if (timer > 33)
        {
            yspeed += 0.15;
            xspeed = dir;

            while (checkSolid(xspeed, 0))
            {
                xspeed -= dir * 0.1;
            }

            if (yspeed > 0)
            {
                while (checkSolid(0, yspeed))
                {
                    yspeed -= 0.1;
                }
            }
            else
            {
                if (checkSolid(0, yspeed))
                {
                    yspeed = 0;
                }
            }

            if (checkSolid(0, 1))
            {
                xspeed = 0;
                yspeed = 5;
                timer = -10;
                image_index = 1;
                if (hops != -1)
                {
                    hops -= 1;
                }
                if (hops == 0)
                {
                    hops = startHops;
                    dir = -dir;
                }
            }
        }
    }

    image_xscale = dir;
}
else if (dead)
{
    image_index = 0;
    active = false;
}
#define Other_25
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if(spawned)
{
    dir = startDir;
    image_xscale = dir;
    image_index = 0;
    active = false;
    hops = startHops;
}
