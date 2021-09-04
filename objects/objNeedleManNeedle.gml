#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
/// This needle keeps popping in and out on an interval.
// Rotate it in the editor for the multiple directions. It works with all directions.

event_inherited();

healthpointsStart = 1;
healthpoints = healthpointsStart;
isTargetable = false;
contactDamage = 6;

grav = 0;
bubbleTimer = -1;

// Enemy specific code
sprite_index = sprNeedleRight;
mask_index = sprNeedleRight;

active = false;

initialDelay = 0;
waitTimer = 0;
timer = 0;
visible = false;
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();
if (entityCanStep())
{
    if(waitTimer>0)
    {
        waitTimer-=1;
        exit;
    }
    // timer
    timer += 1;
    if (timer == 10)
    {
        if (!visible)
        {
            visible = 1;
            timer = 0;
        }
        else if (image_index == 0)
        {
            image_index = 1;
            timer = 0;
        }
        else if (image_index == 1)
        {
            image_index = 2;
        }
    }
    if (timer == 50)
    {
        if (image_index == 2)
        {
            image_index = 1;
            timer -= 10;
        }
        else if (image_index == 1)
        {
            image_index = 0;
            timer -= 10;
        }
        else if (image_index == 0)
        {
            visible = 0;
            timer = -10;
        }
    }

    // Damage
    canDamage = visible;
}
#define Other_21
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
other.guardCancel = 3;
#define Other_25
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();
if (spawned)
{
    timer = 0;
    waitTimer = initialDelay;
    visible = false;
}
