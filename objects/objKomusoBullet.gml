#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();

blockCollision = 0;
grav = 0;

contactDamage = 4;

canStep = false;
alarm[0] = 1;

image_speed = 0;

xspeed = 0;
yspeed = 0;

angle = 0;

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
        image_index += 0.75;
        xspeed = cos(degtorad(angle)) * 1.5;
        yspeed = -sin(degtorad(angle)) * 1.5;
    }
}
if (!insideView())
    instance_destroy();
