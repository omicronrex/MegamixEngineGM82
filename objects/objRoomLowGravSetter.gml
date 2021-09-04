#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();
canHit = false;

frozen = 0;

image_speed = 0;

grav = 0;
blockCollision = 0;
bubbleTimer = -1;

respawnRange = -1;
despawnRange = -1;

gravitySet = 0.4;
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();

if (!dead)
{
    if (instance_exists(objMegaman))
    {
        with (objMegaman)
        {
            gravfactor = other.gravitySet;
        }
    }

    if (instance_exists(objDoncatchDebris))
    {
        with (objDoncatchDebris)
        {
            grav = lowGrav;
        }
    }
}
else
{
    if (instance_exists(objMegaman))
    {
        with (objMegaman)
        {
            gravfactor = 1;
        }
    }

    if (instance_exists(objDoncatchDebris))
    {
        with (objDoncatchDebris)
        {
            grav = 0.75;
        }
    }
}
