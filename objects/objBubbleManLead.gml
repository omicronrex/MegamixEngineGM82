#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();
stopOnFlash = false;
grav = 0.11;
contactDamage = 4;
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
    if (ground)
    {
        xspeed = 1 * image_xscale;
        yspeed = -3;
    }

    if (xcoll != 0)
    {
        instance_destroy();
    }
}
