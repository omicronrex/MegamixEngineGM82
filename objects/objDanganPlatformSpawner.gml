#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();

canHit = false;
grav = 0;
blockCollision = 0;
bubbleTimer = -1;

alarmSpawn = 16;
spawnMax = 80;
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();
if (!global.frozen && !dead && !global.timeStopped)
{
    alarmSpawn -= 1;
    if (alarmSpawn <= 0)
    {
        alarmSpawn = spawnMax;
        if (y > view_yview + view_hview * 0.5)
        {
            ysp = -1;
        }
        else
        {
            ysp = 1;
        }
        i = instance_create(x, y + 16 * -ysp, objDanganPlatform);
        i.ysp = ysp;
        i.image_yscale = image_yscale;
    }
}
else if (dead)
{
    // alarmSpawn -= 1
}
#define Draw_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
// No
