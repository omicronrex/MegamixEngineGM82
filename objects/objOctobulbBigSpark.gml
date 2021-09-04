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
contactDamage = 4;
canHit = false;
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
    path_speed = 3;
    image_index += imgSpeed;
    if (!instance_exists(parent))
        instance_destroy();
}
else
{
    path_speed = 0;
}
#define Other_8
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
instance_destroy();
