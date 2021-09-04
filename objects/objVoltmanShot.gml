#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();

blockCollision = 0;
grav = 0;
stopOnFlash = false;
contactDamage = 3;

canStep = false;
alarm[0] = 1;

xspeed = 0;
yspeed = 0;

reflectable = 0;
#define Alarm_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
canStep = true;
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();

if (!global.frozen)
{
    if (canStep)
    {
        xspeed = image_xscale * 5.5;
    }
}
