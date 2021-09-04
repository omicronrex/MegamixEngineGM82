#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();
blockCollision = 0;
contactDamage = 0;
canHit = false;
grav = 0;
//visible = false;
parent = noone;
respawn = false;
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();
if (entityCanStep())
{
    if (!instance_exists(parent))
    {
        instance_destroy();
    }
}
