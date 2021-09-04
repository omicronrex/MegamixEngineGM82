#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();
despawnRange = -1;
respawn = true;
image_index = 6;
heathpointsStart = 1;
grav = 0;
isTargetable = false;
imgSpd = 0.16;
blockCollision = false;
itemDrop = -1; // Don't drop items
parent = noone;
offsetX = 0;
offsetY = 0;
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();

if (entityCanStep())
{
    // Animation
    image_index += imgSpd;

    if (image_index <= 1)
    {
        image_index = 3;
    }
    else if (image_index >= 4)
    {
        image_index = 2;
    }

    // Movement
    if (instance_exists(parent))
    {
        xspeed = parent.xspeed;
        yspeed = parent.yspeed;
        image_xscale = parent.image_xscale;
        x = parent.x - offsetX * image_xscale;
        y = parent.y - offsetY;
    }
    else
    {
        dead = true;
    }
}
else if (dead)
{
    instance_destroy();
}
#define Other_21
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();
if ((other.object_index == objTornadoBlow) || (other.object_index == objBlackHoleBomb)
    || (other.object_index == objWaterShield) || (other.object_index == objRainFlush))
{
    other.guardCancel = 0;
}
else
{
    other.guardCancel = 2;
}
