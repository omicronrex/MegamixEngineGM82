#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();

if (!global.frozen && !dead && !global.timeStopped)
{
    image_index += 0.2;
    if (instance_exists(lastRail) && lastRail.drop)
        isSolid = 0;
    else
        isSolid = 2;
    if (image_index < 2 - isSolid || image_index >= (2 - isSolid) + 2)
        image_index = 2 - isSolid;
}
