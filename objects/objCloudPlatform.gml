#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
// A moving platforms that moves upwards waving horizontally
event_inherited();

grav = 0;
blockCollision = 0;
bubbleTimer = -1;

canHit = false;

isSolid = 2;

image_speed = 0.4;

respawn = false;
alarmTurn = 16;

ysp = -0.5;
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();

if (!global.frozen && !dead && !global.timeStopped)
{
    if (xspeed == 0)
    {
        if (!checkSolid(0, 0))
        {
            xspeed = -0.75;
        }
    }
    else
    {
        alarmTurn -= 1;
        if (alarmTurn <= 0)
        {
            alarmTurn = 32;
            xspeed = -xspeed;
        }
    }

    yspeed = ysp * image_yscale;
}
