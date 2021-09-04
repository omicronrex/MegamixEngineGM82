#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();

respawn = false;

healthpointsStart = 2;
healthpoints = healthpointsStart;
contactDamage = 2;

dir = 1;

xspeed = 1 * dir;

image_speed = 0;
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();

if (entityCanStep())
{
    if (xspeed == 0)
    {
        instance_create(x, y, objExplosion);
        instance_destroy();
    }

    xspeed = 1.2 * dir;
}
else if (dead)
{
    xspeed = 0;
    yspeed = 0;
}
