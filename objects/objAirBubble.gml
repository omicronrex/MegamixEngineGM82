#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();

image_speed = 0.15;
vspeed = -1;
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if (!global.frozen)
{
    if (!place_meeting(x, y, objWater))
    {
        instance_destroy();
    }
    else
    {
        if (position_meeting(x, bbox_top - 1 - vspeed, objWater)
            && !position_meeting(x, bbox_top - 1, objWater)
            || place_meeting(x, y, objSolid))
        {
            instance_destroy();
        }
    }
}
#define Other_40
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
instance_destroy();
