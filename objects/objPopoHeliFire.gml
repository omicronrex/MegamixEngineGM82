#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();
itemDrop = -1;
imgSpeed = 0.4;
moveTimer = 20;
respawn = false;
parent = noone;
grav = 0;
reflectable = true;
contactDamage = 4;
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();

if (entityCanStep())
{
    moveTimer--;
    image_index += imgSpeed;
    if (!instance_exists(parent) || (instance_exists(parent) && parent.dead))
    {
        moveTimer = 0;
    }
    if (moveTimer > 0)
    {
        xspeed = 1.65 * image_xscale;
        if (image_index >= 3)
        {
            image_index = 0;
        }
    }
    else
    {
        xspeed = 0;
        if (image_index < 3)
        {
            image_index = 3;
        }
        if (image_index >= 5)
        {
            instance_destroy();
        }
    }
}
