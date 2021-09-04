#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
// This object can be used in two ways:
//* Pass the xspeed and yspeed
//* Pass destX and destY and make the bullet move in an arc to that point
// These methods can be combined, e.g. set the yspeed to -3 and then make it move to (destX, destY)
// However, always pass grav unless you want the default of 0.25

// If you want to make the bullet stop at solids, make "stopAtSolid" true

event_inherited();

blockCollision = 0;

contactDamage = 2;
image_speed = 0;

grav = 0.25;
xspeed = 0;
yspeed = 0;

destX = -369;
destY = -369;

stopAtSolid = false;

canStep = false;
alarm[0] = 1;
#define Alarm_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if (destX != -369 && destY != -369)
    xspeed = arcCalcXspeed(yspeed, grav, x, y, destX, destY);

canStep = true;
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();

if (!global.frozen && canStep && !global.timeStopped)
{
    if (yspeed > 7)
    {
        yspeed = 7;
    }

    if (stopAtSolid)
    {
        if (checkSolid(0, 0))
        {
            instance_create(x, y, objExplosion);
            instance_destroy();
        }
    }
}
