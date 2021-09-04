#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();

isSolid = 1;
canHit = false;

grav = 0;
blockCollision = 0;
bubbleTimer = -1;

y = view_yview + view_hview - 16;
respawn = false;

respawnRange = -1;
despawnRange = -1;
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();

if (!global.frozen && !dead && !global.timeStopped)
{
    if (y > ystart && yspeed <= 0)
    {
        yspeed = -2;
    }
    else if (y <= ystart)
    {
        yspeed = 0;
        y = ystart;
    }
}
