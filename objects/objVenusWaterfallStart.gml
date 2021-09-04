#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();
canHit = false;
blockCollision = 0;
grav = 0;
bubbleTimer = -1;

yDist = 0; // Distance to travel before creating waterfall segment
respawn = false;
spawner = noone;
water = instance_create(x, y, objVenusWaterfallSegment);
i = water.id;

despawnRange = -1;
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();
if (entityCanStep())
{
    y += 4;
    yDist += 4;

    if (yDist >= 8)
    {
        if (instance_exists(i))
        {
            i.image_yscale++;
        }
        yDist = 0;
    }

    if !insideSection(x, y)
    {
        instance_destroy();
    }
}
