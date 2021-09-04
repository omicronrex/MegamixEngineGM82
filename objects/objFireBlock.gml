#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
/// Same as objElecBlock
event_inherited();

isSolid = 1;

grav = 0;
canHit = false;
bubbleTimer = -1;

delay = 0;
zapLength = 60;
waitLength = 60;

alarmAttack = 0;
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();

if (!global.frozen && !dead && !global.timeStopped)
{
    // do not function if it's raining
    if (global.telTelWeather == 1)
    {
        exit;
    }

    // create the actual fire
    if (!place_meeting(x + 16 * image_xscale, y, objFireBlockFire))
    {
        i = instance_create(x + (16 * image_xscale), y, objFireBlockFire);
        i.image_xscale = image_xscale;
    }

    alarmAttack += 1;
    if (alarmAttack >= (waitLength + zapLength))
    {
        i.sprite_index = sprFireBeam;
        i.alarmCalm = zapLength;
        alarmAttack = 0;
    }
}
else if (dead)
{
    alarmAttack = -delay;
}
