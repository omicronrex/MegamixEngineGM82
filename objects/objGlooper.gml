#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
// Creation Code (All optional)
// shotMax = <number> // how long Glooper waits before firing.
event_inherited();
respawn = true;
healthpointsStart = 8;
healthpoints = healthpointsStart;
category = "nature";
contactDamage = 2;
facePlayer = true;

// Enemy specific code
animTimer = 0;
animMax = 12;
shotTimer = 0;
shotMax = 16;
shooting = false;
img = 0;
hasFired = false;
bubble = noone;
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();
if (entityCanStep())
{
    animTimer += 1;
    shotTimer += 1;
    if (instance_exists(objGloop))
    {
        shotTimer = 0;
        image_index = 0;
    }

    // if mega man hasn't been glooped and there doesn't exist a gloop bubble, fire.
    if (!instance_exists(objGloop) && !instance_exists(bubble))
    {
        if (shotTimer >= shotMax && image_index == 0 && !hasFired)
        {
            image_index = 1;
            shooting = true;
            animTimer = 0;
        }

        // while image is less than four, increase it
        if (animTimer >= animMax && image_index >= 1 && image_index < 4 && shooting)
        {
            image_index += 1;
            animTimer = 0;
        }

        // if image is equal to four, create gloop bubble.
        if (image_index == 4 && !hasFired)
        {
            animMax = 24; // glooper remains on firing frame for double the length of normal.
            bubble = instance_create(x, y - 8, objGloopBall);
            bubble.xspeed = 2 * image_xscale;
            hasFired = true;
        }
    }
    else // otherwise Glooper cannot fire.
    {
        if (image_index == 0)
        {
            shotTimer = 0;
            shooting = false;
            hasFired = false;
            animMax = 12;
        }
        // image_index = 0;
    }

    // if Glooper has fired, return animation speed to normal and set image to 1.
    if (animTimer >= animMax && image_index == 4)
    {
        animMax = 12;
        image_index = 1;
        shooting = false;
        animTimer = 0;
    }

    // as long as glooper is not firing and has already fired, reduce his image_index until it has been reset.
    if (animTimer >= animMax && image_index >= 0 && !shooting && hasFired)
    {
        image_index -= 1;
        animTimer = 0;
        if (image_index == 0)
            hasFired = false;
    }
}
else if (dead)
{
    image_index = 0;
    animTimer = 5;
    shooting = false;
    hasFired = false;
    actionTimer = 0;
    shotTimer = 0;
}
