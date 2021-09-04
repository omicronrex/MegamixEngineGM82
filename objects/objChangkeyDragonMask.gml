#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();
parent = noone;
contactDamage = 0;
canHit = false;
blockCollision = false;
despawnRange = -1;
grav = 0;
respawn = true;
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();
if (entityCanStep())
{
    if (instance_exists(parent))
    {
        xspeed = parent.xspeed;
        yspeed = parent.yspeed;
        image_xscale = parent.image_xscale;
        x = parent.x; //* image_xscale;
        y = parent.y;
    }
    else
    {
        instance_destroy();
    }
}
