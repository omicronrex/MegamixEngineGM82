#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();

healthpointsStart = 3;
healthpoints = healthpointsStart;
contactDamage = 4;

category = "floating";

grav = 0;
blockCollision = 0;

// Enemy specific code
animTimer = 0;
bulletID = -10;
myGravity = 1;
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();

if (entityCanStep())
{
    // spawn bullet if one doesn't exist
    if (!instance_exists(bulletID))
    {
        bulletID = instance_create(x + 8, y - 4, objGravitronGumball);
        bulletID.grav = myGravity * gravAccel;
        bulletID.yspeed = 1 * myGravity;
        bulletID.image_yscale = myGravity;
        if (myGravity == 1)
        {
            bulletID.y += sprite_height + 4;
        }
    }

    // animation timer
    if (animTimer > -1)
    {
        animTimer -= 1;
    }
    if (animTimer == 0)
    {
        if (image_index == 1)
        {
            image_index = 2;
            myGravity = -1;
        }
        else if (image_index == 3)
        {
            image_index = 0;
            myGravity = 1;
        }
    }

    // detect target's gravity
    if (instance_exists(target))
    {
        if (myGravity == 1 && target.image_yscale == -1 && image_index == 0)
        {
            image_index = 1;
            animTimer = 5;
        }
        if (myGravity == -1 && target.image_yscale == 1 && image_index == 2)
        {
            image_index = 3;
            animTimer = 5;
        }
    }
}
else if (dead)
{
    shooting = false;
    animTimer = 0;
    image_index = 0;
}
