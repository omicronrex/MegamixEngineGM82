#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
// loops = [how many times it circles before leaving, -1 will be infinite]

event_inherited();

healthpointsStart = 5;
healthpoints = healthpointsStart;
contactDamage = 2;

category = "cluster, floating";

// Enemy specific code
aim = 1;
shooting = false;
animTimer = 0;
attackTimer = 0;
bulletID = -10;
image_speed = 0.2;

angle = 0;
circle = false;

loops = 5;

blockCollision = 0;
grav = 0;
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
        if (round(x) != round(target.x + cos(((angle + 90) / 180) * pi) * 32)
            || round(y)
            != round(target.y - sin(((angle + 90) / 180) * pi) * 32))
        {
            if (!circle)
            {
                xspeed = max(-2,
                    min((target.x + cos(((angle + 90) / 180) * pi) * 32)
                    - x, 2));
                yspeed = max(-2,
                    min((target.y - sin(((angle + 90) / 180) * pi) * 32)
                    - y, 2));
            }
        }
        else
        {
            circle = true;
        }

        if (circle)
        {
            if (angle < 360 * loops || loops == -1)
            {
                xspeed = 0;
                yspeed = 0;

                x = target.x + cos(((angle + 90) / 180) * pi) * 32;
                y = target.y - sin(((angle + 90) / 180) * pi) * 32;

                angle += 360 / 120;
                if (instance_place(x, y, objRounder))
                {
                    rounder = instance_place(x, y, objRounder);
                    if (rounder.id > id)
                    {
                        angle -= (360 / 120) * 2;
                    }
                }
            }
            else
            {
                xspeed = -2;
            }
        }
    }
}
else if (dead || global.timeStopped)
{
    circle = false;
    angle = 0;
}
