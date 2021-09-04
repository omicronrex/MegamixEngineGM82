#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();
canHit = false;

isSolid = 1;

blockCollision = 0;
grav = 0;
bubbleTimer = -1;

travel = 4; // in blocks
myFlag = 1;
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();

if (!global.frozen && !dead && !global.timeStopped)
{
    yspeed = (ystart + ((travel * 16) * global.flag[myFlag])) - y;
}
else if (dead)
{
    yspeed = 0;
    x = xstart;
    y = ystart + ((travel * 16) * global.flag[myFlag]);
}
