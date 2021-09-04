#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();

healthpointsStart = 1;
healthpoints = healthpointsStart;
contactDamage = 2;

category = "cluster, flying";

blockCollision = 0;
grav = 0;

respawn = false;

// Enemy specific code
init = 1;
col = 0;

image_speed = 0.25;
alarmChange = 20;

direction = -1;
speed = 1.5;
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();

if (init)
{
    direction = irandom_range(0, 360);
    init = 0;
    switch (col)
    {
        default:
            sprite_index = sprCopipi;
            break;
        case 1:
            sprite_index = sprCopipiOrange;
            break;
        case 2:
            sprite_index = sprCopipiYellow;
            break;
    }
}

if (entityCanStep())
{
    if (speed == 1.5)
    {
        calibrateDirection();
    }

    if (alarmChange)
    {
        alarmChange -= 1;
        if (!alarmChange)
        {
            speed = 0;
            direction = 0;
            if (instance_exists(target))
            {
                move_towards_point(target.x, target.y, 1.5);
            }
            else
            {
                move_towards_point(xstart, ystart, 1.5);
            }
            xspeed = hspeed;
            yspeed = vspeed;
            speed = 0;
        }
    }
}
