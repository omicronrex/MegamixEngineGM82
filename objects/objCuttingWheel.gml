#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();

healthpointsStart = 8;
healthpoints = healthpointsStart;
contactDamage = 3;

category = "grounded";

facePlayerOnSpawn = true;

// Enemy specific code
image_speed = 0.3;

action = 0;

maxSpeed = 3;
accel = 0.1;
grav = 0;

if (object_index == objCuttingWheel)
{
    mode = 'forward';
}
if (object_index == objCuttingWheelChase)
{
    mode = 'chase';
}
if (object_index == objCuttingWheelStationary)
{
    mode = 'stationary';
}
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
ys = yspeed;
xs = xspeed;

event_inherited();

if (entityCanStep())
{
    if (ys > 0 && yspeed == 0 && ground)
    {
        action = 2;
        yspeed = -ys * 0.5;
        if (yspeed > -0.25)
        {
            yspeed = 0;
        }
    }
    if (xs > 0 && xspeed == 0)
    {
        xspeed = -xs;
        image_xscale = sign(xspeed);
    }

    if (!action)
    {
        calibrateDirection();
        if (instance_exists(target) && mode != 'stationary')
        {
            if (abs(target.x - x) <= 48)
            {
                action = 1;
                grav = 0.25;
                playSFX(sfxWheelCutter2);
            }
        }
    }
    if (action)
    {
        if (action == 2)
        {
            if (mode == 'chase')
            {
                if (instance_exists(target))
                {
                    calibrateDirection();
                    if (target.x > x)
                    {
                        if (xspeed < maxSpeed)
                        {
                            xspeed += accel;
                        }
                    }
                    else
                    {
                        if (xspeed > -maxSpeed)
                        {
                            xspeed -= accel;
                        }
                    }
                }
            }
            if (mode == 'forward')
            {
                if (image_xscale == 1)
                {
                    if (xspeed < 1)
                    {
                        xspeed += accel;
                    }
                }
                else
                {
                    if (xspeed > -1)
                    {
                        xspeed -= accel;
                    }
                }
            }
        }
    }
}
else if (dead)
{
    action = 0;
}
