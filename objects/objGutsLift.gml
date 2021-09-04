#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();
xOffset = 4;
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();

if (!global.frozen && !dead && !global.timeStopped)
{
    // fold out if not solid
    if (!instance_exists(lastRail) || (instance_exists(lastRail) && !lastRail.drop))
    {
        isSolid = 2;
        if (floor(image_index) > 0)
        {
            image_index -= 0.215;
            if (floor(image_index) < 0)
                image_index = 0;
        }
    }
    else
    {
        isSolid = 0;
        if (floor(image_index) < 2)
        {
            image_index += 0.215;
            if (floor(image_index) > 2)
                image_index = 2;
        }
    }
}
