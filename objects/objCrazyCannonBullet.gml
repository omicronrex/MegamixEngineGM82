#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();

blockCollision = 0;

contactDamage = 2;
image_speed = 0;

alarmDie = -2;
xspeed = 0;
yspeed = 0;
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();

if (!global.frozen && !global.timeStopped)
{
    if (alarmDie >= 0)
    {
        alarmDie -= 1;
        if (alarmDie == 0)
        {
            instance_destroy();
        }
    }
}
