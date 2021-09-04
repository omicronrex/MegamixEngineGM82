#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();

contactDamage = 1;
image_speed = 0;

ground = false;
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();

if (global.frozen == false && global.timeStopped == false)
{
    if (xspeed > 0)
    {
        image_xscale = -1;
    }

    if (ycoll != 0)
    {
        instance_create(x, y, objExplosion);
        instance_destroy();
    }
}
else
{
    image_speed = 0;
}
