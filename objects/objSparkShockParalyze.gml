#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();

image_speed = 0.5;

countdownToDestruction = 180;
plzTarget = noone;
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();

if (!global.frozen)
{
    if (instance_exists(plzTarget))
    {
        if (plzTarget.dead)
        {
            instance_destroy();
        }
        if (!plzTarget.canIce)
        {
            instance_destroy();
        }
        with (objSparkShockParalyze)
        {
            if (other.id != id && other.plzTarget == plzTarget)
            {
                if (other.countdownToDestruction >= countdownToDestruction)
                {
                    instance_destroy();
                }
            }
        }
        countdownToDestruction--;
        if (countdownToDestruction > 0)
        {
            with (plzTarget)
            {
                other.x = bboxGetXCenter();
                other.y = bboxGetYCenter();
            }
        }
        else
        {
            instance_destroy();
        }
    }
    else
    {
        instance_destroy();
    }
}
#define Other_40
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
instance_destroy();
