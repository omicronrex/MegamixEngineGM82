#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();
stopOnFlash = false;
blockCollision = 0;
grav = 0;

contactDamage = 6;

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
        yspeed = 5;
    }
}
