#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
// A spawner of the Top Man tops. It'll spawn one almost immediately, then wait the set interval.

// Creation code (all optional):
// myTopSpeed = <number>. speed of the spawned top in pixels per frame. If not set, it will be either -1 or 1
// depending on where the spawner is placed onscreen.
// waitTime = <number>. self explanatory. the time the spawner will wait after spawning one top. default 224 frames

event_inherited();
canHit = false;

grav = 0;
blockCollision = 0;

alarmSpawn = 16;

myTopSpeed = noone;
waitTime = 224;
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
        alarmSpawn = waitTime;

        if (myTopSpeed == noone)
        {
            if (y > view_yview + view_hview * 0.5)
            {
                myTopSpeed = -1;
            }
            else
            {
                myTopSpeed = 1;
            }
        }

        i = instance_create(x, y + 24 * -sign(myTopSpeed), objTopLift);
        i.yspeed = myTopSpeed;
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
