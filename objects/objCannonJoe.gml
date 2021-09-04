#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();

image_xscale = -1;

healthpointsStart = 6;
healthpoints = healthpointsStart;
contactDamage = 4;
grav = 0;

category = "cannons, joes";

// Enemy specific code
attackTimer = -1;
shooting = false;
bulletID = -10;
canSpin = true;
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();

if (entityCanStep())
{
    // start facing the player
    if (attackTimer == -1)
    {
        calibrateDirection();
    }


    attackTimer += 1;
    if (attackTimer == 6)
    {
        if (image_index == 2 && instance_exists(target))
        {
            if (target.x > x)
            {
                image_xscale = 1;
            }
            else
            {
                image_xscale = -1;
            }

            canSpin = true;
        }
        image_index = 0;
    }

    if (attackTimer == 60)
    {
        if (instance_exists(target))
        {
            if (image_index == 0 && target.y <= y && target.y > y - 32)
            {
                image_index = 1;
                instance_create(x + 21 * image_xscale, y - 2, objCannonjoeBullet);
            }
        }

        attackTimer = 0;
    }


    if (instance_exists(target))
    {
        if (canSpin == 1 && target.y <= y && target.y > y - 32)
        {
            if (image_index == 0 && ((x < target.x && image_xscale == -1)
                || (x > target.x && image_xscale == 1)))
            {
                image_index = 2;
                attackTimer = 0;
                canSpin = 0;
            }
        }
    }
}
else if (dead)
{
    attackTimer = -1;
    shooting = false;
    bulletID = -10;
    canSpin = true;
}
