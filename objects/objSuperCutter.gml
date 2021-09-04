#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();

blockCollision = 0;
contactDamage = 3;
bubbleTimer = -1;

image_speed = 0.1;

yspeed = -4.8;

calibrateDirection();

if (instance_exists(target))
{
    whereto = target.x - x;
    xspeed = whereto / 48;
}
