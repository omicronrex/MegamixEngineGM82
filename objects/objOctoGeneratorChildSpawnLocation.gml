#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
image_speed = 0;
spawned = false;
child = noone;
spawnDelay = 0;
spawnDelayMax = 96;
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if (instance_exists(child))
{
    spawnDelay = spawnDelayMax + spawnDelayMax / 2;
}



if (spawnDelay > 0 && !global.frozen)
{
    spawnDelay-=1;
}
if (spawnDelay == (spawnDelayMax + spawnDelayMax / 2) - 2)
{
    with (instance_nearest(x, y, objOctoGenerator))
    {
        enemiesDefeated+=1;
    }
}
if (spawnDelay == 0)
{
    spawned = false;
}
#define Draw_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
// nope
