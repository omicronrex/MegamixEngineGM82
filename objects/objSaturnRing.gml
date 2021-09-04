#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();
respawn = false;
healthpointsStart = 1;
healthpoints = healthpointsStart;
contactDamage = 4;
canHit = false;
blockCollision = 0;
grav = 0.1;
stopOnFlash = false;

// Enemy specific code
yspeed = -4;
setX = 0;
alarm[0] = 1;
collectMe = false;
#define Alarm_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
for (var i = 32; i < 256; i += 1)
{
    if (checkSolid(i * image_xscale, 0, 1, 1))
    {
        break;
    }
    else
    {
        setX += 1;
    }
}
xspeed = xSpeedAim(x, y, x + (setX + 16) * image_xscale, y + 16, yspeed, grav);
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();
if (entityCanStep())
{
    image_index += 0.25;
    if (yspeed > 0)
        collectMe = true;
    if (place_meeting(x, y, objSaturn) && collectMe)
        instance_destroy();
}
