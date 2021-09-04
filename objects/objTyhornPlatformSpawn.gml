#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
// creationCode (optional)
// initialDelay = <number> - how many frames to delay the initial spawn.
event_inherited();
canHit = false;

grav = 0;
blockCollision = 0;
bubbleTimer = -1;

waitTime = 180; // 120

initialDelay = 0;
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();

if ((!global.frozen) && (!dead) && (!global.timeStopped))
{
    alarmSpawn -= 1;
    if (alarmSpawn <= 0)
    {
        alarmSpawn = waitTime;
        i = instance_create(x, y - 8, objTyhornPlatform);
    }
}
#define Other_25
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
alarmSpawn = initialDelay;
