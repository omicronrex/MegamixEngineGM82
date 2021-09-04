#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
// Creation code (all optional):
// attackTimerMax = <number> how long Hornet Racer waits for. default is 70.
// image_yscale = 1 or -1 //(Use editor for this!!) // if -1, and placed below where Mega Man will be - Hornet Racer will jump up rather than jump down will go up instead of down at beginning.

event_inherited();
healthpointsStart = 2;
healthpoints = healthpointsStart;
contactDamage = 3;
category = "flying, nature";
blockCollision = 0;
grav = 0;

// Enemy specific code
passedTarget = false;
minusX = 0;
timer = 0;
timerMax = 70;
hasFired = false;
targetX=0;
targetY=0;
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();
if (entityCanStep())
{
    timer += 1;
    if (timer < timerMax) // as long as stationary, animate
    {
        calibrateDirection();
        image_index += 0.125;
        if (image_index == 2)
        {
            image_index = 0;
        }
    }
    else if (!hasFired && target != noone) // divebomb!
    {
        image_index = 2;
        if(instance_exists(target))
        {
            if (image_yscale == 1)
            {
                yspeed = ySpeedAim(y, target.y, -0.25 * image_yscale);
                xspeed = xSpeedAim(x, y, target.x, target.y, yspeed, 0.001);
            }
            else
            {
                yspeed = ySpeedAim(y, target.y - 8, -0.25 * image_yscale);
                xspeed = xSpeedAim(x, y, target.x, target.y-8, yspeed,0.001);
            }
            targetX=target.x;
            targetY=target.y;
        }
        minusX = 0 - xspeed;
        hasFired = true;
    }
    else
    {
        if ((y > ystart && image_yscale == 1) || (y < ystart && image_yscale == -1))
        {
            yspeed -= 0.25 * image_yscale;
        }
        else
        {
            yspeed = 0;
            y = ystart;
        }
        if ((xspeed > 0 && x > targetX) || (xspeed < 0 && x < targetX))
        {
            passedTarget = true;
        }
        if ((xspeed > minusX || xspeed < minusX) && passedTarget)
        {
            xspeed -= (abs(minusX) * 0.10) * image_xscale;
        }
        if (y == ystart && yspeed == 0)
        {
            xspeed = 0;
            hasFired = false;
            timer = 0;
            passedTarget = false;
        }
    }
}
#define Draw_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
var ysc; ysc = image_yscale;
image_yscale = abs(image_yscale);
event_inherited();
image_yscale = ysc;
