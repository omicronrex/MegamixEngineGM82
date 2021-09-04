#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();

canHit = false;

shiftVisible = 1;

loops = 6;
wait = 120;

blockCollision = 0;
grav = 0;
bubbleTimer = -1;

looped = 0;
timer = 0;
sprite_index = sprWaveSteam;
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();

if (entityCanStep())
{
    if (timer < wait)
    {
        image_index = 0;
        timer += 1;
    }
    else
    {
        image_index += 0.35;
        if (image_index >= 7 && looped < loops)
        {
            image_index = 3;
            looped += 1;
        }
        else if (image_index <= 1 && looped >= loops)
        {
            image_index = 0;
            timer = 0;
            looped = 0;
        }
    }

    contactDamage = 4 * (image_index >= 1);
}
else if (dead || instance_exists(objSectionSwitcher))
{
    image_index = 0;
    timer = 0;
    looped = 0;
}
