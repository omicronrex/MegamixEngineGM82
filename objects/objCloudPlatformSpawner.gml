#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();

grav = 0;
blockCollision = 0;
bubbleTimer = -1;

canHit = false;

alarmSpawn = 16;
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
        alarmSpawn = 144;
        ysp = -1;
        i = instance_create(x, y + 24 * -ysp, objCloudPlatform);
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
