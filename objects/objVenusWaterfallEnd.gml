#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();

canHit = false;
blockCollision = false;
grav = 0;
bubbleTimer = -1;

yDist = 0;
respawn = false;

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

    if (yDist == 8)
    {
        if (place_meeting(x, y, objVenusWaterfallSegment))
        {
            with (instance_nearest(x,y,objVenusWaterfallSegment))
            {
                y = other.y + 14;
            }
        }
        yDist = 0;
    }

    if !insideSection(x, y)
    {
        instance_destroy();
    }
}
