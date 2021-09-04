#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
// Spawns Mercury blocks at regular intervals. Intended to be placed near the top of the screen.
event_inherited();
canHit = false;

grav = 0;
blockCollision = 0;
bubbleTimer = -1;

waitTime = 180;
timer = 0;
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();

if ((!global.frozen) && (!dead) && (!global.timeStopped))
{
    timer++;
    if (timer >= waitTime)
    {
        with (instance_create(x, y, objMercuryBlock))
        {
            respawn = false;
        }
        timer = 0;
    }
}
else if (dead)
{
    timer = 0;
}
