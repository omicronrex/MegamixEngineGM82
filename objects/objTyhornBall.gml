#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();
healthpointsStart = 2;
healthpoints = healthpointsStart;

contactDamage = 2;

respawn = false;
animTimer = 10;
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();

if (entityCanStep())
{
    if (image_index != 0)
    {
        animTimer--;
        if (animTimer == 0)
        {
            image_index = 0;
            animTimer = 10;
        }
    }

    if (xcoll != 0)
    {
        image_index = 1;
        xspeed = 2 * image_xscale * -sign(xcoll);
    }

    if (ycoll != 0)
    {
        image_index = 2;
        yspeed = 2 * -sign(ycoll);
    }
}
