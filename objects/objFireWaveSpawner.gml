#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
/// Creates [objFireWave](objFireWave.html), use one of the [objFireWaveGoDirector](objFireWaveGoDirector.html) variants to make a path
event_inherited();

canHit = false;

//@cc interval between fire waves
delay = 90;

timer = 0;

grav = 0;
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();

if (!global.frozen && !dead && !global.timeStopped)
{
    timer += 1;
    if (timer >= delay)
    {
        instance_create(x, y, objFireWave);
        timer = 0;
    }
}
else if (dead)
{
    timer = 0;
}
