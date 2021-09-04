#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
/// Only active when octobulb is active
event_inherited();
grav = 0;
canHit = false;
blockCollision = false;
isSolid = false;
isVisible = false;
image_speed = 0;
image_index = 0;
myFlag = -1; // If this is changed, octobulb will be ignored and the block will be active when the switch

// with this flag is active
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();
if (entityCanStep())
{
    var active; active = false;
    if (myFlag == -1)
    {
        if (instance_exists(objOctobulb))
        {
            with (objOctobulb)
            {
                if (!dead && canHit)
                {
                    active = true;
                    break;
                }
            }
        }
    }
    else
    {
        if (global.flag[myFlag] > 0)
            active = true;
    }
    if (active)
    {
        isVisible = true;
        if (image_speed == 0)
        {
            image_speed = 0.2;
        }
        if (image_index >= image_number - 1)
        {
            image_speed = 0;
        }
        isSolid = true;
    }
    else
    {
        isSolid = false;
        image_index = 0;
        image_speed = 0;
        isVisible = false;
    }
}
else if (dead)
{
    isSolid = false;
    image_index = 0;
    image_speed = 0;
    isVisible = false;
}
#define Draw_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if (isVisible)
{
    event_inherited();
}
