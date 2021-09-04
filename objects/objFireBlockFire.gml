#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();

blockCollision = 0;
grav = 0;
bubbleTimer = -1;

contactDamage = 4;

image_speed = 0.2;

reflectable = 0;

alarmCalm = -2;
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();

if (!global.frozen && !global.timeStopped)
{
    if (alarmCalm >= 0)
    {
        alarmCalm -= 1;
        if (alarmCalm == 0)
        {
            sprite_index = sprFireBeamOff;
        }
    }
}
