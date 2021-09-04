#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();

// calibrateDirection();

respawn = false;

healthpointsStart = 1;
healthpoints = healthpointsStart;
contactDamage = 3;

grav = 0.22;

image_speed = 0;
image_index = 0;
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();

if (entityCanStep())
{
    if (ground || xspeed == 0)
    {
        instance_create(x, y, objExplosion);
        instance_destroy();
    }
}
