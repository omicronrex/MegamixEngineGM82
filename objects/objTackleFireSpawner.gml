#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
// Creation code (all optional):
// startWait - how long it is until the spawner starts spawning tackle fire sets.
// spawnWait - the wait time between each tackle fire set. using low values (generally below 100) is not recommended.
// spacing - the spacing between each tackle fire within the set.
// num - the number of tackle fires in each set.
// alarmDrop - how long it is until the tackle fires drop down.

event_inherited();

healthpointsStart = 1;
healthpoints = healthpointsStart;
contactDamage = 0;

blockCollision = 0;
grav = 0;

// Enemy specific code
spawnWait = 360;
spacing = 10;
num = 3;
startWait = 0;
alarmDrop = 60;
timer = -1;

canHit = false;
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();

if (entityCanStep())
{
    if (timer == startWait)
    {
        var n; for (n = 0; n < num; n+=1)
        {
            var i; i = instance_create(x, y, objTackleFire);
            i.popDelay = spacing * n;
            i.alarmDrop = alarmDrop + spacing * (num - 1) - (spacing * n);
            i.randomOffset = 1;
            i.respawn = 0;
            i.inWater = inWater;
        }
    }
    if (timer >= startWait + spawnWait)
    {
        timer = startWait - 1;
    }
    timer += 1;
}
else if (dead)
{
    timer = -1;
}
#define Other_21
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
other.guardCancel = 2;
