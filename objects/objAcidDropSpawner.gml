#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
/// Drops acid from ceilings
event_inherited();

grav = 0;
bubbleTimer = -1;

canHit = false;

healthpointsStart = 3;
healthpoints = healthpointsStart;
contactDamage = 4;

// Enemy specific code
animTimer = 0;
shootTimer = -45;
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();

if (entityCanStep())
{
    animTimer += 1;
    if (animTimer == 6)
    {
        animTimer = 0;
        if (image_index == 0)
        {
            image_index = 1;
        }
        else if (image_index == 1)
        {
            image_index = 0;
        }
        else if (image_index == 2)
        {
            image_index = 3;
        }
        else if (image_index == 3)
        {
            image_index = 4;
        }
        else if (image_index == 4)
        {
            image_index = 0;
            i = instance_create(x, y, objAcidDrop);
            if (image_yscale == -1)
            {
                i.image_yscale = -1;
                i.y -= 16;
                i.yspeed = -1;
            }
        }
    }

    shootTimer += 1;
    if (shootTimer == 60)
    {
        image_index = 2;
        shootTimer = -15;
    }
}
else if (dead)
{
    shootTimer = -45;
    animTimer = 0;
    image_index = 0;
}
