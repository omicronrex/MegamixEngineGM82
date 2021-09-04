#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
/// Simple enemy that slowly chases Mega Man.
event_inherited();

grav = 0;
blockCollision = 0;

healthpointsStart = 1;
healthpoints = healthpointsStart;
contactDamage = 3;

category = "cluster";

facePlayer = true;

// Enemy specific code
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
    if (instance_exists(target))
    {
        mp_linear_step(target.x, target.y, 0.5, false);
    }
    else
    {
        x += image_xscale / 2;
    }
}
