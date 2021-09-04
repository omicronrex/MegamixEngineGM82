#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();
contactDamage = 5;
blockCollision = 0;
grav = 0;
stopOnFlash = false;
spd = 4;
xspeed = 0;
yspeed = spd;
hasFired = false;
delay = 0;
reflectable = false;
calibrateDirection();
image_speed = 0;
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();
if (!global.frozen)
{
    image_index += 0.5;
    if (instance_exists(target))
    {
        if (xspeed == 1)
            xspeed = spd * image_xscale;
        if (!hasFired && yspeed != 0)
        {
            if (abs(y - target.y) <= 4)
            {
                delay = 16;
                yspeed = 0;
                hasFired = true;
            }
        }
        if (!hasFired && xspeed != 0)
        {
            if (abs(x - target.x) <= 4)
            {
                delay = -16;
                xspeed = 0;
                hasFired = true;
            }
        }

        // if delay is greater than 0, its a vertically moving projetile, otherwise its a horizontally moving projectile. either way they should switch polarities
        if (delay > 0)
            delay -= 1;
        if (delay < 0)
            delay += 1;

        // change direction
        if (delay == 1)
            xspeed = spd * image_xscale;
        if (delay == -1 && target.y > y)
            yspeed = spd;
        if (delay == -1 && target.y < y)
            yspeed = -spd;
    }
}
