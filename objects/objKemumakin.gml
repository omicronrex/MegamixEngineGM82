#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();

healthpointsStart = 2;
healthpoints = healthpointsStart;
contactDamage = 0;

category = "floating";

// creation code
back = false;

// Enemy specific code
blockCollision = 0;
grav = 0;

phase = 0;
col = 0;

moveTimer = -2;
cloudTimer = 0;

directionSpd = 0;

image_speed = 0.2;
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();

if (entityCanStep())
{
    if (moveTimer == -2)
    {
        col = choose(random_range(0, 26), random_range(27, 39),
            random_range(41, 53));
        moveTimer = 0;

        // starting direction
        if (instance_exists(target))
        {
            if (target.x < x)
            {
                direction = 180;
            }
            else
            {
                direction = 0;
            }

            if (instance_exists(target))
            {
                if (instance_exists(target.vehicle))
                {
                    if (target.vehicle.x > view_xview
                        && target.vehicle.x < view_xview + view_wview
                        && target.vehicle.y > view_yview
                        && target.vehicle.y < view_yview + view_hview)
                    {
                        if (target.vehicle.object_index == objMegaman8Sled)
                            xspeed = target.vehicle.maxSpeed * target.vehicle.dir;
                        else
                            xspeed = abs(target.vehicle.xspeed) * target.vehicle.image_xscale;
                    }
                }
            }
        }
    }

    if (moveTimer <= 0)
    {
        directionSpd = random_range(-4, 4);
        moveTimer = random_range(10, 50);
    }
    else
    {
        moveTimer -= 1;
    }

    cloudTimer += 1;
    if (cloudTimer >= 13)
    {
        cloudTimer = 0;
        cloud = instance_create(x, y, objKemumakinCloud);
        cloud.col = col;
    }

    speed = 1.6;
    direction += directionSpd;

    if (xspeed == 0)
    {
        if (direction > 90 && direction < 270)
        {
            image_xscale = -1;
        }
        else
        {
            image_xscale = 1;
        }
    }
    else
    {
        if (xspeed < 0)
        {
            image_xscale = -1;
        }
        else
        {
            image_xscale = 1;
        }
    }
}
else if (dead)
{
    moveTimer = -2;
    cloudTimer = 0;
    col = 0;
    xspeed = 0;
    speed = 0;
    direction = 0;
}
