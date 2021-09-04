#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();

blockCollision = 0;
grav = 0;

contactDamage = 5;
image_speed = 0;
faction = 4;

alarmDie = -2;

xspeed = 0;
yspeed = 0;

reflectable = 0;
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();

if (!global.frozen && !global.timeStopped)
{
    if (!place_meeting(x, y, objMadGrinder))
    {
        faction = 3;
    }
    else
    {
        faction = 4;
    }

    image_index += 0.45;
    if (alarmDie >= 0)
    {
        alarmDie -= 1;
        if (alarmDie == 0)
        {
            instance_destroy();
        }
    }
}
