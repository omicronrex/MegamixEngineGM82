#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
// Creation code (all optional):

event_inherited();

healthpointsStart = 1;
healthpoints = healthpointsStart;
contactDamage = 4;

category = "cluster, nature, bird";

grav = 0;
blockCollision = 0;

facePlayerOnSpawn = true;

// Enemy specific code
image_speed = 0.2;

sinCounter = 0;
homing = 0;
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();

if (entityCanStep())
{
    if (!homing)
    {
        if (xspeed == 0)
        {
            ys = y;
        }

        xspeed = image_xscale * 1;
        sinCounter += 0.1;
        y = ys - (cos(sinCounter) * 12);
        if (instance_exists(target))
        {
            if (abs(target.x - x) <= 48)
            {
                move_towards_point(target.x, target.y + 8, 3);
                homing = 1;
                xspeed = hspeed;
                hspeed = 0;
                yspeed = vspeed;
                vspeed = 0;
            }
        }
    }
}
else if (dead)
{
    sinCounter = 0;
    homing = 0;
}
