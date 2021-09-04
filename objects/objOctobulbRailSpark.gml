#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();
imgSpeed = 0.4;
reflectable = false;
blockCollision = false;
isSolid = 0;
contactDamage = 4;
canHit = false;
faction = 3;
canDamage = true;
respawn = false;
parent = noone;
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();

if (entityCanStep())
{
    mySpeed = 3;
    image_index += imgSpeed;
    if (!instance_exists(parent))
    {
        instance_destroy();
    }
    else
    {
        if (instance_exists(parent.body) && place_meeting(x, y, parent.body))
            instance_destroy();
    }
}
else
{
    mySpeed = 0;
}
