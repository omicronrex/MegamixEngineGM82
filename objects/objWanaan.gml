#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
// A robotic bear trap that activates when players stand on it
event_inherited();
canHit = false;

grav = 0;

shiftVisible = 1;

isSolid = 1;

alarmDrop = -1;
cooldown = 0;
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();

if (!global.frozen && !dead && !global.timeStopped)
{
    if (instance_exists(target))
    {
        if (cooldown)
        {
            cooldown -= 1;
        }
        if (!cooldown)
        {
            if (collision_rectangle(x + 8, y - 4, x + sprite_width - 8, y,
                target, true, true) && !alarmDrop)
            {
                alarmDrop = 30;
            }
        }
    }

    if (alarmDrop)
    {
        alarmDrop -= 1;
        if (!alarmDrop)
        {
            instance_create(x, y - 2, objWanaanChomper);
            cooldown = 25;
        }
    }
}
else if (dead)
{
    alarmDrop = -1;
    cooldown = 0;
}
