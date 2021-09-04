#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();

blockCollision = 0;
grav = 0;
contactDamage = 3;

yspeed = -2.5;

animTimer = 0;
destroyTimer = 15;
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();

if (entityCanStep())
{
    // animation
    animTimer++;

    if (animTimer == 4 && image_index != 2)
    {
        image_index = !image_index;
        animTimer = 0;
    }

    // Die.
    destroyTimer--;

    // "puff out" effect
    if (destroyTimer == 0)
    {
        image_index = 2;
        contactDamage = 0;
        yspeed = 0;
    }

    // actually die now
    if (destroyTimer == -5)
    {
        instance_destroy();
    }
}
