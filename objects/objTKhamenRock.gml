#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();

canHit = false;
isSolid = true;
blockCollision = false;
parent = noone;
grav = 0;

moveTimer = 30;
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

    if (moveTimer <= 0)
    {
        xspeed = 2 * image_xscale;
    }
}
else if (dead)
{
    instance_destroy();
}
