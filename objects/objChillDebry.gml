#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();
stopOnFlash = false;
xspeed = 0;
yspeed = -3;
grav = gravAccel;

inWater = 0;
ground = 0;
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if (!global.frozen && !global.timeStopped)
{
    gravityEffect();

    x += xspeed;
    y += yspeed;
}
