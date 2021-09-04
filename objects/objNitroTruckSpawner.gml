#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();

contactDamage = 0;
canHit = false;

spawn_interval = 190;
spawn_timer = 4;

truckSpeed = 3;
respawnRange = -1;
despawnRange = -1;

blockCollision = 0;
grav = 0;

objectToSpawn = objNitroTruck;
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();

if (entityCanStep())
{
    // determine spawn coords and direction
    var dir; dir = 1;
    if (x > (global.sectionLeft + global.sectionRight) / 2)
        dir = -1;
    var spawn_y; spawn_y = y;
    var spawn_x; spawn_x = global.sectionLeft - 24;
    if (dir == -1)
        spawn_x = global.sectionRight + 24;

    // spawn timer
    spawn_timer -= 1;

    // spawn
    if (spawn_timer <= 0)
    {
        spawn_timer = spawn_interval;
        with (instance_create(x, y, objectToSpawn))
        {
            x = spawn_x;
            y = spawn_y;
            image_xscale = dir;
            respawnRange = -1;
            despawnRange = -1;
            respawn = false;
            spd = other.truckSpeed;
        }
    }
}
else if (dead)
{
    spawn_timer = 2;
}
#define Draw_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
/// no draw
